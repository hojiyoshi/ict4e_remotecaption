class CreateSummaryUsers < ActiveRecord::Migration
  def self.up
    create_table "summary_users", :force => true do |t|
      t.column "user_id",           :integer,                :null => false
      t.column "application_type",  :integer,                :null => false
      t.column "phone_contact",     :integer,                :null => false
      t.column "skype_id",          :string,  :limit => 255
      t.column "inputer_flag",      :integer,                :null => false, :default => 0
      t.column "cordinater_flag",   :integer,                :null => false, :default => 0
      t.column "user_flag",         :integer,                :null => false, :default => 0
      t.column "network_env",         :integer
      t.column "network_env_other",   :text
      t.column "input_career",        :integer
      t.column "input_career_other",  :text
      t.column "input_speed",         :integer
      t.column "input_speed_other",   :text
      t.column "join_day_other",      :text
      t.column "join_time_other",     :text
      t.column "like_field_other",    :text
      t.column "dislike_field_other", :text
      t.column "qualification_data",  :text
      t.column "inputer_status",      :integer, :default => 0
    end
    add_index "summary_users", ["user_id"], :name => "summary_users_user_id_key", :unique => true
  end

  def self.down
    remove_index "summary_users", :name => "summary_users_user_id_key"
    drop_table "summary_users"
  end
end
