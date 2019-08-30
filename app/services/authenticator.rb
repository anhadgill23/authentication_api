class Authenticator
  def initialize(user_params)
    @email = user_params[:email]
    @password = user_params[:password]
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    user = find_by_email(key)
    if @email.nil? || @password.nil?
      I18n.t('exceptions.auth.incorrect_combination')
    elsif user.present? && user == @password
      success(email, user)
    else
      I18n.t('exceptions.auth.incorrect_combination')
    end
  end

  private

  def find_by_email(key)
    Rdb.hash_get key: key, field: 'password'
  end

  def key
    "user:#{@email}"
  end

  def success(email, password)
    {
      status: 'ok',
      code: 200,
      user: {
        email: email,
        password: password
      }
    }
  end
end
