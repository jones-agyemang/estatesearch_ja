class AddFeeAttributeToResponsesTable < ActiveRecord::Migration[8.0]
  def change
    add_column :responses, :fee, :decimal, precision: 10, scale: 2
  end
end
