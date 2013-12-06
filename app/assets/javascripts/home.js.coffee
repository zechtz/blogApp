$ ->
	timelyRefreshPosts = ->
		url = '/refresh_posts'
		$.get url, (data,status) ->
			$('.activity').removeClass('preload')
			$('.activity').html(data)
	setInterval(timelyRefreshPosts,2000)