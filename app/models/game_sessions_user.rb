class GameSessionsUser < ActiveRecord::Base
  enum fraction: GAME_FRACTIONS

  belongs_to :game_session, inverse_of: :game_sessions_users
  belongs_to :user, counter_cache: :game_sessions_count
end
