class UserCreator
  include Rdb

  def initialize(user)
    @email = user.email
    @password = user.password
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    check_auth_conditions!
  end

  private

  def check_auth_conditions!
    if blank_field?(@email, @password)
      I18n.t('exceptions.auth.field_is_empty')
    elsif password_not_complex?
      I18n.t('exceptions.auth.password_too_short')
    elsif email_taken?
      I18n.t('exceptions.auth.email_is_taken')
    else
      persist_user
    end
  end

  def persist_user
    @password = password_digest(@password)
    Rdb.hash_m_set key, 'email', @email, 'password', @password
    success
  end

  def blank_field?(email, password)
    email.blank? || password.blank?
  end

  def email_taken?
    Rdb.exists?(key)
  end

  def key
    "user:#{@email}"
  end

  def success
    {
      status: :ok,
      user: {
        email: Rdb.hash_get(key, 'email'),
        password: Rdb.hash_get(key, 'password')
      }
    }
  end

  def password_digest(password)
    BCrypt::Password.create(password)
  end

  def password_not_complex?
    return true unless @password.match(/[a-zA-Z0-9]{8,}/)
  end
end
