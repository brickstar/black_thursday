require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_it_loads_files
    skip
    se = SalesEngine.from_csv( { :items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",
                                } )
  end
end
