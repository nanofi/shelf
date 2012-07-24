jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
$('ul.nav-list > li.disabled > a').click( -> false)
$(document).on 'ajax:before', 'form', ->
  $(this).find('input[type=submit').addClass('disabled')
$(document).on 'ajax:complete', 'form', ->
  $(this).find('input[type=submit]').removeClass('disabled')
$(document).on 'ajax:before', 'a', ->
  $(this).addClass('disabled')
$(document).on 'ajax:complete', 'a', ->
  $(this).removeClass('disabled')
