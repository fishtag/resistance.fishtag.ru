class User
  module WinMath
    extend ActiveSupport::Concern

    def per_game_percentage
      @per_game_percentage ||= begin
        games_won_total = games_won_as_spy = games_won_as_resistance = 0
        total_resistance_games = total_spy_games = total_games = 0

        finished_game_sessions.map do |game|
          total_games += 1
          total_spy_games += 1 if spies_game_sessions.include?(game)
          total_resistance_games += 1 if resistance_game_sessions.include?(game)


          games_won_total += 1 if game.winners.include?(self)
          games_won_as_spy += 1 if won_spies_game_sessions.include?(game)
          games_won_as_resistance += 1 if won_resistance_game_sessions.include?(game)

          {
            total_win_percentage: (games_won_total / total_games.to_f * 100).round(2),
            spies_win_percentage: (games_won_as_spy / total_spy_games.to_f * 100).round(2),
            resistance_win_percentage: (games_won_as_resistance / total_resistance_games.to_f * 100).round(2)
          }
        end.last(25)
      end
    end
  end
end
