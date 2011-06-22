class CreateSummaryInputerAttributes < ActiveRecord::Migration
  def self.up
    create_table :summary_inputer_attributes do |t|
      t.column "type",                  :string,    :limit => 255
      t.column "like_id",               :integer
      t.column "dislike_id",            :integer
      t.column "joinday_id",            :integer
      t.column "jointime_id",           :integer
      t.column "summary_circle_id",     :integer
      t.column "summary_user_id",       :integer
    end
  end

  def self.down
    drop_table :summary_inputer_attributes
  end
end
