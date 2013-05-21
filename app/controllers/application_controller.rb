class ApplicationController < ActionController::Base
#  protect_from_forgery
  helper_method :current_user
  helper_method :user_context
  session :off

  private

  def current_user
    @current_user ||= User.find(user_context, user_context[:uid])
  end

  def set_user_context(credential)
    @user_context = {uid: credential.openerp_uid, pwd: credential.openerp_pwd, dbname: credential.openerp_dbname}
  end

  def user_context
    @user_context
  end

  def api_credential
    @api_credential
  end

  def check_authenticated?
    authenticate_or_request_with_http_token do |token,options|
      if @api_credential = ApiCredential.last(access_token: token)
        @user_context = set_user_context(@api_credential)
      else
        false
      end
    end
  end

end
