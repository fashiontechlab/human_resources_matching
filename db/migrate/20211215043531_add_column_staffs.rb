class AddColumnStaffs < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :password_digest, :string
  end
end
