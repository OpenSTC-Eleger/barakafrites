require "spec_helper" 
## Cedric's Magic File
require 'requests/requests_shared_examples'

describe 'OpenObject Meta Data API' do

  let(:collection_uri) { '/api/open_object/meta_datas' }
  let(:resource_class) { OpenObject::MetaData }

  it_behaves_like "any API" 

end
