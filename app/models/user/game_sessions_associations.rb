class User
  module GameSessionsAssociations
    extend ActiveSupport::Concern

    WHERE_WON_GAME_SESSIONS =  '"game_sessions"."winner" = "game_sessions_users"."fraction"'
    WHERE_LOST_GAME_SESSIONS = '"game_sessions"."winner" != "game_sessions_users"."fraction"'
    WHERE_SPIES_GAME_SESSIONS =
      { game_sessions_users: { fraction: GameSessionsUser.fractions[GAME_FRACTION_SPIES] } }
    WHERE_RESISTANCE_GAME_SESSIONS =
      { game_sessions_users: { fraction: GameSessionsUser.fractions[GAME_FRACTION_RESISTANCE] } }

    included do
      has_many :game_sessions_users
      with_options through: :game_sessions_users, source: :game_session do |user|
        user.has_many :game_sessions
        user.has_many :finished_game_sessions, -> { where(finished: true) }
        user.has_many :won_game_sessions,  -> { where(WHERE_WON_GAME_SESSIONS) }
        user.has_many :lost_game_sessions, -> { where(WHERE_LOST_GAME_SESSIONS) }
        user.has_many :spies_game_sessions, -> { where(WHERE_SPIES_GAME_SESSIONS) }
        user.has_many :resistance_game_sessions, -> { where(WHERE_RESISTANCE_GAME_SESSIONS) }
      end
    end

    def won_spies_game_sessions
      spies_game_sessions.where(WHERE_WON_GAME_SESSIONS)
    end

    def lost_spies_game_sessions
      spies_game_sessions.where(WHERE_LOST_GAME_SESSIONS)
    end

    def won_resistance_game_sessions
      resistance_game_sessions.where(WHERE_WON_GAME_SESSIONS)
    end

    def lost_resistance_game_sessions
      resistance_game_sessions.where(WHERE_LOST_GAME_SESSIONS)
    end
  end
end
