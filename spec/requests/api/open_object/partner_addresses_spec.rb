require 'spec_helper'
require 'requests/requests_shared_examples'

describe '/api/open_object/partner_addresses' do
#  include RequestsSpecHelper

  let(:collection_uri) { '/api/open_object/partner_addresses' }
  let(:resource_class) { OpenObject::PartnerAddress }

  it_behaves_like "any API"

end
