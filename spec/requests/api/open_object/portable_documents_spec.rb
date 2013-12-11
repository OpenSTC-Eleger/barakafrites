require 'spec_helper'
require 'requests/requests_shared_examples'

describe '/api/open_object/portable_documents' do
#  include RequestsSpecHelper

  let(:collection_uri) { '/api/open_object/portable_documents' }
  let(:resource_class) { OpenObject::PortableDocument }

  it_behaves_like "any API"

end
