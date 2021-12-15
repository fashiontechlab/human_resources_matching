class RemoveColumnsFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :number, :integer
    remove_column :members, :birthday, :date
  end
end
