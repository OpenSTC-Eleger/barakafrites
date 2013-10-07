require "spec_helper"
require 'requests/requests_shared_examples'

describe 'Openstc Sites API' do

  let(:collection_uri) { '/api/openstc/sites' }
  let(:resource_class) { Openstc::Site }

  it_behaves_like "any API"

end
