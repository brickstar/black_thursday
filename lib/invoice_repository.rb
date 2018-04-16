# frozen_string_literal: true

require_relative 'base_repository'
require_relative 'invoice'

# invoice repo
class InvoiceRepository < BaseRepository
  def invoices
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| Invoice.new(attribute_hash, self) }
  end

  def find_all_by_customer_id(customer_id)
    invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(shipping_status)
    invoices.select { |invoice| invoice.status == shipping_status }
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    invoices << Invoice.new(attributes, 'parent')
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.change_shipping_status(attributes[:status]) if attributes[:status]
    to_update.change_updated_at
  end

  def delete(id)
    to_delete = find_by_id(id)
    invoices.delete(to_delete)
  end

  def pass_merchant_id_to_engine_from_invoice(id)
    @parent.pass_merchant_id_to_merchant_repo(id)
  end

  private

  def find_highest_id
    invoices.map(&:id).max
  end

  def create_new_id
    find_highest_id + 1
  end
end
