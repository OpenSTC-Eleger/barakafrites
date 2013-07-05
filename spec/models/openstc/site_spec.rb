require 'spec_helper'

describe Openstc::Site do

  subject { Openstc::Site.new }
  it { should respond_to(:service_ids) }
  it { should respond_to(:service_ids=) }
  describe 'service_ids' do
    it 'should be an Array'
  end
  it { should respond_to(:site_parent_id) }
  it { should respond_to(:site_parent_id=) }
  describe 'site_parent_id' do
    it 'should be a Fixnum'
  end
  it { should respond_to(:code) }
  it { should respond_to(:code=) }
  describe 'code' do
    it 'should be a String'
  end
  it { should respond_to(:name) }
  it { should respond_to(:name=) }
  describe 'name' do
    it 'should be a String'
  end
  it { should respond_to(:lenght) }
  it { should respond_to(:lenght=) }
  describe 'lenght' do
    it 'should be a Fixnum'
  end
  it { should respond_to(:width) }
  it { should respond_to(:width=) }
  describe 'width' do
    it 'shoudl be a Fixnum'
  end
  it { should respond_to(:complete_name) }
  it { should respond_to(:complete_name=) }
  describe 'complete_name' do
    it 'should be a String'
  end
  it {should respond_to(:type)}
  it { should respond_to(:type=) }
  describe 'type' do
    it 'should be an Hash'
  end
  it {should respond_to(:id)}
  it {should respond_to(:id=)}
  describe 'id' do
    it'should be a Fixnum'
  end

end
