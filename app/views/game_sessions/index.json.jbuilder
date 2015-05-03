json.game_sessions(game_sessions) do |game_session|
  json.extract! game_session, :id, :winner
  json.players(game_session.game_sessions_users) do |player|
    json.id player.user.id
    json.name player.user.name
    json.role player.fraction
  end
end
