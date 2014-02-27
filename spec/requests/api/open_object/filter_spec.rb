require "spec_helper" 
## Cedric's Magic File
require 'requests/requests_shared_examples'

describe 'Open_object Filters API' do

  let(:collection_uri) { '/api/open_object/filters' }
  let(:resource_class) { OpenObject::Filter }

  it_behaves_like "any API" 

end
