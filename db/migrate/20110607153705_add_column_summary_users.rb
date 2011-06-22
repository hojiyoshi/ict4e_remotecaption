class AddColumnSummaryUsers < ActiveRecord::Migration
  def self.up
    add_column :summary_users, :name_kanji,       :string,  :limit => 64
    add_column :summary_users, :name_kana,        :string,  :limit => 64
    add_column :summary_users, :phone_number,     :string,  :limit => 50
    add_column :summary_users, :fax_number,       :string,  :limit => 50
    add_column :summary_users, :cellphone_number, :string,  :limit => 50
    add_column :summary_users, :cellphone_email,  :string,  :limit => 100
  end

  def self.down
    remove_column :summary_users, name_kanji
    remove_column :summary_users, name_kana
    remove_column :summary_users, phone_number
    remove_column :summary_users, fax_number
    remove_column :summary_users, cellphone_number
    remove_column :summary_users, cellphone_email
  end
end
