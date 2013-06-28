class SessionsController < ApplicationController
  def create
    if uid = User.authenticate(params[:dbname],params[:login],params[:password])
      credential = ApiCredential.create(open_object_dbname:params[:dbname], open_object_uid:uid, open_object_pwd:params[:password])
      set_user_context(credential)
      @user = OpenStruct.new( User.find(user_context,uid).first)
      @menu = Menu.fetch(user_context)
      @token = credential.access_token
      respond_to do |format|
        format.json { render :show}
      end
    else
      render :json => {:errors => ['Authentication Failed']}, :status => 401
    end
  end
end
