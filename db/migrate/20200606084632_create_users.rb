class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|

      t.string :name
      t.string :email
      t.string :password
      t.string :phone

      t.timestamps
      t.column :deleted_at, :datetime, :limit => 6
    end
  end
end
