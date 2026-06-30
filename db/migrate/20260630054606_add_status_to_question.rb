class AddStatusToQuestion < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :status, :integer, default: 0
  end
end
