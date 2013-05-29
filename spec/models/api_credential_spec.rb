require 'spec_helper'

describe ApiCredential do

  def set_api_credential
    @api_credential ||= FactoryGirl.create(:api_credential)
  end

  describe "#openerp_context" do
    before(:each) do
      set_api_credential
    end

    it "outputs hash" do
      @api_credential.openerp_context.class.should be Hash
    end

    it "output hash has key uid filled with openerp_uid" do
      @api_credential.openerp_context[:uid].should eql(@api_credential.openerp_uid)
    end
    it "output hash has key pwd filled with openerp_pwd" do
      @api_credential.openerp_context[:pwd].should eql(@api_credential.openerp_pwd)
    end
    it "outpur hash has key dbname filled with openerp_dbname" do
      @api_credential.openerp_context[:dbname].should eql(@api_credential.openerp_dbname)
    end
  end

end
