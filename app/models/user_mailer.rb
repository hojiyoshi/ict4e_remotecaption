class UserMailer < ActionMailer::Base
  require 'nkf'
  
  def regist_summary_user(user)
    setup_email(user)
    @subject    += NKF.nkf('-j --cp932 -m0','要約筆記依頼サービスのユーザ登録完了のお知らせ')
  end

=begin
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://YOURSITE/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end
=end
  protected
    def setup_email(user)
      @recipients  = user.email             # 宛先
      # ヘッダーの組み込み定数
      @bcc           = BCC_MAILADDRESS       # BCCメールアドレス
      @charset       = CHARSET               # 文字コード
      @content_type  = CONTENT_TYPE          # Content Type
      @from          = FROM_MAILADDRESS      # 差出人
      @mime_version  = MIME_VERSION          # MIME Version
      @sent_on       = Time.now               # 送信時刻
      @subject       =  NKF.nkf('-j --cp932 -m0',SUBJECT_HEADER)  # 件名
      # 本文の組み込み定数
      @body[:url]    = ICT4E_REMOTECAPTION_URL
      @body[:office] = OFFICE_MAILADDREESS
      @body[:ict4everyone_name] = ICT4E_URL
      @body[:user] = user
    end
end
