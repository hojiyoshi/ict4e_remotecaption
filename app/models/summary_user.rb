class SummaryUser < ActiveRecord::Base
  # 従属関係の定義
  belongs_to :user
  has_many :summary_inputer_joindays
  has_many :summary_inputer_jointimes
  has_many :summary_inputer_likes
  has_many :summary_inputer_dislikes
  has_many :summary_user_circles

  attr_accessor :phase, :c_phase, :circle_list, :joinday_list, :jointime_list, :like_field, :dislike_field

  # 利用者立場の入力チェック
  validate :validate_user_type_flag

  # ユーザ情報登録の入力チェック
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

  # 入力者情報登録の入力チェック
  validates_presence_of :input_career, :if => Proc.new{|p| p.c_phase == 'inputer'}
  validates_presence_of :input_speed, :if => Proc.new{|p| p.c_phase == 'inputer'}

  validate :validate_circle, :if => Proc.new{|p| p.c_phase == 'inputer'}
  validate :validate_joinday, :if => Proc.new{|p| p.c_phase == 'inputer'}
  validate :validate_jointime, :if => Proc.new{|p| p.c_phase == 'inputer'}
  validate :validate_likefield, :if => Proc.new{|p| p.c_phase == 'inputer'}
  validate :validate_dislikefield, :if => Proc.new{|p| p.c_phase == 'inputer'}

  protected
    def validate_user_type_flag
      if user_flag == 0 && inputer_flag == 0
        errors.add(:user_type_flag, 'は、1つ以上チェックを入れてください。')
      end
    end

    def validate_circle
      unless validate_checkboxes(circle_list)
        errors.add(:circle_list,'がチェックされていません。')
      end
    end

    def validate_joinday
      unless validate_checkboxes(joinday_list)
        errors.add(:joinday_list,'がチェックされていません。')
      end
    end

    def validate_jointime
      unless validate_checkboxes(jointime_list)
        errors.add(:jointime_list,'がチェックされていません。')
      end
    end

    def validate_likefield
      unless validate_checkboxes(like_field)
        errors.add(:like_field,'がチェックされていません。')
      end
    end

    def validate_dislikefield
      unless validate_checkboxes(dislike_field)
        errors.add(:dislike_field,'がチェックされていません。')
      end
    end

    def validate_checkboxes(list)
      val = list.values.select{|elem| elem == "0"}
      if list.length == val.length
        return false
      else
        return true
      end
    end
end
