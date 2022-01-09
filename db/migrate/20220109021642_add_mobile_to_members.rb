class AddMobileToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :mobile, :string
  end
end
