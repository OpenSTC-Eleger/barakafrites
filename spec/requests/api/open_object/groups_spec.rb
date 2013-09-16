require 'spec_helper'
require 'requests/requests_shared_examples'

describe '/api/open_object/groups' do


  let(:collection_uri) { '/api/open_object/groups' }
  let(:resource_class) { OpenObject::Group }

  it_behaves_like "any API"

end
