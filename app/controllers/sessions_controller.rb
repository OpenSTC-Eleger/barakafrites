class SessionsController < ApplicationController
  def create
    if uid = OpenObject::User.authenticate(params[:dbname],params[:login],params[:password])
      credential = ApiCredential.create(open_object_dbname:params[:dbname], open_object_uid:uid, open_object_pwd:params[:password])
      set_user_context(credential)
      @user = OpenObject::User.find_one(user_context,uid,['menu_id'])
      @menu = OpenObject::Menu.fetch(user_context)
      @token = credential.access_token
      respond_to do |format|
        format.json { render :show}
      end
    else
      render :json => {:errors => ['Authentication Failed']}, :status => 401
    end
  end
end
