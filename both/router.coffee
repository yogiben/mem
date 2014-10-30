Router.configure
  layoutTemplate: "masterLayout"
  loadingTemplate: "Loading"
  notFoundTemplate: "NotFound"
  routeControllerNameConverter: "camelCase"

Router.onBeforeAction "loading"
Router.map ->
  
  @route "home",
    path: "/"
    layoutTemplate: "homeLayout"

  @route "profile",
    path: "/profile"

  @route "languages",
    path: "/languages/"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'title', 'Languages'
      Session.set 'subtitle', 'What are you trying to learn?'
      @render()

  @route "test",
    path: "/test/"
    layoutTemplate: "testLayout"
    # action: ->
    #   if Session.get('TestQueue').length > Config.testLength
    #     Session.set 'Testing', Session.get('TestQueue').splice(0,Config.testLength) 
    #   else
    #     Session.set 'Testing', Session.get('TestQueue')
    # Session.set('CurrentTestItem',Session.get('Testing')[0])
    action: ->
      if Session.get 'Testing'
        #testing has been set
        true
      else if Session.get('TestQueue').length > Config.testLength
        Session.set 'Testing', Session.get('TestQueue').splice(0,Config.testLength) 
      else
        Session.set 'Testing', Session.get('TestQueue')

      Testing = Session.get 'Testing'

      testOptions = Session.get 'testOptions'


      if Session.get 'testOptions'
        Testing = _.map Testing, (testing)->
          if testOptions.prompt == 'target' or testOptions.prompt == 'source'
            testing.prompt = testOptions.prompt
          else if testOptions.prompt == 'both'
            x = 0.5
            if x > 0.5
              testing.prompt = 'target'
            else
              testing.prompt = 'source'
          console.log testing
          testing
        Session.set 'Testing', Testing


      Session.set 'test_index', 0
      Session.set('CurrentTestItem',Session.get('Testing')[0])

      @render()

  @route "stream",
    path: "/:username/stream"
    layoutTemplate: "dashboardLayout"
    data: ->
      words: Words.find({},{sort: {createdAt: -1}}).fetch()
    action: ->
      Session.set 'language', null
      Session.set 'title', 'Test queue'
      Session.set 'subtitle', 'Your words in the order that they\'ll be tested'
      @render()


  @route "add",
    path: "/:username/add"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      @render()

  @route "addL",
    template: 'add'
    path: "/:username/:language/add"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      @render()

  @route "dashboard",
    path: "/:username"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'title','Dashboard'
      Session.set 'subtitle','Learn learn learn'
      Session.set 'language',null
      @render()
      
  @route "language",
    path: "/:username/:language/"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', Languages[@params.language].name
      Session.set 'subtitle', Session.get('Words').length + ' words'
      Session.set 'set', null
      @render()

  @route "words",
    path: "/:username/:language/all"
    template: 'languageAll'
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', Languages[@params.language].name
      Session.set 'subtitle', Session.get('Words').length + ' words'
      Session.set 'set', null
      @render()

  @route "set",
    path: "/:username/:language/:set"
    template: 'languageAll'
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', @params.set
      Session.set 'subtitle', Session.get('Words').length + ' words'
      Session.set 'set', @params.set
      @render()


Router.waitOn ->
  Meteor.subscribe 'user'