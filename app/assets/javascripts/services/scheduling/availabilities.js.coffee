@digiquatics.factory 'AvailabilityService', [
  '$resource'

  ($resource) ->
    Availability = $resource '/availabilities', {},
      create:
        method: 'POST'

    Availability.create = Availability.save

    Availability
]
