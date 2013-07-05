require "spec_helper"
require 'requests/requests_shared_examples'

describe 'Openstc::Departments API' do

  let(:collection_uri) { '/api/openstc/departments' }
  let(:resource_class) { Openstc::Department }

  it_behaves_like "any API"


end
