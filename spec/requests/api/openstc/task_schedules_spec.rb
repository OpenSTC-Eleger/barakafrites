require "spec_helper"
require 'requests/requests_shared_examples'

describe 'Openstc Task Schedule API' do

  let(:collection_uri) { '/api/openstc/task_schedules' }
  let(:resource_class) { Openstc::TaskSchedule }

  it_behaves_like "any API"

end
