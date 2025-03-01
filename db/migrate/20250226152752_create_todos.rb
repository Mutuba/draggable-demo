class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title, null: false
      t.string :description
      t.integer :order_priority

      t.timestamps
    end
  end
end
