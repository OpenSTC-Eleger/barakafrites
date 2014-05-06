require "spec_helper" 
## Cedric's Magic File
require 'requests/requests_shared_examples'

describe 'Openpatrimoine Contracts API' do

  let(:collection_uri) { '/api/openpatrimoine/contracts' }
  let(:resource_class) { Openpatrimoine::Contract }

  it_behaves_like "any API" 

end