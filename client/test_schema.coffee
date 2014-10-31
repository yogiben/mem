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
		allowedValues: ['target','source','both']
		label: 'Prompt'
		autoform:
			options:[
				{label: 'Both', value: 'both'}
				{label: 'Target -> Source', value: 'target'}
				{label: 'Source -> Target', value: 'source'}
			]