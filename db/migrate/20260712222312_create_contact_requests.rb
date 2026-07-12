class CreateContactRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :contact_requests do |t|
      t.string :customer_type
      t.string :service
      t.string :name
      t.string :company
      t.string :email
      t.string :phone
      t.string :postal_code
      t.string :city
      t.text :message
      t.string :status
      t.datetime :delivered_at
      t.datetime :failed_at
      t.string :privacy_notice_version
      t.datetime :displayed_at

      t.timestamps
    end

    add_index :contact_requests, :status
    add_index :contact_requests, :created_at
  end
end
