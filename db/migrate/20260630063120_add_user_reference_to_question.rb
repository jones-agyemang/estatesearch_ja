class AddUserReferenceToQuestion < ActiveRecord::Migration[8.0]
  def change
    add_reference :questions, :user, null: false, foreign_key: true
  end
end
