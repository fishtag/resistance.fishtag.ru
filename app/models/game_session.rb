class GameSession < ActiveRecord::Base
  has_many :rounds
  has_many :game_sessions_users, -> { eager_load(:user) }
  has_many :players, through: :game_sessions_users, source: :user

  validates :play_date, presence: true
  validates :players, length: { in: 5..10 }

  # Returns winner fraction
  # Return value is one of +GAME_FRACTIONS+ value (:spies or :resistance)
  #
  # @return Symbol | NilClass
  def winner
    @winner ||= select_winner
  end

  # Checks if +GameSession+ is over.
  # +GameSession+ is over if any fraction has 3 won rounds
  #
  # @return TrueClass | FalseClass
  def game_over?
    round_winners.values.select { |wins_count| wins_count > 2 }.any?
  end

  # Iterates +GameSession+ rounds and returns their winners as Hash:
  #
  # { :spies => 1, :resistance => 3 }
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
    return unless game_over?

    round_winners.max_by { |_fraction, wins| wins }.first
  end
end
