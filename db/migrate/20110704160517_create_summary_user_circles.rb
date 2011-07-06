class CreateSummaryUserCircles < ActiveRecord::Migration
  def self.up
    create_table :summary_user_circles do |t|
      t.column "summary_circle_id",     :integer
      t.column "summary_user_id",       :integer
      t.column "user_type",    :string,      :limit => 1
    end
  end

  def self.down
    drop_table :summary_user_circles
  end
end
