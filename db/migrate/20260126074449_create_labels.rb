class CreateLabels < ActiveRecord::Migration[8.1]
  def change
    create_table :labels do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :labels, "lower(name)", unique: true, name: "index_labels_on_lower_name"
  end
end
