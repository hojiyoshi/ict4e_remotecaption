class UsersController < ApplicationController
  #skip_before_filter :login_required
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

  # users/new?phase=
  # params[:phase]の値で画面を変更する。
  # phase = type:ユーザ種別選択画面 / phase = user:ユーザ登録画面
  # phase = inputer:入力者登録画面
  def new
    # ページタイトルの設定
    @title = 'ユーザー登録' + @title

    # params[:phase]が指定以外の場合、『ユーザ立場選択』画面に戻す。
    if /^(type|user|inputer)$/ !~ params[:phase]
      redirect_to :action => 'new', :phase => 'type'
      return
    end

    # SummaryUserオブジェクトを作成
    @summary_user = SummaryUser.new(params[:summary_user])
    # phaseの状態をSummaryUserオブジェクトに置いておく。
    @summary_user.phase = params[:phase]
    
    # 登録フェーズが『ユーザ立場選択』以外の場合、SummaryUserオブジェクトの検証する。
    # NGの場合、1つ前の画面に戻す。
    if params[:phase] != 'type'
      # 検証NGの場合
      unless @summary_user.valid?
        # ユーザ立場選択　→　ユーザ登録画面に遷移する場合
        # 検証NG時、ユーザ立場選択画面を表示
        render :action => 'new' if params[:phase] == 'user'

        # ユーザ登録画面　→　入力者登録画面に遷移する場合
        # 検証NG時、ユーザ登録画面を表示
        render :action => 'new_user' if params[:phase] == 'inputer'
        
      # 検証OKの場合
      else
        # ユーザ立場選択　→　ユーザ登録画面に遷移する場合
        # 検証OK時、ユーザ登録画面を表示
        render :action => 'new_user' if params[:phase] == 'user'

        # ユーザ登録　→　入力者登録画面に遷移する場合
        # 検証OK時、入力者登録画面を表示
        render :action => 'new_inputer' if params[:phase] == 'inputer'
      end

      # リターンを返し、終了
      return
    end
  end

  # 登録内容確認画面
  # GET:users/confirm?phase=
  # 入力者登録画面からの遷移の場合、phase=inputerが送られる。
  def confirm
    # ページタイトルの設定
    @title = 'ユーザー登録：確認' + @title

    # SummaryUserオブジェクトを作成
    @summary_user = SummaryUser.new(params[:summary_user])

    # 入力者登録画面からの遷移の場合、各値をSummaryUserオブジェクトに置いておく。
    if params[:phase] == 'inputer'
      # 遷移元画面の識別のため、値を代入
      @summary_user.c_phase = params[:phase]

      # チェックボックスの値検証のため、値を代入
      @summary_user.circle_list = params[:summary_user_circle]['circle_list']
      @summary_user.joinday_list = params[:summary_inputer_joinday]['joinday_list']
      @summary_user.jointime_list = params[:summary_inputer_jointime]['jointime_list']
      @summary_user.like_field = params[:summary_inputer_like]['like_field']
      @summary_user.dislike_field = params[:summary_inputer_dislike]['dislike_field']
    end

    # SummaryUserオブジェクトの値検証
    # 検証NGの場合
    unless @summary_user.valid?
      # 入力者登録画面からの遷移の場合
      if @summary_user.c_phase == 'inputer'
        # 入力者登録画面を表示
        render :action => 'new_inputer'
      # ユーザ情報登録画面からの遷移の場合
      else
        # ユーザ情報登録画面を表示
        render :action => 'new_user'
      end
      # 検証OKの場合は、確認画面を表示する。
      return
    end
  end

  # 要約筆記ユーザ情報登録画面
  def create
    # ページタイトルの設定
    @title = 'ユーザー登録：完了' + @title

    # SummryUserオブジェクトを作成する。
    @summary_user = SummaryUser.new(params[:summary_user])

    # 入力者登録を行う場合
    # SummaryInputerXXXXオブジェクトをSummaryUserオブジェクトに1:Nに対応付ける
    if params[:phase] == 'inputer'
      # 参加可能曜日を登録する。
      params[:summary_inputer_joinday]['joinday_list'].keys.each do |m|
        @summary_user.summary_inputer_joindays << SummaryInputerJoinday.new(:joinday_id => m.to_i)
      end
      # 参加可能時間帯を登録する。
      params[:summary_inputer_jointime]['jointime_list'].keys.each do |m|
        @summary_user.summary_inputer_jointimes << SummaryInputerJointime.new(:jointime_id => m.to_i)
      end
      # 得意分野を登録する。
      params[:summary_inputer_like]['like_field'].keys.each do |m|
        @summary_user.summary_inputer_likes << SummaryInputerLike.new(:like_id => m.to_i)
      end
      # 苦手分野を登録する。
      params[:summary_inputer_dislike]['dislike_field'].keys.each do |m|
        @summary_user.summary_inputer_dislikes << SummaryInputerDislike.new(:dislike_id => m.to_i)
      end
      
      # サークルを登録する。
      params[:summary_user_circle]['circle_list'].keys.each do |m|
        @summary_user.summary_user_circles << SummaryUserCircle.new(:summary_circle_id => m.to_i, :user_type => 'i')
      end
    end

    # トランザクション開始
    ActiveRecord::Base.transaction do
      # Userの子オブジェクトとして、SummaryUserオブジェクトを登録する。
      # →ログインユーザオブジェクトに1:1で対応付ける
      # DBに保存する。
      current_user.summary_user = @summary_user

      # DB登録が成功した場合
      unless current_user.summary_user.new_record?
        # 登録完了通知メールを送る。
        UserMailer.deliver_regist_summary_user(current_user)
        # 入力者登録時メールを送る。
        if @summary_user.inputer_flag == 1
          UserMailer.deliver_regist_summary_inputer(current_user)
        end
      end
    end
  end  
end
