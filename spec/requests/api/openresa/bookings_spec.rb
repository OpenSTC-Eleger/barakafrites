require "spec_helper" 
## Cedric's Magic File
require 'requests/requests_shared_examples'

describe 'Openresa Booking API' do

  let(:collection_uri) { '/api/openresa/bookings' }
  let(:resource_class) { Openresa::Booking }

  it_behaves_like "any API" 

end