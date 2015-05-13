class AllowNullOnGameSessionsUserFraction < ActiveRecord::Migration
  def change
    change_column :game_sessions_users, :fraction, :integer, null: true
  end
end
