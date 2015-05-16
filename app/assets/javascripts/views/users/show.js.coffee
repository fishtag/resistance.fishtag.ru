class UserShow
  constructor: ->
    @userChartData = gon.user.chart_data
    @_initPerGameChart()

  _initPerGameChart: ->
    context = $('#per-game-chart').get(0).getContext('2d')
    @_drawBarChart(context, @userChartData)

  _drawBarChart: (context, data) ->
    @userChart = new Chart(context).Line(data,
      datasetFill: true,
      datasetStrokeWidth: 1,
      pointDot: false,
      scaleShowHorizontalLines: false)

$ ->
  new UserShow if $('#user-container').length

