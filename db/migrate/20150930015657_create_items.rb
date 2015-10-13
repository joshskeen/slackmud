class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :shortdesc
      t.string :longdesc
      t.string :name
    end
    add_index :items, :shortdesc, unique: true
  end
end
