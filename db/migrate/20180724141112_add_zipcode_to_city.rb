class AddZipcodeToCity < ActiveRecord::Migration[5.2]
  def change
    remove_column :cities, :zip_code
    add_column :cities, :zipcode, :string
  end
end
