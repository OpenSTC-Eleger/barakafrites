require "spec_helper"
require 'requests/requests_shared_examples'

describe 'Openstc Intervetions API' do

  let(:collection_uri) { '/api/openstc/interventions' }
  let(:resource_class) { Openstc::Intervention }

  it_behaves_like "any API"

end
