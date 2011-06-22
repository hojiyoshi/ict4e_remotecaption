# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # 改行コードを含む文字列を出力するための変換メソッド
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end

  # 改良版error_message_forヘルパー
  # みんなのICTフォーマットに合したHTML出力する。
  def template_error_messages_for (object_name, options = {})
    options = options.symbolize_keys
    object = instance_variable_get("@#{object_name}")
    return nil unless object
    unless object.errors.empty?
      render :partial=>"layouts/error_messages_for",
        :locals=>{:messages=>object.errors.full_messages, :object=>object}
    end
  end

  # 複数チェックボックスの値保持用ヘルパー
  def get_check_params(params_array)
    value_list =[]
    ### チェックされたリクエストパラメータを取得する。
    params_array.each_pair {|key,value| value_list.push(key) if value == '1'}
    return value_list
  end

  ### リクエストパラメータにて、複数値を持つものを「、」区切りで返すメソッド
  def render_multiple_value(params_array,target)
    ### 対象となる値を格納する配列を定義
    value_list = get_check_params(params_array)
    ### 該当するモデル値を検索する。
    if target == 'circle_name'
      model_obj = SummaryCircle.find(value_list)
    else
      model_obj = Ict4eMasterDatum.find(value_list)
    end
    
    model_list = []
    ### モデルの返り値から該当データを取得する。
    model_obj.each do |m|
      model_list.push(m[target])
    end
    return model_list.join('、') unless model_list.blank?
  end
end
