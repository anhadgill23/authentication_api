class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email

  # this needs to be done in redis
  validates_uniqueness_of :email
end
