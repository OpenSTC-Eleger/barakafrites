##
#
# Barakafrites helps openerp 6 to speak REST
#
#    Copyright (C) 2013  Siclic
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##


class ApiError

  attr_reader :message, :backtrace, :code

  # Create a new ApiError with the given object
  #
  # @param [Object] object , if nil or unknown object it initialize an empty ApiError
  # @return [ApiError]
  def initialize(object = nil)
    match_object(object)
  end

  private

  def match_object(object)
    case object
      when OpenObject::BackendResponse
      then initialize_from_backend_response(object)
      else
        initialize_from_nil
    end
  end

  def initialize_from_backend_response(backend_response)
    @message = backend_response.errors.first[:faultCode]
    @backtrace = backend_response.errors.first[:faultString]
  end

  def initialize_from_nil
    @code = nil
    @message = nil
    @backtrace = nil
  end

  class ErrorCode
    @@list = YAML.load(File.new('config/api_error_codes.yml'))

    attr_reader :code,:text

    def initialize(code)
      @code = code.to_s
      @text = @@list[@code]
    end

    def self.list
      @@list
    end


  end


end