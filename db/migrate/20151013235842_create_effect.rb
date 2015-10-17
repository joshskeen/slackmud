class CreateEffect < ActiveRecord::Migration
  def change
    create_table :effects do |t|
      t.string :name
      t.string :value
      t.string :duration
    end
  end
end
