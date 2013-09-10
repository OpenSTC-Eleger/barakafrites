require 'test_helper'

class OpenObjectModelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "OpenObjecModel.arrange_by_order replace false by empty string from order fields" do
    pager_order_params = [{:order => "name DESC"}]
    response = [
      OpenStruct.new( name: 'Aa'),
      OpenStruct.new(name: 'ab'),
      OpenStruct.new(name: false)
    ]
    ordered = OpenObjectModel.arrange_by_order(pager_order_params,response)
    expected = [
        OpenStruct.new(name: 'ab'),
        OpenStruct.new( name: 'Aa'),
        OpenStruct.new(name: "")
    ]
    assert ordered == expected
  end

end
