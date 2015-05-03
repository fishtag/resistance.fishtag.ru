class GameSessionsUser < ActiveRecord::Base
  belongs_to :game_session
  belongs_to :user

  enum fraction: GAME_FRACTIONS
end
