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
      get '/intervention_requests', nil, {'HTTP_AUTHORIZATION' => "Token token=\"#{@api_credential.access_token}\""}
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

  describe "POST" do
    def request(data = nil)
      post '/intervention_requests', data, {'HTTP_ACCEPT' => 'application/json', 'HTTP_AUTHORIZATION' => "Token token=\"#{@api_credential.access_token}\""}
    end

    def valid_data
      @valid_data = <<DATA

        {
            "intervention_request":
            {
                "partner_type":4,
            "email_text":"en attente",
            "partner_id":7,
            "partner_address":6,
            "people_name":"",
            "people_phone":"",
            "people_email":"",
            "name":"Create test API",
            "description":"Create test desc",
            "service_id":1,
            "site1":"204",
            "site_details":"rien"
        }
        }
DATA
    end

    it "require authentication" do
      post '/intervention_requests'
      response.code.should eql("401")
    end

    it "send create with params to InterventionRequest" do

      InterventionRequest.should_receive(:create).with(@api_credential.openerp_context, JSON.load(valid_data)[:intervention_request]).and_return({success: true, id: @intervention_request.id})
      request valid_data
    end


    context "sucessfull" do

      def stubbed_intervention_request_create
        InterventionRequest.stub(:create).and_return({success: true, errors: nil, id: @intervention_request.id})
      end


      before(:each) { stubbed_intervention_request_create }

      it "responds with JSON" do
        request valid_data
        response.header['content-type'].should include('application/json')
      end

      it "responds with 200 http status" do
        request valid_data
        response.code.should eq('200')
      end
      it "contains success: true" do
        request valid_data
        JSON.load(response.body)["success"].should eql(true)
      end
      it "contains id field" do
        request valid_data
        JSON.load(response.body)["id"].should eql(@intervention_request.id)
      end
    end

    #
    # TODO : args passed to post are plain ruby, it should be JSON ? suspected to missusing this test case
    #
    context "failure" do
      before(:each) do
        fucked_data
      end

      def fucked_data
        @fucked_data = {"intervention_request" => {"foo" => "bar"}}
      end

      def intervention_request_creation_failure
        InterventionRequest.should_receive(:create).with(@api_credential.openerp_context, @fucked_data["intervention_request"]).and_return({success: false, errors: ["Data screwed"]})
      end

      it "responds with 400 http status" do
        intervention_request_creation_failure
        request fucked_data
        response.code.should eql("400")
      end

      it "contains success : false" do
        intervention_request_creation_failure
        request fucked_data
        JSON.parse(response.body)['success'].should be false
      end

      it "contains errors field" do
        intervention_request_creation_failure
        request fucked_data
        JSON.parse(response.body)['errors'].should_not be(blank?)
      end
    end

  end

end

describe "/intervention_requests/:id" do

  # Set authentication token
  def create_token
    @api_credential = FactoryGirl.create(:api_credential)
  end

  def create_intervention_request
    @intervention_request = FactoryGirl.build_stubbed(:intervention_request)
  end

  # Before each example we ensure that authentication token exists
  before(:each) do
    create_token
    create_intervention_request
  end

  describe "GET" do

    # TODO : HTTP header should be shared between requests definitions to avoid duplication

    # Shortcut method
    def request(data = nil)
      get "/intervention_requests/#{@intervention_request.id}",  data, {'HTTP_ACCEPT' => 'application/json', 'HTTP_AUTHORIZATION' => "Token token=\"#{@api_credential.access_token}\""}
    end

    it "read intervention request with :id" do
      InterventionRequest.should_receive(:find).with(@api_credential.openerp_context, [@intervention_request.id.to_s]).and_return([@intervention_request])
      request
    end

    it "require authentication" do
      get "/intervention_requests/#{@intervention_request.id}"
      response.code.should eql("401")
    end

    context "read is successful" do
      # Shortcut to stub the find method on model and return successful read
      def successful_read_stubbed
        InterventionRequest.stub(:find).with(@api_credential.openerp_context,[@intervention_request.id.to_s]).and_return([@intervention_request])
      end

      before(:each) do
        successful_read_stubbed
        request
      end

      it "render the intervention request" do
        response.body.should include(@intervention_request.to_json)
      end

      it "responds with code 200" do
        response.code.should eql("200")
      end
      it "responds with json" do
        response.header['Content-Type'].should include('application/json')
      end
    end

    context "read fails" do
      # Shortcut method to stub object read failure

      def fail_read_stubbed
        InterventionRequest.stub(:find).with(@api_credential.openerp_context,[@intervention_request.id.to_s]).and_return({error:false})
      end

      before(:each) do
        fail_read_stubbed
        request
      end

      it "responds with 400" do
        response.code.should eql("400")
      end
      it "responds with json" do
        response.header['Content-Type'].should include('application/json')
      end

      it "render hash" do
        JSON.parse(response.body).class.should be Hash
      end

      it "render error message" do
        JSON.parse(response.body).keys.should include('errors')
      end
    end
  end
end