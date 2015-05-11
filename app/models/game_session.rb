class GameSession < ActiveRecord::Base
  has_many :rounds, dependent: :destroy
  has_many :game_sessions_users, -> { eager_load(:user) }, dependent: :destroy, inverse_of: :game_session
  has_many :players, through: :game_sessions_users, source: :user

  validates :play_date, presence: true
  validates :game_sessions_users, length: { in: 5..10 }

  before_save :assign_finished

  scope :finished, -> { where(finished: true) }

  accepts_nested_attributes_for :game_sessions_users

  # Returns winner fraction
  # Return value is one of +GAME_FRACTIONS+ value (:spies or :resistance)
  #
  # @return [Symbol, NilClass]
  def winner
    @winner ||= select_winner
  end

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

  def select_winner
    return unless finished?

    round_winners.max_by { |_fraction, wins| wins }.first
  end

  # Sets #finished attribute according to +GameSession+ state
  # +GameSession+ is finished if any fraction has 3 won rounds
  #
  # @return [TrueClass, FalseClass]
  def assign_finished
    self.finished = round_winners.values.select { |wins_count| wins_count > 2 }.any?

    # Record should be saved anyway
    true
  end
end
