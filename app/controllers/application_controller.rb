# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  # DoCoMo UID取得用
  # DoCoMo携帯からアクセス時は、guid=ONをつける
  docomo_guid
  
  before_filter :login_required
  before_filter :summary_user_exist?
  helper :all # include all helpers, all the time
  #
  # CSRF対策を行う
  protect_from_forgery #:secret => CSRF_KEY

  # cookieが利用できない場合、セッションIDをつける
  trans_sid

  # 携帯からのアクセス時の後処理
  after_filter :set_content_type
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  # ユーザ未登録の場合、登録画面へ飛ばす。
  def summary_user_exist?
    # みんなのICTアカウントが登録されており、要約筆記アカウントが未登録の場合
    if current_user && !current_user.summary_user
      unless request.mobile?
        # ユーザ登録画面へリダイレクトする。
        redirect_to :controller => 'users',:action=> 'new', :phase=>'type'
      else
        redirect_to :controller => 'sessions', :action => 'no_summary_user'
      end
      
      return
    end

  end

  # 携帯電話からのアクセスのアクセスの場合、Content-Typeヘッダーをつけ、
  # 文字コードをSJISにする。
  def set_content_type
    if request.mobile?
      headers["Content-Type"] = "application/xhtml+xml; charset=Shift_JIS"
      response.body = response.body.tosjis 
    end
  end
end
