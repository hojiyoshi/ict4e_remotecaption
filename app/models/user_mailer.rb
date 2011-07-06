class UserMailer < ActionMailer::Base
  require 'nkf'
  
  def regist_summary_user(user)
    setup_email(user)
    @subject    += NKF.nkf('-j --cp932 -m0','要約筆記利用者登録完了のお知らせ')
  end

  def regist_summary_inputer(user)
    setup_email(user)
    @subject    += NKF.nkf('-j --cp932 -m0','要約筆記者登録完了のお知らせ')

    # 表示サークル名を取得
    circle_list = Array.new
    user.summary_user.summary_user_circles.each{|circle|
      circle_list.push(SummaryCircle.find(circle.summary_circle_id))
    }

    circle_name_list = Array.new
    circle_list.each{|circle|
      circle_name_list.push('「'+circle.circle_name+'」')
    }
    @body[:circle] = circle_name_list.join('、')
  end

  # メール本文の文字コードを変換するメソッド
  def create! (*)
    super
    @mail.body = NKF.nkf('-j --cp932 -m0',@mail.body)
    return @mail
  end

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
