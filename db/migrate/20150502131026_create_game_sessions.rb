class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.date :play_date

      t.timestamps null: false
    end
  end
end
