# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Ict4eMasterDatum.delete_all

ict4e_master_data = [
  {:id => 100, :application_name => 'application_type', :item_data => '健常者', :sort_order => '100'},
  {:id => 200, :application_name => 'application_type', :item_data => '聴覚障害者', :sort_order => '200'},
  {:id => 300, :application_name => 'application_type', :item_data => '話者', :sort_order => '300'},
  {:id => 400, :application_name => 'application_type', :item_data => '主催者', :sort_order => '400'},
  {:id => 500, :application_name => 'application_type', :item_data => 'その他', :sort_order => '500'},
  {:id => 1000, :application_name => 'phone_contact', :item_data => '電話連絡は可', :sort_order => '100'},
  {:id => 1100, :application_name => 'phone_contact', :item_data => '電話連絡は不可', :sort_order => '200'},
  {:id => 2000, :application_name => 'input_career', :item_data => '養成講座受講中', :sort_order => '100'},
  {:id => 2100, :application_name => 'input_career', :item_data => '0～1年', :sort_order => '200'},
  {:id => 2200, :application_name => 'input_career', :item_data => '1～2年', :sort_order => '300'},
  {:id => 2300, :application_name => 'input_career', :item_data => '2～3年', :sort_order => '400'},
  {:id => 2400, :application_name => 'input_career', :item_data => '3～4年', :sort_order => '500'},
  {:id => 2500, :application_name => 'input_career', :item_data => '5年以上', :sort_order => '600'},
  {:id => 3000, :application_name => 'input_speed', :item_data => '80字未満', :sort_order => '100'},
  {:id => 3100, :application_name => 'input_speed', :item_data => '80～100字', :sort_order => '200'},
  {:id => 3200, :application_name => 'input_speed', :item_data => '100～120字', :sort_order => '300'},
  {:id => 3300, :application_name => 'input_speed', :item_data => '120～140字', :sort_order => '400'},
  {:id => 3400, :application_name => 'input_speed', :item_data => '140～160字', :sort_order => '500'},
  {:id => 3500, :application_name => 'input_speed', :item_data => '180字以上', :sort_order => '600'},
  {:id => 4000, :application_name => 'join_day', :item_data => '月曜', :sort_order => '100'},
  {:id => 4100, :application_name => 'join_day', :item_data => '火曜', :sort_order => '200'},
  {:id => 4200, :application_name => 'join_day', :item_data => '水曜', :sort_order => '300'},
  {:id => 4300, :application_name => 'join_day', :item_data => '木曜', :sort_order => '400'},
  {:id => 4400, :application_name => 'join_day', :item_data => '金曜', :sort_order => '500'},
  {:id => 4500, :application_name => 'join_day', :item_data => '土曜', :sort_order => '600'},
  {:id => 4600, :application_name => 'join_day', :item_data => '日曜', :sort_order => '700'},
  {:id => 5000, :application_name => 'join_time', :item_data => '9時～12時', :sort_order => '100'},
  {:id => 5100, :application_name => 'join_time', :item_data => '12時～15時', :sort_order => '200'},
  {:id => 5200, :application_name => 'join_time', :item_data => '15時～18時', :sort_order => '300'},
  {:id => 5300, :application_name => 'join_time', :item_data => '18時～21時', :sort_order => '400'},
  {:id => 5400, :application_name => 'join_time', :item_data => 'その他', :sort_order => '500'},
  {:id => 6000, :application_name => 'adapt_field', :item_data => '福祉', :sort_order => '100'},
  {:id => 6100, :application_name => 'adapt_field', :item_data => '医療', :sort_order => '200'},
  {:id => 6200, :application_name => 'adapt_field', :item_data => '法律', :sort_order => '300'},
  {:id => 6300, :application_name => 'adapt_field', :item_data => '教育', :sort_order => '400'},
  {:id => 6400, :application_name => 'adapt_field', :item_data => 'コンピュータ', :sort_order => '500'},
  {:id => 6500, :application_name => 'adapt_field', :item_data => 'スポーツ', :sort_order => '600'},
  {:id => 6600, :application_name => 'adapt_field', :item_data => '政治', :sort_order => '700'},
  {:id => 6700, :application_name => 'adapt_field', :item_data => '経済', :sort_order => '800'},
  {:id => 6800, :application_name => 'adapt_field', :item_data => '芸能', :sort_order => '900'},
  {:id => 6900, :application_name => 'adapt_field', :item_data => '地域情報', :sort_order => '1000'},
  {:id => 7000, :application_name => 'adapt_field', :item_data => '聴覚障害', :sort_order => '1100'},
  {:id => 7100, :application_name => 'adapt_field', :item_data => 'その他', :sort_order => '1200'},
  {:id => 8000, :application_name => 'network_env', :item_data => '光ファイバ', :sort_order => '100'},
  {:id => 8100, :application_name => 'network_env', :item_data => 'ADSL', :sort_order => '100'},
  {:id => 8200, :application_name => 'network_env', :item_data => 'CATV', :sort_order => '200'},
  {:id => 8300, :application_name => 'network_env', :item_data => '無線LAN', :sort_order => '300'},
  {:id => 8400, :application_name => 'network_env', :item_data => 'モバイル回線（イーモバイル、WiMAXなど）', :sort_order => '400'},
  {:id => 8500, :application_name => 'network_env', :item_data => 'ISDN、ダイアルアップ回線', :sort_order => '500'},
  {:id => 8600, :application_name => 'network_env', :item_data => 'その他', :sort_order => '600'},
  {:id => 8700, :application_name => 'network_env', :item_data => 'その他', :sort_order => '700'}
]
ict4e_master_data.each do |item|
  Ict4eMasterDatum.create(:id => item[:id], :application_name => item[:application_name], :item_data => item[:item_data], :sort_order => item[:sort_order])
end
