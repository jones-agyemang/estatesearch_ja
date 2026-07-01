class AddResponseReferenceToPaymentRequest < ActiveRecord::Migration[8.0]
  def change
    add_reference :payment_requests, :response, null: false, foreign_key: true, index: { unique: true }
  end
end
