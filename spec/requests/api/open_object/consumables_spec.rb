require 'requests/requests_shared_examples'

describe '/api/open_object/consumables' do
#  include RequestsSpecHelper

  let(:collection_uri) { '/api/open_object/consumable' }
  let(:resource_class) { OpenObject::Consumable }

  it_behaves_like "any API"

end


