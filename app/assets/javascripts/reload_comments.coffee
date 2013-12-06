$ ->
	timelyReloadComments = ->
		url = "/reload_comments"
		$.get url, (data,status) ->
			$('#comments').removeClass('preload')
			$('#comments').html(data)
	setInterval(timelyReloadComments,2000)