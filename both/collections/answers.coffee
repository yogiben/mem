Schemas = {}

@Answers = new Meteor.Collection('answers');

Schemas.Answers = new SimpleSchema
	word:
		type:String

	createdAt: 
		type: Date
		autoValue: ->
			if this.isInsert
				new Date()

	correct:
		type: String
		allowedValues:
			[
				'string'
				'multiple'
				'incorrect'
			]

	owner:
		type: String
		autoValue: ->
			if @isInsert
				Meteor.userId()

Answers.attachSchema(Schemas.Answers)