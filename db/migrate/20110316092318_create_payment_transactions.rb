class CreatePaymentTransactions < ActiveRecord::Migration
  def self.up
    create_table :payment_transactions do |t|
      t.references :user
      t.integer :value
      t.text :description

      t.timestamps
    end

    add_index :payment_transactions, :user_id
  end

  def self.down
    drop_table :payment_transactions
  end
end

