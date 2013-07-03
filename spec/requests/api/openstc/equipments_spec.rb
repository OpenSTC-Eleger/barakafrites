require "spec_helper"
## Cedric's Magic File
require 'requests/requests_shared_examples'


describe 'Openstc Equipments API' do

  let(:collection_uri) { '/api/openstc/equipments' }
  let(:resource_class) { Openstc::Equipment }

  it_behaves_like "any API"

end

