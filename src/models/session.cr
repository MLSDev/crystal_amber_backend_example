class Session < Granite::Base
  adapter pg
  table_name sessions

  property password : String?
  property email : String?
  property user_via_email : User?

  field user_id : Int64?
  field token : String
  timestamps

  belongs_to :user

  validate_not_nil :user

  validate :base, "email or password is invalid" do |session|
    next false if session.email.nil? || session.email == ""

    next false if session.password.nil? || session.password == ""

    next false unless session.user_via_email.is_a?(User)

    session.user_via_email.authenticate(session.password.to_s)
  end

  before_create :set_user

  before_create :set_token

  def set_user
    user_via_email ? self.user = user_via_email : nil
  end

  def user_via_email : User
    @user_via_email ||= User.find_by!(email: email)
  end

  def set_token
    self.token ||= Random::Secure.hex
  end
end
