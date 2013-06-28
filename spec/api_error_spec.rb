require 'spec_helper'

describe 'ApiError' do

  shared_examples_for "any API Error" do
  end

  let(:api_error) {ApiError.new}

  it "hold error code" do
    api_error.should respond_to(:code)
  end
  it "hold error message" do
    api_error.should respond_to(:message)
  end
  it "hold backtrace" do
    api_error.should respond_to(:backtrace)
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

describe 'ErrorCodes' do

  it "sould load definifion from yaml file" do
    ApiError::ErrorCode.list.should eql YAML.load(File.new('config/api_error_codes.yml'))
  end

  it "0 = Unknown" do
    ApiError::ErrorCode.new(0).text.should eql 'Unknown'
  end

end