module RequestsSharedExamples
  include RequestsSpecHelper

  shared_examples_for "any API request" do
    before(:each) do
      create_api_credential
      request
    end

    it "responds with JSON" do
      response.header['Content-Type'].should include('application/json')
    end

    it "responds with Charset UTF-8" do
      response.header['Content-Type'].should include('utf-8')
    end

    context "when not authenticated" do
      before(:each) { anonymous_request }
      it "responds with 401" do
        response.code.should eql("401")
      end
    end

  end

  shared_examples_for "any sucessfull API request" do

  end

end