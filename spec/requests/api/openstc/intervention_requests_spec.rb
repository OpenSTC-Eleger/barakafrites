require 'spec_helper'
require 'requests/requests_shared_examples'

describe "/api/openstc/intervention_requests" do

  let(:collection_uri) { '/api/openstc/intervention_requests' }
  let(:resource_class) { Openstc::InterventionRequest }

  it_behaves_like "any API"

end