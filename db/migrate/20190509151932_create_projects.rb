class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true
      t.datetime :estimated_end_date

      t.timestamps
    end
  end
end
