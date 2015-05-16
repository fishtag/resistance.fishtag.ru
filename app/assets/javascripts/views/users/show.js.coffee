class UserShow
  constructor: ->
    @userChartData = gon.user.chart_data
    @_initPerGameChart()
#    @_initPerSpiesGameChart()

  _initPerGameChart: ->
    context = $('#per-game-chart').get(0).getContext('2d')
    @_drawBarChart(context, @userChartData)

  _initPerSpiesGameChart: ->
    context = $('#per-spies-game-chart').get(0).getContext('2d')
    @_drawBarChart(context, @userInfoData.per_spies_game)

  _drawBarChart: (context, data) ->
    new Chart(context).Bar(data)

$ ->
  new UserShow if $('#user-container').length
