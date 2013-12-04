jQuery ->
	timelyRefreshPosts = ->
		url = '/refresh_posts'
		$.get url, (data,status) ->
			$('.activity').removeClass('preload')
			$('.activity').html(data).fadeIn(100)
	setInterval(timelyRefreshPosts,5000)