# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#show_comment_form').click (e)->
		e.preventDefault()
		$('#comment_form').show(500)
		$(this).hide()

