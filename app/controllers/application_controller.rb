# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :login_required
  before_filter :summary_user_exist?
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  # ユーザ未登録の場合、登録画面へ飛ばす。
  def summary_user_exist?
    # みんなのICTアカウントが登録されており、要約筆記アカウントが未登録の場合
    if current_user && !current_user.summary_user
      # ユーザ登録画面へリダイレクトする。
      redirect_to :controller => 'users',:action=> 'new', :phase=>'type'
      return
    end
  end

end
