module RequestsSharedExamples
  include RequestsSpecHelper

  shared_examples_for "any API request" do

    it "responds with JSON" do
      response.header['Content-Type'].should include('application/json')
    end

    it "responds with Charset UTF-8" do
      response.header['Content-Type'].should include('utf-8')
    end

    it 'responds with status code 200' do
      response.code.should eql "200"
    end

    context "when not authenticated" do
      before(:each) { anonymous_request }
      it "responds with 401" do
        response.code.should eql("401")
      end
    end

  end

  shared_examples_for "any failed API request" do

    it "responds with JSON" do
      response.header['Content-Type'].should include('application/json')
    end

    it "responds with Charset UTF-8" do
      response.header['Content-Type'].should include('utf-8')
    end

    it "responds with 400" do
      response.code.should eql("400")
    end

    it "render Array of Errors" do
      JSON.parse(response.body).class.should be Array
    end

    it "Error is a hash" do
      JSON.parse(response.body).first.should be_an Hash
    end

    it "Error Hash include faultCode" do
      JSON.parse(response.body).first.keys.should include 'faultCode'
    end

  end


  shared_examples_for "any API collection" do
    include RequestsSpecHelper

    before(:each) do
      @uri = collection_uri
    end

    describe 'GET' do
      before(:each) do
        @verb = 'get'
        create_api_credential
        filters_params = BintjeStub::Search.default_args.map { |fs| {field: fs[0], operator: fs[1], value: fs[2]} }
        @data = {filters: filters_params, fields: ['name']}
      end

      context "success" do
        before(:each) do
          BintjeStub::Search.success_result klass: resource_class
          BintjeStub::Read.success_result klass: resource_class
          send_set_request()
        end
        it_behaves_like "any API request"
      end

      context 'failure' do
        before(:each) do
          BintjeStub::Search.fail_result klass: resource_class
          send_set_request()
        end

        it_behaves_like "any failed API request"
      end
    end

    describe 'POST' do
      before(:each) do
        create_api_credential
        @verb = 'post'
        @data = {resource_class.name.split('::').last.underscore.to_sym => BintjeStub::Create.default_values}
      end
      let(:contextual_response) { send_set_request }

      context 'success' do
        before(:each) do
          BintjeStub::Create.success_result klass: resource_class
          contextual_response
        end


        it_behaves_like "any API request"

      end

      context 'failure' do
        before(:each) do
          BintjeStub::Create.fail_result klass: resource_class
          contextual_response
        end

        it_behaves_like "any failed API request"

      end

    end

  end

  shared_examples_for "any API resource" do
    include RequestsSpecHelper

    before(:each) do
      @uri = collection_uri
      @id = 2
      create_api_credential
    end

    # GET With params
    describe 'GET' do
      before(:each) do
        @verb = 'get'
        @data = {fields: ['name']}
      end

      context 'success' do
        before(:each) do
          BintjeStub::Read.success_result klass: resource_class, ids: [2]
          send_set_request
        end

        it_behaves_like "any API request"
      end

      context 'failure' do
        before(:each) do
          BintjeStub::Read.fail_result klass: resource_class, ids: [2]
          send_set_request
        end

        it_behaves_like "any failed API request"

      end

    end

    # PUT update Site with params
    describe 'PUT' do
      before(:each) do
        @verb = 'put'
        @data = {resource_class.name.split('::').last.underscore.to_sym =>  {name: 'one'}}
      end

      context 'success' do
        before(:each) do
          BintjeStub::Write.success_result klass: resource_class, ids: [2]
          send_set_request
        end

        it_behaves_like "any API request"

      end

      context 'failure' do
        before(:each) do
          BintjeStub::Write.fail_result klass: resource_class, ids: [2]
          send_set_request
        end

        it_behaves_like "any failed API request"

      end

    end

  end


  shared_examples_for "any API" do

    #@collection_uri = collection_uri

    describe "Collection URI" do

      it_behaves_like "any API collection"
    end

    describe "Resource URI" do

      it_behaves_like "any API resource"
    end

  end

end


