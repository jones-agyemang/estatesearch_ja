class CreatePaymentRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_requests do |t|
      t.references :lawyer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
