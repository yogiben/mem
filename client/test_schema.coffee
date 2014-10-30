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