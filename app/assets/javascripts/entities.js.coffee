$(document).on 'change', 'select[name=entity[place_id]]', ->
  $(this).parent('form').submit()