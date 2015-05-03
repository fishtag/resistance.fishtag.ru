# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  # Create users
  users = %w(Dmitry Vasya Irina Kisa Enrique).map { |name| User.create! name: name }

  # Create blank game
  game = GameSession.new.tap do |game_session|
    game_session.play_date = Date.today
    game_session.save(validate: false)
  end

  users.each_with_index.map do |user, index|
    GameSessionsUser.create! user: user, game_session: game,
                             fraction: index > 2 ? GAME_FRACTION_SPIES : GAME_FRACTION_RESISTANCE
  end

  # Create rounds
  5.times do
    r = Round.create!(game_session: game,
                  winner: GAME_FRACTIONS.sample,
                  participants: users.sample(rand(2..3)))
  end
end
