@digiquatics.factory 'ChemicalRecords', ['$resource',
  ($resource) ->
    $resource('/chemical_records.json', {}, { index: { method: 'GET', isArray: true}})
]
