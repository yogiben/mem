AutoForm.hooks add:
  formToDoc: (doc) ->
    doc.sets = Session.get('languageAddSets')
    doc

Template.words.events
	# 'change input[type="checkbox"]': (e,t) ->
	# 	set = $(e.currentTarget).attr('set')
	# 	word = $(e.currentTarget).attr('word')
	# 	console.log word
	# 	console.log set
	'click .toggle-set': (e,t)->
		set = $(e.currentTarget).attr('set')
		word = $(e.currentTarget).attr('word')
		App.toggleSet word, set

	'click td.select-word': (e,t)->
		input = $(e.target).find('input.select-word')
		$(input).prop 'checked', not $(input).prop('checked')
		countSelected()
		
	'click .select-all': (e,t)->
		if $('input.select-word:checked').length == $('input.select-word').length
			$('input.select-word').prop('checked', false);
		else
			$('input.select-word').prop('checked', true);
		countSelected()

	'click [href="#word-detail"]': (e,t)->
		word = Words.findOne $(e.currentTarget).attr('doc')
		text = word.target
		tl = Languages[word.language].code
		tts.speak(text,tl)

countSelected = ->
	selected = []
	_.each $('input.select-word:checked'), (input)->
		selected.push $(input).val()
	Session.set 'selected', selected

Template.words.rendered = ->
	Session.set 'selected', []
	Session.set 'checkbox', false

Template.words.created = () ->
	Session.set 'dateIds', []

Template.multipleControls.helpers
	isSelection: () ->
		Session.get('selected').length > 0

Template.multipleControls.events
	'click #delete-multiple': ->
		_.each Session.get('selected'), (_id)->
			Words.remove _id
	'click .add-set-multiple': (e,t)->
		set = $(e.currentTarget).attr('set')
		console.log set
		_.each Session.get('selected'), (_id)->
			Words.update _id, { $addToSet: { sets: set  }} , (e,r)->
				console.log e,r

Template.wordDetailModal.events
	'click #word-detail-submit-dummy': () ->
		$('#word-detail-submit').click()
		$('#word-detail').modal('hide')

	'click #word-detail-delete': (e,t)->
		_id = $(e.currentTarget).attr('doc')
		Words.remove {_id:_id}, ->
			$('#word-detail').modal('hide')