require "spec_helper" 
## Cedric's Magic File
require 'requests/requests_shared_examples'

describe 'Openresa Bookables API' do

  let(:collection_uri) { '/api/openresa/bookables' }
  let(:resource_class) { Openresa::Bookable }

  it_behaves_like "any API" 

end