class CreateWeathers < ActiveRecord::Migration[5.0]
  def change
    create_table :weathers do |t|
      t.integer :zipcode

      t.timestamps
    end
  end
end
