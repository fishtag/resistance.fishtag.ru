class User
  module WinMath
    extend ActiveSupport::Concern

    def per_game_percentage
      @per_game_percentage ||= begin
        games_won_total = games_won_as_spy = games_won_as_resistance = 0
        total_resistance_games = total_spy_games = 0

        finished_game_sessions.map.with_index do |game, index|
          games_played = index + 1
          games_won_total += 1 if game.winners.include?(self)

          if game.winner == GAME_FRACTION_SPIES
            total_spy_games += 1
            games_won_as_spy += 1 if game.winners.include?(self)
          else
            total_resistance_games += 1
            games_won_as_resistance += 1 if game.winners.include?(self)
          end

          {
            total_win_percentage: (games_won_total / games_played.to_f * 100).round(2),
            spies_win_percentage: (games_won_as_spy / total_spy_games.to_f * 100).round(2),
            resistance_win_percentage: (games_won_as_resistance / total_resistance_games.to_f * 100).round(2)
          }
        end
      end
    end
  end
end
