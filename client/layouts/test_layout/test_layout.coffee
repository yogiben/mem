Template.testLayout.events
	'click a.session-set,button.session-set': (e,t) ->
		key = $(e.currentTarget).attr('key')
		value =  $(e.currentTarget).attr('value')
		Session.set key, value
	'keyup input.session-set': (e,t)->
		key = $(e.currentTarget).attr('key')
		value = $(e.currentTarget).val()
		Session.set key, value
		if App.isCorrect(value, Session.get('answer')) and Session.equals 'correct', ''
			console.log 'CORRECT!'
			Session.set 'correct', true

			App.correct()

			setTimeout (->
				  App.next()
				), 100
	'keydown': (e,t)->
		if e.which == 13
			if Reveal.getIndices().v == 0
				App.multiple()
			else if Reveal.getIndices().v == 1
				App.incorrect()
			else if Reveal.getIndices().v == 2
				App.next()


	'click .test-input-skip': (e,t)->
		App.multiple()
	'click .test-multiple-answer': (e,t)->
		value =  $(e.currentTarget).val()
		if App.isCorrect value, Session.get('answer')
			Session.set('correct',true)
			console.log 'MULTIPLE CHOICE CORRECT'

			App.correct()

			setTimeout (->
				  App.next()
				), 100
		else
			
			setTimeout (->
				  App.incorrect()
				), 100
	'click .accept-incorrect': (e,t)->
		App.next()

Template.testLayout.rendered = () ->
	setTimeout (->
		$(Reveal.getCurrentSlide()).find('input').focus()
	), 500

Template.testLayout.destroyed = () ->
	console.log 'test layout destroyed'
	Session.set 'Testing', null
	Session.set 'test_index', 0

Template.registerHelper 'currentFalse', (_id) ->
		if Session.equals('correct', false) and Session.get('CurrentTestItem')._id == _id
			console.log _id
			true