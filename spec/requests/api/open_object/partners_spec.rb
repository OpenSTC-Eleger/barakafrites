require 'spec_helper'
require 'requests/requests_shared_examples'

describe '/api/open_object/partners' do
#  include RequestsSpecHelper

  let(:collection_uri) { '/api/open_object/partners' }
  let(:resource_class) { OpenObject::Partner }

  it_behaves_like "any API"

end
