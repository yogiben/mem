Template.testLayout.events
	'click a.session-set,button.session-set': (e,t) ->
		key = $(e.currentTarget).attr('key')
		value =  $(e.currentTarget).attr('value')
		Session.set key, value
	'keyup input.session-set': (e,t)->
		key = $(e.currentTarget).attr('key')
		value = $(e.currentTarget).val()
		Session.set key, value
		if App.isCorrect value, Session.get('answer')
			console.log 'CORRECT!'
			Session.set 'correct', true
			setTimeout (->
				  App.next()
				), 100
	'click .test-input-skip': (e,t)->
		App.multiple()
	'click .test-multiple-answer': (e,t)->
		value =  $(e.currentTarget).val()
		if App.isCorrect value, Session.get('answer')
			Session.set('correct',true)
			console.log 'MULTIPLE CHOICE CORRECT'
			App.next()
		else
			Session.set('correct',false)
