require_relative 'test_helper'
require './lib/sales_engine'


class InvoiceRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( { :items     => './test/fixtures/items_truncated.csv',
                                  :merchants => './test/fixtures/merchants_truncated.csv',
                                  :invoices  => './test/fixtures/invoices_truncated.csv'
                                } )
    @ir = @se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_has_invoices
    assert_equal 9, @ir.all.count
    assert_instance_of Array, @ir.all
  end

  def test_all
    assert_instance_of Array, @ir.all
  end

  def test_find_by_id
    assert_nil @ir.find_by_id(777)
    assert_instance_of Invoice, @ir.find_by_id(1)
  end

  def test_find_all_by_customer_id
    assert_instance_of Array, @ir.find_all_by_customer_id(777)
    assert_instance_of Invoice, @ir.find_all_by_customer_id(1)[0]
    assert_equal 8, @ir.find_all_by_customer_id(1).count
  end

  def test_find_all_by_merchant_id
    assert_instance_of Array, @ir.find_all_by_merchant_id(777)

    actual = @ir.find_all_by_merchant_id(4)

    assert_instance_of Array, actual
    assert_instance_of Invoice, actual[0]
    assert_equal 4, actual.count
  end

  def test_it_can_find_all_by_status
    actual = @ir.find_all_by_status(:pending)

    assert_instance_of Array, actual
    assert_instance_of Invoice, actual[0]
    assert_equal 5, actual.length
  end

  def test_create_invoice
    assert_equal 9, @ir.all.last.id

    @ir.create({
      :merchant_id => 456,
      :customer_id => 789,
      :status      => 'shipped',
      :created_at  => '1995-03-19 10:02:43 UTC',
      :updated_at  => '1995-03-19 10:02:43 UTC',
                })

    actual = @ir.all.last

    assert_equal 10, actual.id
    assert_equal 456, actual.merchant_id
    assert_equal 789, actual.customer_id
    assert_equal :shipped, actual.status
  end

  def test_update_invoice
    skip
    attributes = ({
      :id          => '123',
      :merchant_id => '456',
      :customer_id => '789',
      :status      => 'shipped',
      :created_at  => '1995-03-19 10:02:43 UTC',
      :updated_at  => '1995-03-19 10:02:43 UTC',
      })
    # update(id, attribute) - update the Invoice instance with the corresponding id with the provided attributes. Only the invoice’s status can be updated. This method will also change the invoice’s updated_at attribute to the current time.
  end

  def test_delete_invoice
    # delete(id) - delete the Invoice instance with the corresponding id
  end




#   all - returns an array of all known Invoice instances

end
