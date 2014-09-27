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

Template.registerHelper 'multiple', ->
	Session.get 'multiple'

Template.registerHelper 'Testing',->
	Session.get 'Testing'

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