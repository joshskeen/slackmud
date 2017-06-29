class CreateEffect < ActiveRecord::Migration
  def change
    create_table :effects do |t|
      t.string :name
    end
  end
end
