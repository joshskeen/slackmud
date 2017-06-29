class AddUniqueNameConstraintToEffects < ActiveRecord::Migration
  def change
    add_index :effects, [:name], unique: true
  end
end
