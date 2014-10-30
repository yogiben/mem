@testSchema = new SimpleSchema
	quantity:
		type:Number
		label: 'Number of words'

	order:
		type: String
		label: 'Order'
		allowedValues: ['newest','oldest','random']
		autoform:
			options:[
				{label: 'Newest first', value: 'newest'}
				{label: 'Oldest first', value: 'oldest'}
				{label: 'Random', value: 'random'}
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