class AddColumToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :kana_name, :string
  end
end
