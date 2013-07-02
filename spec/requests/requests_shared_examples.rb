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

end