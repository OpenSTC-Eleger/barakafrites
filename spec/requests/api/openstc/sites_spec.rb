require 'spec_helper'
require 'requests/requests_shared_examples'

describe '/api/openstc/sites' do
  include RequestsSpecHelper

  before(:each) do
    @uri = '/api/openstc/sites'
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
        BintjeStub::Search.success_result klass: Openstc::Site
        BintjeStub::Read.success_result klass: Openstc::Site
        send_set_request()
      end
      it_behaves_like "any API request"
    end

    context 'failure' do
      before(:each) do
        BintjeStub::Search.fail_result klass: Openstc::Site
        send_set_request()
      end

      it_behaves_like "any failed API request"
    end
  end

  describe 'POST' do
    before(:each) do
      create_api_credential
      @verb = 'post'
      @data = {site: BintjeStub::Create.default_values}
    end
    let(:contextual_response) { send_set_request }

    context 'success' do
      before(:each) do
        BintjeStub::Create.success_result klass: Openstc::Site
        contextual_response
      end


      it_behaves_like "any API request"

    end

    context 'failure' do
      before(:each) do
        BintjeStub::Create.fail_result klass: Openstc::Site
        contextual_response
      end

      it_behaves_like "any failed API request"

    end

  end

end

describe '/api/openstc/sites/:id' do
  include RequestsSpecHelper

  before(:each) do
    @uri = '/api/openstc/sites'
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
        BintjeStub::Read.success_result klass: Openstc::Site, ids: [2]
        send_set_request
      end

      it_behaves_like "any API request"
    end

    context 'failure' do
      before(:each) do
        BintjeStub::Read.fail_result klass: Openstc::Site, ids: [2]
        send_set_request
      end

      it_behaves_like "any failed API request"

    end

  end

  # PUT update Site with params
  describe 'PUT' do
    before(:each) do
      @verb = 'put'
      @data = {site: {name: 'one'}}
    end

    context 'success' do
      before(:each) do
        BintjeStub::Write.success_result klass: Openstc::Site, ids: [2]
        send_set_request
      end

      it_behaves_like "any API request"

    end

    context 'failure' do
      before(:each) do
        BintjeStub::Write.fail_result klass: Openstc::Site, ids: [2]
        send_set_request
      end

      it_behaves_like "any failed API request"

    end

  end


end