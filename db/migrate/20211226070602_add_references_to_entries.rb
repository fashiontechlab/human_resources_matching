class AddReferencesToEntries < ActiveRecord::Migration[5.2]
  def change
    add_reference :entries, :ryokan, foreign_key: true
  end
end
