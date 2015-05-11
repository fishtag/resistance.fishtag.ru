class AddFinishedToGameSession < ActiveRecord::Migration
  def change
    add_column :game_sessions, :finished, :boolean, default: false, null: false
  end
end
