class AddGameSessionsCountToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :game_sessions_count, default: 0, null: false
    end

    reversible do |dir|
      dir.up { User.find_each { |user| User.reset_counters(user.id, :game_sessions) } }
    end
  end
end
