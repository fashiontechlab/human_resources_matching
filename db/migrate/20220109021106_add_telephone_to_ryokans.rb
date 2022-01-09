class AddTelephoneToRyokans < ActiveRecord::Migration[5.2]
  def change
    add_column :ryokans, :telephone, :string
  end
end
