class HomeController < ApplicationController
  
  # 初期化メソッド（最初に呼ばれる）
  def initialize
    # ページタイトル/ナビゲーションタイトルの初期設定
    @title = '：要約筆記依頼サービス：みんなのICT'

    # ナビゲーションタイトルの設定
    @nav_title = ['ホーム']
    @nav_controller   = ['home']
    @nav_action   = ['index']
  end
  
  def index
   @title = 'ホーム' + @title
   if request.mobile?
     render 
   end
  end
end
