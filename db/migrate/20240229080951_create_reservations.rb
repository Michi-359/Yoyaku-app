class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :checkin
      t.date :checkout
      t.integer :person

      t.timestamps
    end
  end
end
