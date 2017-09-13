class AddValueToItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.column :value, :integer, default:0
    end
  end
end
