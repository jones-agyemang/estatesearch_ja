class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.string :body
      t.references :lawyer, null: false, foreign_key: { to_table: :users }
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
