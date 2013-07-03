require "spec_helper"
require 'requests/requests_shared_examples'

describe 'Openstc Task Categories API' do

  let(:collection_uri) { '/api/openstc/task_categories' }
  let(:resource_class) { Openstc::TaskCategory }

  it_behaves_like "any API"

end
