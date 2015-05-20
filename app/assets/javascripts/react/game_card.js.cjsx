@GameCard = React.createClass
  displayName: 'GameCard'

  render: ->
    classSet = React.addons.classSet

    cardClasses = classSet
      'game-card': true
      'column-3': true
      'spies-victory': @props.data.winner == 'spies'
      'resistance-victory': @props.data.winner == 'resistance'

    <div className={cardClasses}>
      <div className='play_date'>
        {@props.data.play_date}
      </div>
      <div className='winner'>
        <a href={Routes.game_session_path(@props.data.id)}>{@props.data.winner}</a>
      </div>
    </div>
