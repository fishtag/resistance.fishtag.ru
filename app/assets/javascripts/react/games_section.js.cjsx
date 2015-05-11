@GamesSection = React.createClass
  displayName: 'gamesSection'

  getInitialState: ->
    games: gon.game_sessions

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
