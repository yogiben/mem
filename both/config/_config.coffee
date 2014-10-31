Config =
	name: 'Vocab.li'
	title: 'Manage your vocabulary'
	subtitle: 'Organize and record your foreign language vocab'
	logo: ->
		'<b>' + @name + '</b>'
	footer: ->
		@name + ' - Copyright 2014'
	emails:
		from: 'noreply@' + Meteor.absoluteUrl()
	twitter: 'BenPeterJones'
	facebook: 'benjaminpeterjones'
	blog: 'http://benjaminpeterjones.com'
	about: 'http://benjaminpeterjones.com'
	placeholder: 'Hello'
	testLength: 20
	recentLength: 10

	points: [
			[ 'string',     3 ],
			[ 'multiple',   1 ],
			[ 'incorrect',  0 ]
		]

	


if Meteor.isClient
	window.Config = Config
else if Meteor.isServer
	global.Config = Config