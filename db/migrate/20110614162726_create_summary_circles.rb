class CreateSummaryCircles < ActiveRecord::Migration
  def self.up
    create_table :summary_circles do |t|
      t.column "circle_name",        :string,    :limit => 255,  :null => false
      t.column "delegate_name",      :string,    :limit => 255
      t.column "circle_url",         :string,    :limit => 255
      t.column "establish_date",     :datetime
      t.column "charge_name",        :string,    :limit => 255
      t.column "charge_email",       :string,    :limit => 100
      t.column "charge_phone",       :string,    :limit => 64
      t.column "action_area",        :string,    :limit => 255
      t.column "circle_introduce",   :text
      t.column "handwriting_flag",   :boolean
      t.column "pcinputing_flag",    :boolean
      t.column "netinputing_flag",   :boolean
      t.column "active_flag",        :boolean,  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :summary_circles
  end
end
