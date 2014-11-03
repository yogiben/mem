@testSchema = new SimpleSchema
	quantity:
		type:Number
		label: ->
			'Number of words (max ' + Session.get('Words').length + ')'

	order:
		type: String
		label: 'Order'
		allowedValues: ['newest','oldest','random']
		autoform:
			options:[
				{label: 'Random', value: 'random'}
				{label: 'Newest first', value: 'newest'}
				{label: 'Oldest first', value: 'oldest'}
			]

	prompt:
		type: String
		allowedValues: ['target','source','random']
		label: 'Direction'
		autoform:
			options:[
				{label: 'Target or Source', value: 'random'}
				{label: 'Target -> Source', value: 'target'}
				{label: 'Source -> Target', value: 'source'}
			]

	promptType:
		type: String
		allowedValues: ['both','random','text','voice']
		label: 'Prompt Type'
		autoform:
			options:[
				{label: 'Text and Voice', value: 'both'}
				{label: 'Text or Voice', value: 'random'}
				{label: 'Text', value: 'text'}
				{label: 'Voice', value: 'voice'}
			]