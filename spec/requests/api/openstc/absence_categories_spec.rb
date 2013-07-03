require "spec_helper"
require 'requests/requests_shared_examples'

describe 'Openstc Absence Categories API' do

  let(:collection_uri) { '/api/openstc/absence_categories' }
  let(:resource_class) { Openstc::AbsenceCategory }

  it_behaves_like "any API"

end
