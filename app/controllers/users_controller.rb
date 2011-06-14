class UsersController < ApplicationController
  skip_before_filter :login_required
  skip_before_filter :summary_user_exist?
  
  # 初期化メソッド（最初に呼ばれる）
  def initialize
    # ページタイトル/ナビゲーションタイトルの初期設定
    @title = '：要約筆記依頼サービス：みんなのICT'

    # ナビゲーションタイトルの設定
    @nav_title = ['ユーザー情報登録']
    @nav_controller   = ['users']
    @nav_action   = ['new']
  end

  # render new.rhtml
  def new
    # ページタイトルの設定
    @title = 'ユーザ情報登録' + @title

    # params[:phase]が指定以外の場合、『ユーザ立場選択』画面に戻す。
    if /^(type|user|inputer)$/ !~ params[:phase]
      redirect_to :action => 'new', :phase => 'type'
      return
    end

    # SummaryUserオブジェクトを作成
    @summary_user = SummaryUser.new(params[:summary_user])
    # phaseの状態をSummaryUserオブジェクトに置いておく。
    @summary_user.phase = params[:phase]
    
    # 登録フェーズが『ユーザ立場選択』以外の場合、SummaryUserオブジェクトの検証
    # NGの場合、1つ前の画面に戻す。
    if params[:phase] != 'type'
      # 検証NGの場合
      unless @summary_user.valid?
        # ユーザ立場選択画面を表示
        render :action => 'new' if params[:phase] == 'user'
        render :action => 'new_user' if params[:phase] == 'inputer'
      # 検証OKの場合
      else
        render :action => 'new_user' if params[:phase] == 'user'
        render :action => 'new_inputer' if params[:phase] == 'inputer'
      end
      return
    end
  end

  def confirm
    # ページタイトルの設定
    @title = 'ユーザ情報登録：確認' + @title

    # SummaryUserオブジェクトを作成
    @summary_user = SummaryUser.new(params[:summary_user])
    if @summary_user.valid?
    else
      render :action => 'new_user'
      return
    end
  end

  def create
    logout_keeping_session!
    @user = User.new(params[:user])

    success = @user && @user.save

    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

end
