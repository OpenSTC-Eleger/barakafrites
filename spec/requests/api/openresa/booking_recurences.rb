require "spec_helper" 
## Cedric's Magic File
require 'requests/requests_shared_examples'

describe 'Openresa booking recurrences API' do

  let(:collection_uri) { '/api/openresa/booking_recurrences' }
  let(:resource_class) { Openresa::BookingRecurrence }

  it_behaves_like "any API" 

end
