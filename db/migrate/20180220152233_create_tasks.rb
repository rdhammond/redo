class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :type
      t.boolean :done
      t.datetime :last_completed
      t.datetime :next_refresh

      t.timestamps
    end
  end
end
