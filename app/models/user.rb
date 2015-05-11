class User < ActiveRecord::Base
  has_many :game_sessions_users
  has_many :game_sessions, through: :game_sessions_users
  has_many :finished_game_sessions,
           -> { where(finished: true) },
           through: :game_sessions_users,
           source: :game_session

  def won_game_sessions
    finished_game_sessions.where('"game_sessions"."winner" = "game_sessions_users"."fraction"')
  end

  def lost_game_sessions
    finished_game_sessions.where('"game_sessions"."winner" != "game_sessions_users"."fraction"')
  end

  def win_percentage
    ((won_game_sessions.size / finished_game_sessions.size.to_f) * 100)
  end
end
