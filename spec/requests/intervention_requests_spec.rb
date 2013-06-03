require 'spec_helper'
require 'requests/requests_shared_examples'

describe "/intervention_requests" do
  include RequestsSpecHelper

  ##
  # TODO : Since models are stubbed there are needs to heavy test models and/or enhance stubbing strategies
  #
  def stubbed_model_interface
    @intervention_request = FactoryGirl.build_stubbed(:intervention_request)
    InterventionRequest.stub(:where).and_return([@intervention_request.id])
    InterventionRequest.stub(:find).and_return([@intervention_request])
  end

  before(:each) do
    create_api_credential
    stubbed_model_interface
  end

  describe "GET" do
    def set_request
      @verb = :get
      @uri = '/intervention_requests'
    end
    before(:each) { set_request }

    it_behaves_like "any API request"

    it "is an array" do
      request
      JSON.load(response.body).should be_an Array
    end

    it "contains intervention request" do
      request
      JSON.load(response.body).first["href"].should match(/\/intervention_requests\//)
    end
  end

  describe "POST" do
    def set_request
      @verb = :post
      @uri = '/intervention_requests'
    end
    before(:each) { set_request }


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

    it_behaves_like "any API request"

    it "send create with params to InterventionRequest" do

      InterventionRequest.should_receive(:create).with(@api_credential.openerp_context, JSON.load(valid_data)[:intervention_request]).and_return({success: true, id: @intervention_request.id})
      request valid_data
    end


    context "sucessfull" do

      def stubbed_intervention_request_create
        InterventionRequest.stub(:create).and_return({success: true, errors: nil, id: @intervention_request.id})
      end


      before(:each) { stubbed_intervention_request_create }

      it_behaves_like "any API request"

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

      it_behaves_like "any API request"

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
  include RequestsSpecHelper

  def create_intervention_request
    @intervention_request = FactoryGirl.build_stubbed(:intervention_request)
  end

  def stub_read
    InterventionRequest.stub(:read).and_return([])
  end

  before(:each) do
    stub_read
    create_api_credential
    create_intervention_request
  end

  describe "GET" do

    def set_request
      @verb = :get
      @uri = "/intervention_requests"
      @id = @intervention_request.id
    end

    before(:each) {set_request}

    it "read intervention request with :id" do
      InterventionRequest.should_receive(:find).with(@api_credential.openerp_context, [@intervention_request.id.to_s]).and_return([@intervention_request])
      request
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

      it_behaves_like "any API request"

      it "render the intervention request" do
        response.body.should include(@intervention_request.to_json)
      end

      it "responds with code 200" do
        response.code.should eql("200")
      end
    end

    context "read fails" do
      # Shortcut method to stub object read failure

      it_behaves_like "any API request"

      def fail_read_stubbed
        InterventionRequest.stub(:find).with(@api_credential.openerp_context,[@intervention_request.id.to_s]).and_return({errors:["Blaaaaaammmmmm"]})
      end

      before(:each) do
        fail_read_stubbed
        request
      end

      it "responds with 400" do
        response.code.should eql("400")
      end

      it "render hash" do
        JSON.parse(response.body).class.should be Hash
      end

      it "render error message" do
        JSON.parse(response.body).keys.should include('errors')
      end
    end
  end

  describe "PUT" do

    def set_request
      @verb = :put
      @uri = "/intervention_requests"
      @id = @intervention_request.id
      @data = {'intervention_request' => {'partner_id' => "4"}}
    end

    before(:each) { set_request}

    it "updates InternventionRequest object by :id" do
      InterventionRequest.should_receive(:write).with(@api_credential.openerp_context,[@intervention_request.id.to_s], {'partner_id' => "4"}).and_return({success:true,errors: []})
      request({intervention_request: {partner_id: 4}})
    end

    context "Success" do
      def stub_write_success
        InterventionRequest.stub(:write).with(@api_credential.openerp_context, [@intervention_request.id.to_s], {'partner_id' => "4"}).and_return({success: true, errors:false})
      end

      before(:each) {
        stub_write_success
        request({intervention_request: {partner_id: 4}})

      }

      it_behaves_like "any API request"

      it "responds with 200" do
        response.code.should eql("200")
      end


      it "render {success: true, errors:false}" do
        JSON.parse(response.body)['success'].should be true
        JSON.parse(response.body)['errors'].should be false
      end

    end

    context "Failure" do

      def stub_write_failure
        InterventionRequest.stub(:write).with(@api_credential.openerp_context, [@intervention_request.id.to_s], {'partner_id' => "4"}).and_return({success: false, errors:['message']})
      end

      before(:each) do
        stub_write_failure
        request({intervention_request: {partner_id: 4}})
      end

      it_behaves_like "any API request"

      it "reponds with code 400" do
        response.code.should eql("400")
      end

      it "render {success: false, errors: ['message']}" do
        JSON.parse(response.body)['success'].should be false
        JSON.parse(response.body)['errors'].first.should eql('message')
      end
    end

  end

end