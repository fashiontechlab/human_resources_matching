class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :kana_name
      t.integer :mobile
      t.string :email
      t.integer :sex, default: 1

      t.timestamps
    end
  end
end
