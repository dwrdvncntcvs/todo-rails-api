class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title, null: false
      t.string :desc, null: false
      t.boolean :is_done, default: false

      t.timestamps
    end
  end
end
