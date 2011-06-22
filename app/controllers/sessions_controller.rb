# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  skip_before_filter :login_required
  skip_before_filter :summary_user_exist?

  # 初期化メソッド（最初に呼ばれる）
  def initialize
    # ページタイトル
    @title = '：要約筆記依頼サービス：みんなのICT'
  end
  
  # ログイン画面
  # session/new:GET
  def new
    # 携帯からのアクセス、かつUIDが送信されている場合
    # リダイレクトループ防止のため、認証NG（login = false）の際は自動ログインしない。
    if request.mobile? && request.mobile.ident_subscriber && params[:login] != 'false'
      if User.find_by_uid(request.mobile.ident_subscriber)
        redirect_back_or_default('/')
      end
    end
    ## ページタイトル
    @title = 'ログイン' + @title

    # Cookieより保存されたメールアドレスを取得する。
    @login = cookies[:login]
  end

  # ログイン処理
  # session/:POST
  def create
    logout_keeping_session!
    user = User.authenticate(params[:users][:email], params[:users][:password])

    # ログイン成功時の処理
    if user        
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      #
      # ログイン情報をセッションに保存する。
      self.current_user = user

      # ログインしたメールアドレスをcookieに保存しておく。
      cookies[:login] = {:value => user.email, :expires => 2.weeks.from_now}
      if !request.mobile?
        new_cookie_flag = (params[:users][:remember_me] == "1")
        handle_remember_cookie! new_cookie_flag
        
      # 携帯からアクセス、かつUIDが送信されている場合
      elsif request.mobile.ident_subscriber
        # UserオブジェクトにUIDを保存する。
        user.uid = request.mobile.ident_subscriber
        user.save
      end
      
      # ホーム画面にリダイレクトする。
      redirect_back_or_default('/')

    # ログイン失敗時の処理
    else
      note_failed_signin
      @login       = params[:users][:email]
      @remember_me = true if params[:users][:remember_me] == "1"
      ## ページタイトル
      @title = 'ログイン：エラー' + @title
      
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_to :controller => 'session', :action => 'new', :login => 'false'
  end

  def no_summary_user
    return
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:email]}'"
    logger.warn "Failed login for '#{params[:email]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
