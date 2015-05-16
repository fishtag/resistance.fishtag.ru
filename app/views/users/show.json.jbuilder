json.user do
  json.chart_data do
    json.labels ((GameSession.finished.count - user.per_game_percentage.size)...GameSession.finished.count).to_a
    json.datasets [
      {
        label: 'All games',
        fillColor: 'rgba(151,187,205,0.2)',
        strokeColor: 'rgba(151,187,205,1)',
        pointColor: 'rgba(220,220,220,1)',
        data: user.per_game_percentage.map { |game_info| game_info[:total_win_percentage] }
      },
      {
        label: 'Spy games',
        fillColor: 'rgba(151,0,0,0.2)',
        strokeColor: 'rgba(151,0,0,1)',
        pointColor: 'rgba(151,0,0,1)',
        data: user.per_game_percentage.map { |game_info| game_info[:spies_win_percentage] }
      },
      {
        label: 'Resistance games',
        fillColor: 'rgba(0,0,205,0.2)',
        strokeColor: 'rgba(0,0,205,1)',
        pointColor: 'rgba(0,0,205,0.5)',
        data: user.per_game_percentage.map { |game_info| game_info[:resistance_win_percentage] }
      }]
  end
end
