require 'spec_helper'

describe "Sessions" do

  def stubbed_openerp
    Openerp.stub(:login).and_return({})
    Openerp.stub(:read).and_return({})
    Openerp.stub(:search).and_return({})
  end

  before(:each) { stubbed_openerp }

  describe "Login" do


    context "Success" do

      it "responds with 'application/json' content type" do
        post "/sessions", :login => 'test', :password => 'test', :dbname => 'test'
        expect(response.header['content-type']).to include('application/json')
      end

      it "responds with token" do
        post "/sessions", :login => 'test', :password => 'test', :dbname => 'test'
        last_token = ApiCredential.last.access_token
        expect(response.body).to include("token")
        expect(response.body).to include(last_token)
      end

      it "responds with user menu" do
        post "/sessions", :login => 'test', :password => 'test', :dbname => 'test'
        expect(response.body).to include("menu")
      end


    end

    context "Fail" do
      before(:each) { Openerp.stub(:login).and_return(false) }
      it "responds with 'application/json' content type" do
        post "/sessions", :login => 'test', :password => 'test', :dbname => 'test'
        expect(response.header['content-type']).to include('application/json')
      end

      it "does not respond with token" do
        post "/sessions", :login => 'test', :password => 'test', :dbname => 'test'
        response.body.should_not include("token")
      end


      it "respond with Authentication Failed error" do
        post "/sessions", :login => 'test', :password => 'test', :dbname => 'test'
        JSON.load(response.body)["errors"].should include("Authentication Failed")
      end

    end

  end

end
