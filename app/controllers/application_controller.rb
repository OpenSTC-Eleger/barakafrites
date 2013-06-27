class ApplicationController < ActionController::Base
#  protect_from_forgery
  helper_method :current_user
  helper_method :user_context
  session :off


  def backend_response_to_json(bintje_response)
    if bintje_response.success
      respond_to do |format|
        format.json {render :json => bintje_response.content}
      end
    else
      respond_to do |format|
        format.json {render :json => bintje_response.errors, :status => 400}
      end
    end
  end


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
      if @api_credential = ApiCredential.find_last_by_access_token(token)
        set_user_context(@api_credential)
      else
        false
      end
    end
  end

end
