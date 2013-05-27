require 'spec_helper'

describe "/intervention_requests" do

  def create_token
    @api_credential = FactoryGirl.create(:api_credential)
  end

  ##
  # TODO : Since models are stubbed there are needs to heavy test models and/or enhance stubbing strategies
  #
  def stubbed_model_interface
    @intervention_request = FactoryGirl.build_stubbed(:intervention_request)
    InterventionRequest.stub(:where).and_return([@intervention_request.id])
    InterventionRequest.stub(:find).and_return([@intervention_request])
  end

  before(:each) do
    create_token
    stubbed_model_interface
  end

  describe "GET" do

    def request
      get '/intervention_requests', nil,{'HTTP_AUTHORIZATION' => "Token token=\"#{@api_credential.access_token}\""}
    end

    ##
    # TODO : Extract shared tests in shared_exmaples
    #
    it "require authentication" do
      get '/intervention_requests'
      response.code.should eql("401")
    end

    it "respond with json" do
      request
      response.header['content-type'].should include('application/json')
    end

    it "is a array" do
      request
      JSON.load(response.body).should be_an Array
    end

    it "contains intervention request" do
      request
      JSON.load(response.body).first["href"].should match(/\/intervention_requests\//)
    end
  end
end