class Api::ResourceController < ApplicationController
  require 'api_controller'

  before_filter :check_authenticated?

end