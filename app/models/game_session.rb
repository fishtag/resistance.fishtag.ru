class GameSession < ActiveRecord::Base
  enum winner: GAME_FRACTIONS

  has_many :rounds, -> { eager_load(:participants) }, dependent: :destroy
  has_many :game_sessions_users, -> { eager_load(:user) }, dependent: :destroy, inverse_of: :game_session
  with_options through: :game_sessions_users, source: :user do
    has_many :players
    has_many :spies,
             -> { where(game_sessions_users:
                          { fraction: GameSession::winners[GAME_FRACTION_SPIES] }) }
    has_many :resistance,
             -> { where(game_sessions_users:
                          { fraction: GameSession::winners[GAME_FRACTION_RESISTANCE] }) }
  end

  validates :play_date, presence: true
  validates :players, length: { in: 5..10 }
  validates_associated :game_sessions_users, if: :persisted?

  before_validation :assign_finished
  before_save :assign_winner

  scope :finished, -> { where(finished: true) }

  accepts_nested_attributes_for :game_sessions_users
  accepts_nested_attributes_for :rounds, reject_if: :all_blank

  # Iterates +GameSession+ rounds and returns their winners as Hash:
  #
  # @example
  #   round_winners => { :spies => 1, :resistance => 3 }
  #
  # @return Hash
  def round_winners
    rounds.map(&:winner).each_with_object(Hash.new(0)) do |fraction, counts|
      next if fraction.nil?

      counts[fraction.to_sym] += 1
    end
  end

  private

  # Sets #winner attribute according to GameSession rounds' results.
  # Always returns +true+
  #
  # @return TrueClass
  def assign_winner
    self.winner = finished? ? round_winners.max_by { |_fraction, wins| wins }.first : nil

    # Record should be saved anyway
    true
  end

  # Sets #finished attribute according to +GameSession+ state
  # +GameSession+ is finished if any fraction has 3 won rounds
  # Always returns +true+
  #
  # @return TrueClass
  def assign_finished
    self.finished = round_winners.values.select { |wins_count| wins_count > 2 }.any?

    # Record should be saved anyway
    true
  end
end
