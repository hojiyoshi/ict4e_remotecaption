require 'digest/sha1'

class User < ActiveRecord::Base
  # 従属関係の定義
  # 親オブジェクト削除時に子オブジェクトも削除する。
  has_one :summary_user, :dependent => :destroy

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  #before_create :make_activation_code

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :name, :password, :password_confirmation,:crypted_password,:salt,:activated_at


  # Activates the user in the database.
  #def activate!
  #  @activated = true
  #  self.activated_at = Time.now.utc
  #  self.activation_code = nil
  #  save(false)
  #end

  # Returns true if the user has just been activated.
  #def recently_activated?
  #  @activated
  #end

  #def active?
    # the existence of an activation code means they have not activated yet
  #  activation_code.nil?
  #end
  
  #def recently_activated?
  #  @activated
  #end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
     u = find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email] # need to get the salt
     u && u.authenticated?(password) ? u : nil
    u = find_by_email(email.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
end
