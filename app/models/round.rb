class Round < ActiveRecord::Base
  belongs_to :game_session
  has_many :rounds_users
  has_many :participants, through: :rounds_users, source: :user

  enum winner: GAME_FRACTIONS

  validates :winner, presence: true, inclusion: { in: Round.winners.keys }
  validate :participants_in_game?

  after_save :save_game_session
  before_destroy :save_game_session, prepend: true

  protected

  def participants_in_game?
    participants.each do |participant|
      unless game_session.players.include?(participant)
        errors.add(:participants, "#{participant.name} is not in players list")
      end
    end
  end

  # Hack for autosaving +game_session+
  def save_game_session
    game_session.save
  end
end
