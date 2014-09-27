Schemas = {}

@Answers = new Meteor.Collection('answers');

Answers.new = (_id,status)->
	@insert
		word: _id
		status: status

Schemas.Answers = new SimpleSchema
	word:
		type:String

	createdAt: 
		type: Date
		autoValue: ->
			if this.isInsert
				new Date()

	status:
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