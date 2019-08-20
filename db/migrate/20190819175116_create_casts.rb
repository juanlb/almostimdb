class CreateCasts < ActiveRecord::Migration[5.2]
  def change
    create_table :casts do |t|
      t.integer :movie_id
      t.integer :person_id

      t.timestamps
    end
  end
end
