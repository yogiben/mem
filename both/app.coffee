App = 
	parseMultiple: (text)->
		words = text.split("\n");
		words = _.map words, (word)->
			word = word.replace(' - ','-')
			word = word.split('-')
		words = _.filter words, (word)->
			word.length == 3 or word.length == 2
		words
	getDuplicates: (array)->
		array
	toggleSet: (word,set)->
		word = Words.findOne {_id: word}
		if _.contains word.sets, set
			sets = _.without word.sets, set
		else
			sets = _.union word.sets, set
		Words.update({_id:word._id},{$set: {sets: sets}})
	next: ->
		if Session.get('test_index') < Session.get('Testing').length
			console.log 'next'
			Session.set('test_index',(Session.get('test_index')+1))
			Session.set 'multiple', false
			Session.set 'test-input', ''
			Session.set 'correct', null
			Session.set 'response', null
	getMultiples: ->
		Multiples = []
		Multiples.push Session.get('CurrentTesting')
		if Session.get('Words').length >= 5
			i = 0
			while i < 5
			  Multiples.push Words.find( {_id: { $not: Session.get('CurrentTesting')._id}} ).fetch()[i]
			  i++
		else
			i = 0
			while i < 5
			  Multiples.push Words.find({_id: { $not: Session.get('CurrentTesting')._id}}).fetch()[i]
			  i++
		Multiples
	isCorrect: (response,answer)->
		response = response.toLowerCase()
		answer = answer.toLowerCase()
		response == answer

if Meteor.isClient
	window['App'] = App
else if Meteor.isServer
	global['App'] = App