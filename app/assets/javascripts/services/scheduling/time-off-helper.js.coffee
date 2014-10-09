@digiquatics.factory 'TimeOffHelper', [
  ->
    class TimeOffHelper
      @thArrow: (currentColumn, anchoredColumn) ->
        currentColumn is anchoredColumn

      @hasReason: (request) ->
        request.reason

      @startsAt: (request) ->
        if request.all_day
          moment(request.starts_at).format('M/D/YY')
        else
          moment(request.starts_at).format('M/D/YY @ h:mma')

      @endsAt: (request) ->
        if request.all_day
          moment(request.ends_at).format('M/D/YY')
        else
          moment(request.ends_at).format('M/D/YY @ h:mma')

      @timeFormat: (time) ->
        moment(time).format 'h:mmA'
]
