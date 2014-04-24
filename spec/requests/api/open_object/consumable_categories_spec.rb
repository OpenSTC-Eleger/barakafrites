require "spec_helper" 
require 'requests/requests_shared_examples'

describe 'Open Object Consumable Types API' do

  let(:collection_uri) { '/api/open_object/consumable_categories' }
  let(:resource_class) { OpenObject::ConsumableCategories }

  it_behaves_like "any API" 

end

