@GameCard = React.createClass
  displayName: 'GameCard'

  render: ->
    classSet = React.addons.classSet

    cardClasses = classSet
      'game-card': true
      'spies-victory': @props.data.winner == 'spies'
      'resistance-victory': @props.data.winner == 'resistance'

    <div className={cardClasses}>
      <div className='winner'>
        {@props.data.winner}
      </div>
      <div className='players'>
        {
          @props.data.players.map (player) ->
            <div className='player'>
              Name: {player.name} | Role: {player.role}
            </div>
        }
      </div>
    </div>
