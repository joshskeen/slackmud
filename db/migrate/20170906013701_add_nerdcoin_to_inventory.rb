class AddNerdcoinToInventory < ActiveRecord::Migration
  def change
    change_table :inventories do |t|
      t.column :nerdcoins, :integer, default:0
    end
  end
end
