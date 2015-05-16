json.user do
  json.chart_data do
      json.labels (1..user.finished_game_sessions.size).to_a
      json.datasets [
        {
          label: 'All games',
          fillColor: 'rgba(151,187,205,0.2)',
          strokeColor: 'rgba(151,187,205,1)',
          highlightFill: 'rgba(151,187,205,1)',
          highlightStroke: 'rgba(151,187,205,1)',
          data: user.per_game_percentage.map { |game_info| game_info[:total_win_percentage] }
        },
        {
          label: 'Spy games',
          fillColor: 'rgba(151,0,0,0.2)',
          strokeColor: 'rgba(151,0,0,1)',
          highlightFill: 'rgba(151,0,0,1)',
          highlightStroke: 'rgba(151,0,0,1)',
          data: user.per_game_percentage.map { |game_info| game_info[:spies_win_percentage] }
        },
        {
          label: 'Resistance games',
          fillColor: 'rgba(0,0,205,0.2)',
          strokeColor: 'rgba(0,0,205,1)',
          highlightFill: 'rgba(0,0,205,1)',
          highlightStroke: 'rgba(0,0,205,1)',
          data: user.per_game_percentage.map { |game_info| game_info[:resistance_win_percentage] }
        }]
  end
end
