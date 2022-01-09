class RemoveTelephoneFromRyokans < ActiveRecord::Migration[5.2]
  def change
    remove_column :ryokans, :telephone, :integer
  end
end
