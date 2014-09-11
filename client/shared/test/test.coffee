# Template.testOld.rendered = ->
# 	Session.set 'test_index',0

# Template.testOld.events
# 	'click .next': (e,t) ->
# 		App.next()
# 	'click #test-input-confirm': (e,t)->
# 		Session.set 'response', Session.get('test_input')
# 	'keyup #test-input': (e,t)->
# 		input = $(e.currentTarget).val()
# 		Session.set 'test_input', input
# 	'click #test-input-skip': (e,t)->
# 		Session.set 'multiple', true
# 	'click .test-multiple-answer': (e,t)->
# 		Session.set 'response', $(e.currentTarget).val()