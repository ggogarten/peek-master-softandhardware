class AddHouseToPicture < ActiveRecord::Migration
  def change
    add_reference :pictures, :house, index: true, foreign_key: true
  end
end
