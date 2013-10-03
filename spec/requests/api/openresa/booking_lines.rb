require "spec_helper" 
## Cedric's Magic File
require 'requests/requests_shared_examples'

describe 'Openresa Booking Line API' do

  let(:collection_uri) { '/api/openresa/booking_lines' }
  let(:resource_class) { Openresa::BookingLine }

  it_behaves_like "any API" 

end