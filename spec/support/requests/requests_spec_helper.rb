module RequestsSpecHelper

  def create_api_credential
    @api_credential = FactoryGirl.create(:api_credential)
  end

  def anonymous_request
    if @id
      uri = [@uri, @id].join('/')
    else
      uri = @uri
    end
    send(@verb, uri, @data, {HTTP_ACCEPT: 'application/json'})
  end

  def send_set_request(data=nil)
    @data ||= data
    if @id
      uri = [@uri, @id].join('/')
    else
      uri = @uri
    end
    send(@verb, uri, @data, {HTTP_ACCEPT: 'application/json', 'HTTP_AUTHORIZATION' => "Token token=\"#{@api_credential.access_token}\""})
  end

end