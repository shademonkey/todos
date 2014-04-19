class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.boolean :completed
      t.references :user, index: true

      t.timestamps
    end
  end
end
