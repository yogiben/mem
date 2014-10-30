Template.test.rendered = () ->
	callback = 	Reveal.initialize
		loop: false
		controls: false
		progress: true
		autoSlide: 0

	setTimeout callback, 300

Template.test.events
	'change .test-input': (e,t) ->
		#

Template.test.helpers
	testCount: () ->
		Session.get('test_index') + 1