class User < ActiveRecord::Base
  include GameSessionsAssociations

  def win_percentage
    count_win_percentage(won_game_sessions, finished_game_sessions)
  end

  def spy_win_percentage
    count_win_percentage(won_spies_game_sessions, spies_game_sessions)
  end

  def resistance_win_percentage
    count_win_percentage(won_resistance_game_sessions, resistance_game_sessions)
  end

  def count_win_percentage(won_game_sessions, all_game_sessions, round_to = 2)
    return 0 if all_game_sessions.size.zero?

    (won_game_sessions.size / all_game_sessions.size.to_f * 100).round(round_to)
  end
end
