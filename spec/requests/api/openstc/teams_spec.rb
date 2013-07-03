require "spec_helper"
require 'requests/requests_shared_examples'


describe 'Openstc Teams API' do

  let(:collection_uri) { '/api/openstc/teams' }
  let(:resource_class) { Openstc::Team }

  it_behaves_like "any API"

end

