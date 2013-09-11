require 'spec_helper'

describe ApiCredential do

  def set_api_credential
    @api_credential ||= FactoryGirl.create(:api_credential)
  end

  describe "#open_object_context" do
    before(:each) do
      set_api_credential
    end

    it "outputs hash" do
      @api_credential.open_object_context.class.should be Hash
    end

    it "output hash has key uid filled with open_object_uid" do
      @api_credential.open_object_context[:uid].should eql(@api_credential.open_object_uid)
    end
    it "output hash has key pwd filled with open_object_pwd" do
      @api_credential.open_object_context[:pwd].should eql(@api_credential.open_object_pwd)
    end
    it "outpur hash has key dbname filled with open_object_dbname" do
      @api_credential.open_object_context[:dbname].should eql(@api_credential.open_object_dbname)
    end
  end

  describe "process_expiration" do
    it "destroy apicredential where created_at is greater than #{BarakafritesConfig.get["credendtial_expiration_hours"]}" do
      FactoryGirl.create(:api_credential, {:created_at => Time.now - 24.hours})
      ApiCredential.process_expiration
      expect(ApiCredential.count).to eql 0
    end
    it "does not destroy where created_at is greater than #{BarakafritesConfig.get["credendtial_expiration_hours"]}" do
      FactoryGirl.create(:api_credential, {:created_at => Time.now - 10.hours})
      ApiCredential.process_expiration
      expect(ApiCredential.count).to eql 1
    end
  end

end
