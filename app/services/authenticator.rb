class Authenticator
  include Rdb

  def initialize(user_params)
    @email = user_params[:email]
    @password = user_params[:password]
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    check_auth_conditions!
  end

  private

  def check_auth_conditions!
    email = Rdb.hash_get key, 'email'
    password = Rdb.hash_get key, 'password'

    if blank_field?(@email, @password)
      I18n.t('exceptions.auth.field_is_empty')
    elsif match?(email, password)
      success(email, password)
    else
      I18n.t('exceptions.auth.incorrect_combination')
    end
  end

  def blank_field?(email, password)
    email.blank? || password.blank?
  end

  def match?(email, password)
    email.present? && matches_password?(password)
  end

  def matches_password?(password)
    BCrypt::Password.new(password) == @password
  end

  def key
    "user:#{@email}"
  end

  def success(email, password)
    {
      status: :ok,
      user: {
        email: email,
        password: password
      }
    }
  end
end
