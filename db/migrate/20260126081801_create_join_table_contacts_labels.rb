class CreateJoinTableContactsLabels < ActiveRecord::Migration[8.1]
  def change
    create_join_table :contacts, :labels do |t|
      t.index [ :contact_id, :label_id ], unique: true
      t.index [ :label_id, :contact_id ]
    end

    add_foreign_key :contacts_labels, :contacts
    add_foreign_key :contacts_labels, :labels
  end
end
