class Zed
  #include ModelWithoutTable

  attr_accessor :email, :remember, :password, :login, :id, :reg_from,
                :notifications_count, :blank_password, :token, :fb_token,
                :fb_login, :username, :paypal_accounts

  def is_social?
    raise "IS SOCAIL MUST BE DEPRECATED"
    @is_social
  end

  def has_fb?
    !fb_login.blank?
  end

  alias_method :regFrom=, :reg_from=
  alias_method :fbLogin=, :fb_login=
  alias_method :isPasswordBlank=, :blank_password=
  alias_method :fbToken=, :fb_token=
  alias_method :fbUsername=, :username=
  alias_method :uuid=, :id=

  def migrated
    reg_from == 'savedplus'
  end

  def self.find(uuid)
    @user = User.new
    @user.from_server :get, "users/#{uuid}"
    @user.id = uuid
    @user
  end
end