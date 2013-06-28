class ApiError

  attr_reader :message, :backtrace

  def initialize(object)
    match_object(object)
  end

  private

  def match_object(object)
    case object
      when OpenObject::BackendResponse
      then initialize_from_backend_response(object)
    end
  end

  def initialize_from_backend_response(backend_response)
    @message = backend_response.errors.first[:faultCode]
    @backtrace = backend_response.errors.first[:faultString]
  end

end