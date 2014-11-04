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
      Session.set 'set', null

      @render()
      
  @route "language",
    path: "/:username/:language/"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', Languages[@params.language].name
      Session.set 'subtitle', Session.get('Words').length + ' words'
      Session.set 'set', null
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
      Session.set 'time', null
      @render()

  @route "sets",
    path: "/:username/:language/sets"
    template: 'manageSets'
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', Languages[@params.language].name
      Session.set 'subtitle', 'Manage sets'
      Session.set 'set', null
      Session.set 'time', null
      @render()

  @route "time",
    path: "/:username/:language/t/:start/:end"
    template: 'time'
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      if @params.start == @params.end
        Session.set 'title', moment(@params.start).format('Do MMM')
      else
        Session.set 'title', moment(@params.start).format('Do MMM') + ' - ' + moment(@params.end).format('Do MMM')
      Session.set 'subtitle', App.wordsByDate(@params.start, @params.end).length + ' words'
      Session.set 'set', null
      Session.set 'time', [@params.start, @params.end]
      @render()

  @route "set",
    path: "/:username/:language/:set"
    template: 'set'
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', @params.set
      Session.set 'subtitle', Session.get('Words').length + ' words'
      Session.set 'set', @params.set
      Session.set 'addSets', [Sets.findOne({name: @params.set})._id]
      Session.set 'time', null
      @render()


Router.waitOn ->
  Meteor.subscribe 'user'