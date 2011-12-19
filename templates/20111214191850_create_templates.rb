class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :type
      t.string :key
      t.string :name

      t.timestamps
    end
  end
end
