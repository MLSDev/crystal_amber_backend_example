class User < Granite::Base
  adapter pg
  table_name users

  #
  # FIELDS
  #
  field email : String

  # id : Int64 primary key is created for you
  timestamps

  validate_uniqueness :email
end
