require 'spec_helper'
require 'requests/requests_shared_examples'

describe '/api/open_object/partner_types' do
#  include RequestsSpecHelper

  let(:collection_uri) { '/api/open_object/partner_types' }
  let(:resource_class) { OpenObject::PartnerType }

  it_behaves_like "any API"

end
