class UserCreator

  def initialize(user)
    @email = user.email
    @password = user.password_digest
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    # sanitize the params
    if @email.nil? || @password.nil?
      I18n.t('exceptions.auth.field_is_empty')
    elsif Rdb.exists?(key: key)
      I18n.t('exceptions.auth.email_is_taken')
    else
      # save the email in regex hash as well
      Rdb.hash_set(key: key, field: 'password', value: @password)
      # session[:user_email] = @email
      success
    end
  end

  private

  def key
    "user:#{@email}"
  end

  def success
    { status: :ok,
      user: {
        email: @email,
        password: @password
      }
    }
  end
end
