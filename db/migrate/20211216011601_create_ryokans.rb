class CreateRyokans < ActiveRecord::Migration[5.2]
  def change
    create_table :ryokans do |t|
      t.string :name, null: false
      t.string :full_name, null: false
      t.string :kana_name
      t.string :manager, null: false
      t.integer :telephone
      t.string :password_digest
      t.string :email, null: false

      t.timestamps
    end
  end
end
