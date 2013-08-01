require "spec_helper"
require 'requests/requests_shared_examples'

describe 'Openstc::SiteCategories API' do

  let(:collection_uri) { '/api/openstc/site_categories' }
  let(:resource_class) { Openstc::SiteCategory }

  it_behaves_like "any API"


end
