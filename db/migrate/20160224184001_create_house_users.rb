class CreateHouseUsers < ActiveRecord::Migration
  def change
    create_table :house_users do |t|
      t.references :house, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
