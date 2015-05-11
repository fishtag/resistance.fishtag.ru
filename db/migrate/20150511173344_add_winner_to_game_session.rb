class AddWinnerToGameSession < ActiveRecord::Migration
  def change
    add_column :game_sessions, :winner, :integer

    add_index :game_sessions, :winner
  end
end
