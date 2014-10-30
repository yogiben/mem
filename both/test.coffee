@Test = 
	correct: ->
		if Session.get 'multiple'
			Answers.new Session.get('CurrentTestItem')._id, 'multiple'
			console.log 'correct multiple'
		else
			Answers.new Session.get('CurrentTestItem')._id, 'string'
			console.log 'correct string'
	incorrect: ->
		Answers.new Session.get('CurrentTestItem')._id, 'incorrect'
		Session.set 'correct', false
		Reveal.down()


	next: ->
		console.log 'next'
		Session.set 'response', ''
		Session.set 'test_input', ''
		Session.set 'correct', ''
		Session.set 'multiple', false
		Session.set 'Multiples', null
		Session.set 'test_index', Session.get('test_index') + 1
		Reveal.right()
		$(Reveal.getCurrentSlide()).find('input').focus()
		
	getMultiples: ->
		Multiples = []
		Multiples.push Session.get('CurrentTestItem')
		if Session.get('Words').length >= 5
			i = 0
			while i < 5
			  Multiples.push Words.find( {_id: { $not: Session.get('CurrentTestItem')._id}} ).fetch()[i]
			  i++
		else
			i = 0
			while i < 5
			  Multiples.push Words.find({_id: { $not: Session.get('CurrentTestItem')._id}}).fetch()[i]
			  i++
		Multiples
	isCorrect: (response,answer)->
		response = response.toLowerCase()
		answer = answer.toLowerCase()
		response == answer

	multiple: ->
		Session.set 'multiple', true
		Session.set 'Multiples', @getMultiples()
		Reveal.down()