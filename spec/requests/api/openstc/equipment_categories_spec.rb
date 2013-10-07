require "spec_helper" 
require 'requests/requests_shared_examples'

describe 'Openstc Equipment Types API' do

  let(:collection_uri) { '/api/openstc/equipment_categories' }
  let(:resource_class) { Openstc::EquipmentCategories }

  it_behaves_like "any API" 

end