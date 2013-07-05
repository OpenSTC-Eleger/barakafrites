require "spec_helper"
require 'requests/requests_shared_examples'

describe 'Openstc Intervention Categories API' do

  let(:collection_uri) { '/api/openstc/intervention_categories' }
  let(:resource_class) { Openstc::InterventionCategory }

  it_behaves_like "any API"


end
