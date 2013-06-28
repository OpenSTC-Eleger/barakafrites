require 'spec_helper'

describe 'ApiError' do

  shared_examples_for "any API Error" do
    it "hold error code"
    it "hold error message"
    it "hold backtrace"
  end

  context "Initialize from open_object backend response" do
    let(:backend_response) do
      OpenObject::BackendResponse.new(
          success: false,
          errors: [{faultCode: File.read('spec/data/faultCode.txt'), faultString: File.read('spec/data/faultString.txt')}]
      )
    end

    let(:api_error) {ApiError.new(backend_response)}

    it_behaves_like "any API Error"

    it "fills message with faultCode" do
      api_error.message.should eql backend_response.errors.first[:faultCode]
    end

    it "fills backtrace with faultString" do
      api_error.backtrace.should eql backend_response.errors.first[:faultString]
    end


  end

end