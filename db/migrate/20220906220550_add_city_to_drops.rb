class AddCityToDrops < ActiveRecord::Migration[7.0]
  def change
    add_column :drops, :city, :string
    add_column :drops, :country, :string
  end
end
