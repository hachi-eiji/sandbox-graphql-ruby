class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.date :purchase_on, null: false
      t.timestamps
    end
  end
end
