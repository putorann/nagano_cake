class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.string :name
      t.integer :method_of_payment,default: 0
      t.integer :postage
      t.integer :amount_builled
      t.string :postal_code
      t.string :address
      t.integer :status,default: 0



      t.timestamps
    end
  end
end
