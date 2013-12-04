jQuery ->
	timelyRefreshPosts = ->
		url = '/refresh_posts'
		$.get url, (data,status) ->
			$('.activity').html(data)
	setInterval(timelyRefreshPosts,5000)