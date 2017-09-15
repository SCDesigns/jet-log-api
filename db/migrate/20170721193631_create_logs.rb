class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :title
      t.text :description
      t.string :location
      t.numeric :latitude, :precision => 10, :scale => 7
      t.numeric :longitude, :precision => 10, :scale => 7
      t.string :memory
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
