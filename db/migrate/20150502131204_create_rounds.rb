class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :game_session, index: true, foreign_key: true
      t.integer :winner

      t.timestamps null: false
    end
  end
end
