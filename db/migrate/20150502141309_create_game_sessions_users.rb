class CreateGameSessionsUsers < ActiveRecord::Migration
  def change
    create_table :game_sessions_users do |t|
      t.belongs_to :game_session, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :fraction, null: false

      t.timestamps null: false
    end

    add_index :game_sessions_users, %i(game_session_id user_id)
  end
end
