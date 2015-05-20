json.game_sessions(game_sessions) do |game_session|
  json.extract! game_session, :id, :winner, :play_date
end
