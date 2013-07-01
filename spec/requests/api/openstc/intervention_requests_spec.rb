require 'spec_helper'
require 'requests/requests_shared_examples'

describe "/api/openstc/intervention_requests" do
  include RequestsSpecHelper

  def root_uri
    '/api/openstc/intervention_requests'
  end
  def stubbed_model_interface
    @intervention_request = FactoryGirl.build_stubbed(:intervention_request)
  end

  before(:each) do
    create_api_credential
    stubbed_model_interface
  end

  describe "GET" do
    def set_request
      @verb = :get
      @uri = root_uri
    end

    before(:each) do
      set_request
      BintjeStub::Search.success_result(klass: InterventionRequest, args: [])
      BintjeStub::Read.success_result(klass: InterventionRequest, fields: [])
      send_set_request
    end

    it_behaves_like "any API request"

    it "is an array" do
      JSON.load(response.body).should be_an Array
    end

    it "contains intervention request" do
      JSON.load(response.body).first["href"].should match(/\/intervention_requests\//)
    end
  end

  describe "POST" do
    let(:request_data) do
      {intervention_request: BintjeStub::Create.default_values}
    end

    def set_request
      @verb = :post
      @uri = root_uri
    end

    before(:each) do
      set_request
      BintjeStub::Create.success_result(klass: InterventionRequest)
      send_set_request request_data
    end


    it_behaves_like "any API request"

    it "send create with params to InterventionRequest" do
      InterventionRequest.should_receive(:create)
      .with(@api_credential.open_object_context, BintjeStub::Create.default_values)
      send_set_request(request_data)
    end


    context "sucessfull" do

      it_behaves_like "any API request"

      it "responds with 200 http status" do
        response.code.should eq('200')
      end

      it "response contains id" do
        JSON.load(response.body)['id'].should eql(BintjeStub::Create.default_result)
      end
    end

    context "failure" do
      before(:each) do
        BintjeStub::Create.fail_result(klass: InterventionRequest, values: BintjeStub::Create.default_values, result: OpenObject::BackendResponse.new(success: false, errors: [{faultCode: "FAILED !!!"}]))
        send_set_request request_data
      end

      it_behaves_like "any API request"

      it_behaves_like "any failed API request"

    end

  end

end

describe "/api/openstc/intervention_requests/:id" do
  include RequestsSpecHelper

  def root_uri
    '/api/openstc/intervention_requests'
  end

  def create_intervention_request
    @intervention_request = FactoryGirl.build_stubbed(:intervention_request)
  end

  before(:each) do
    create_api_credential
    create_intervention_request

  end

  describe "GET" do

    def set_request
      @verb = :get
      @uri = root_uri
      @id = @intervention_request.id
    end

    before(:each) do
      set_request
      BintjeStub::Read.success_result(
          klass: InterventionRequest,
          ids: [@intervention_request.id],
          fields: [],
          result: [{id: @intervention_request.id}])
    end

    it "read intervention request with :id" do
      InterventionRequest.should_receive(:find_one)
      .with(@api_credential.open_object_context, @intervention_request.id.to_s)
      .and_return(OpenObject::BackendResponse.new(success: true, content: [@intervention_request]))
      send_set_request
    end


    context "read is successful" do
      before(:each) do
        send_set_request
      end


      it_behaves_like "any API request"

      it "render the intervention request" do
        response.body.should include("/intervention_requests/#{@intervention_request.id}")
      end

      it "responds with code 200" do
        response.code.should eql("200")
      end
    end

    context "read fails" do
      before(:each) do
        BintjeStub::Read.fail_result(
            klass: InterventionRequest,
            ids: [@intervention_request.id],
            fields: [])
        send_set_request
      end

      it_behaves_like "any API request"

      it_behaves_like "any failed API request"

    end
  end

  describe "PUT" do

    def set_request
      @verb = :put
      @uri = root_uri
      @id = 1
      @data = {'intervention_request' => BintjeStub::Write.default_values}
    end

    before(:each) {
      set_request
      BintjeStub::Write.success_result(klass: InterventionRequest, ids: ["1"])
    }

    it "updates InternventionRequest object by :id" do
      InterventionRequest.should_receive(:write)
      .with(@api_credential.open_object_context, ["1"], BintjeStub::Write.default_values)
      .and_return(OpenObject::BackendResponse.new(success: true, content: BintjeStub::Write.default_result))
      send_set_request
    end

    context "Success" do

      before(:each) do
        send_set_request
        BintjeStub::Write.success_result(klass: InterventionRequest)
      end

      it_behaves_like "any API request"

      it "responds with 200" do
        response.code.should eql("200")
      end

      it "reponse body should contain true" do
        response.body.should eql "true"
      end

    end

    context "Failure" do

      before(:each) do
        BintjeStub::Write.fail_result(klass: InterventionRequest, ids: ["1"])
        send_set_request({intervention_request: {partner_id: 4}})
      end

      it_behaves_like "any API request"

      it_behaves_like "any failed API request"

    end

  end

end