jQuery ->
	timelyRefreshPosts = ->
		url = '/refresh_posts'
		$.get url, (data,status) ->
			$('.activity').removeClass('preload')
			$('#posts').html(data)
	setInterval(timelyRefreshPosts,2000)