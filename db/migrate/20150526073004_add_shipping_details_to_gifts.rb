class AddShippingDetailsToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :ship_name, :string
    add_column :gifts, :ship_surname, :string
    add_column :gifts, :ship_add1, :string
    add_column :gifts, :ship_add2, :string
    add_column :gifts, :ship_pcode, :string
    add_column :gifts, :ship_city, :string
    add_column :gifts, :ship_county, :string
  end
end
