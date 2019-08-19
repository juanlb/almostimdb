class CreateDirections < ActiveRecord::Migration[5.2]
  def change
    create_table :directions do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :person, index: true

      t.timestamps
    end
  end
end
