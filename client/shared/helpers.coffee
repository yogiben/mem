Template.registerHelper 'App', ->
	App

Template.registerHelper 'Config', ->
	Config

Template.registerHelper 'niceName',->
	if Session.get('User')
		if Session.get('User').profile.firstName
			Session.get('User').profile.firstName
		else
			Session.get('User').emails[0].address

Template.registerHelper 'Users', ->
	Meteor.users

Template.registerHelper 'Word', ->
	Session.get 'Word'

Template.registerHelper 'language', ->
	Session.get 'language'

Template.registerHelper 'Language', ->
	Session.get 'Language'

Template.registerHelper 'Languages', ->
	Languages

Template.registerHelper 'learning', ->
	Session.get 'learning'

Template.registerHelper 'Learning', ->
	Session.get 'Learning'

Template.registerHelper 'toArray', ->
	_.map Languages, (Language)->
		Language

Template.registerHelper 'set', ->
	Session.get 'set'

Template.registerHelper 'Set', ->
	Session.get 'Set'

Template.registerHelper 'multipleAdd', ->
	Session.get 'multipleAdd'

Template.registerHelper 'Testing',->
	Session.get 'Testing'

Template.registerHelper 'CurrentTestItem',->
	Session.get 'CurrentTestItem'

Template.registerHelper '_', ->
	_

Template.registerHelper 'User', ->
	Meteor.user()

Template.registerHelper 'username', ->
	Session.get 'username'

Template.registerHelper 'Words', ->
	Session.get 'Words'

Template.registerHelper 'Recent', ->
	Session.get 'Recent'

Template.registerHelper 'Sets', ->
	Session.get 'Sets'

Template.registerHelper 'Tests', ->
	Session.get 'Tests'

Template.registerHelper 'addType',->
	Session.get 'addType'

Template.registerHelper 'addSets',->
	Session.get 'addSets'

Template.registerHelper 'getSets', (language)->
	Sets.find({language:language}).fetch()

Template.registerHelper 'getDoc', (_id,collection)->
	window[collection].findOne {_id:_id}

Template.registerHelper 'allSets', ->
	Session.get 'sets'

Template.registerHelper 'currentTesting', ->
	Session.get 'currentTesting'

Template.registerHelper 'wordCount', (language,set) ->
	if language and set
		Words.find({$and : [{language:language},{sets: { $all : [ set ] }}]}).fetch().length
	else if language
		Words.find({language:language}).fetch().length
	else
		Words.find().fetch().length

Template.registerHelper 'points', (_id)->
	App.getPoints _id

Template.registerHelper 'lastPoints', (_id)->
	App.getLastPoints _id

Template.registerHelper 'ago', (date) ->
    moment(date).fromNow()

Template.registerHelper 'lastTested', (_id)->
	answer = Answers.findOne {word: _id}, {sort: {createdAt: -1}}
	if typeof answer != 'undefined'
	    moment(answer.createdAt).fromNow()	

Template.registerHelper 'wordsDaysAgoCount', (ago, gap)->
	# words = App.wordsDaysAgo(ago, gap)
	# console.log words
	# App.wordsDaysAgo(ago, gap).length

	end = new Date()
	end.setDate(end.getDate() - ago)

	start = new Date()
	start.setDate(start.getDate() - (ago + gap))

	Words = _.filter Session.get('Words'), (word)->
		word.createdAt > start && word.createdAt < end

	Words.length

Template.registerHelper 'dateId', (date)->
	date = moment(date).format('YYYY-MM-DD')
	# if not _.contains Session.get('dateIds'), date
	# 	console.log Session.get('dateIds')
	# 	dateIds = Session.get('dateIds')
	# 	dateIds.push date
	# 	Session.set 'dateIds', dateIds
	# 	return 'DATE'
	# else
	# 	'NO DATE'
	date 

Template.registerHelper 'dateDaysAgo', (ago)->
	moment().subtract(ago, 'days').format('YYYY-MM-DD')

Template.registerHelper 'wordsDaysAgoLength', (ago,gap)->
	App.wordsDaysAgo(ago,gap).length

Template.registerHelper 'wordsByDate', (start,end)->
	App.wordsByDate(start,end)

Template.registerHelper 'wordsByDateLength', (start,end)->
	App.wordsByDate(start,end).length

Template.registerHelper 'testSchema', ->
	testSchema

Template.registerHelper 'lengthOfSession', (key)->
	if Session.get(key)
		Session.get(key).length