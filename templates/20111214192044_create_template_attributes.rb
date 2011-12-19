class CreateTemplateAttributes < ActiveRecord::Migration
  def change
    create_table :template_attributes do |t|
      t.integer :template_id
      t.string :key
      t.string :value

      t.timestamps
    end

    add_index :template_attributes, [:template_id, :key]
  end
end
