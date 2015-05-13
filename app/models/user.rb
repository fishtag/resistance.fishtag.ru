class User < ActiveRecord::Base
  include GameSessionsAssociations

  def win_percentage
    return 0 if finished_game_sessions.size.zero?

    ((won_game_sessions.size / finished_game_sessions.size.to_f) * 100)
  end
end
