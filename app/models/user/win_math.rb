class User
  module WinMath
    extend ActiveSupport::Concern

    def per_game_percentage
      won_games = 0

      finished_game_sessions.map.with_index do |game, index|
        won_games += 1 if game.winners.include?(self)

        {
          games_played: index + 1,
          win_percentage: (won_games / (index + 1).to_f * 100).round(2)
        }
      end
    end
  end
end
