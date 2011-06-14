class SummaryUser < ActiveRecord::Base
  # 従属関係の定義
  belongs_to :user

  attr_accessor :phase

  # 利用者立場の入力チェック
  validate :validate_user_type_flag
  # 入力必須項目
  validates_presence_of :name_kanji,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_presence_of :name_kana,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_presence_of :phone_number,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_presence_of :phone_contact,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_presence_of :application_type,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}

  # 
  # length_ofはnilを通さないので、phase値を検証実行条件としておく。
  validates_length_of :name_kanji,:maximum => 50,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_length_of :name_kana,:maximum => 50,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_length_of :phone_number,:maximum => 15,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_length_of :fax_number,:maximum => 15,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_length_of :cellphone_number,:maximum => 15,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_length_of :cellphone_email,:maximum => 100,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}
  validates_length_of :skype_id,:maximum => 100,
    :if => Proc.new{|p| p.phase != 'type' && p.phase != 'user'}

  validates_format_of       :cellphone_email,
    :with => /^([a-zA-Z0-9])+([a-zA-Z0-9\._-])*@([a-zA-Z0-9_-])+([a-zA-Z0-9\._-]+)+$/,
    :if => Proc.new {|p| !p.cellphone_email.blank?}
  

  protected
    def validate_user_type_flag
      if user_flag == 0 && inputer_flag == 0
        errors.add(:user_type_flag, 'は、1つ以上チェックを入れてください。')
      end
    end
end
