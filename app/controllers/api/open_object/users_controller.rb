class Api::OpenObject::UsersController < ApplicationController


  before_filter :check_authenticated?

  def index
    @fields = params[:fields] || []
    @filters = params[:filters] || []
    @users = OpenObject::User.find_all(user_context, format_filters(@filters), @fields)
    backend_response_to_json @users
  end

  def create
    @user = params[:site]
    @create = OpenObject::User.create(user_context, @user)
    backend_response_to_json @create
  end

  def show
    @site = OpenObject::User.find_one(user_context, params[:id], params[:fields])
    backend_response_to_json @site
  end

  def update
    @attributes = params[:site]
    @update = OpenObject::User.write_one(user_context, params[:id], @attributes)
    backend_response_to_json @update
  end


end