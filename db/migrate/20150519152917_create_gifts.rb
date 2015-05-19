class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :title
      t.string :recipient
      t.string :recipient_address
      t.date :delivery_date

      t.timestamps null: false
    end
  end
end
