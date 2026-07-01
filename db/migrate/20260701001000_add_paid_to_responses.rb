class AddPaidToResponses < ActiveRecord::Migration[8.0]
  def change
    add_column :responses, :paid, :boolean, null: false, default: false
  end
end
