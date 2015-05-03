@GamesSection = React.createClass
  displayName: 'gamesSection'

  getInitialState: ->
    games: []

  componentDidMount: ->
    @_fetchGames()

  _fetchGames: ->
    $.getJSON Routes.game_sessions_path(), (data) =>
      @setState(games: data.game_sessions)

  render: ->
    gamesNode =
      @state.games.map (game) ->
        <GameCard key={game.id} data={game} />

    <div className='games-wrapper'>
      {
        if @state.games.length > 0
          {gamesNode}
      }
    </div>
