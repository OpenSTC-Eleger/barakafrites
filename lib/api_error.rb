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