class User < Granite::Base
  include Crypto

  property password : String?

  adapter pg
  table_name users

  #
  # FIELDS
  #
  field email : String?
  field password_digest : String
  timestamps

  has_many :sessions

  validate_uniqueness :email

  validate_not_nil :email

  before_create :set_password_digest

  validate :password, "cann't be blank" do |user|
    next true unless user.new_record?

    user.password.is_a?(String) && user.password != ""
  end

  def set_password_digest
    self.password_digest = Bcrypt::Password.create(self.password.to_s).to_s
  end

  def authenticate(password : String)
    Crypto::Bcrypt::Password.new(password_digest.to_s) == password
  end
end
