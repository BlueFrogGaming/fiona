class CreateFionaTables < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :type
      t.string :key
      t.string :name

      t.timestamps
    end

    create_table :template_attributes do |t|
      t.integer :template_id
      t.string  :key
      t.text    :value

      t.timestamps
    end

    add_index :template_attributes, [:template_id, :key]
  end
end
