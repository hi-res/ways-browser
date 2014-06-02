Event = require 'happens'

module.exports = class History extends Event
  history: window.history

  constructor:(@base_path)->
    # popped = false
    # initial = @pathname()

    # if window.location.hash?.length
    #   @replace window.location.hash.substr 1

    window.addEventListener 'popstate', =>

      # skips first pop if present (like in chrome)
      # if initial is @pathname() and not popped
      #   return popped = true

      @emit 'url:change', @pathname()
    , false

  pathname:->
    if !@base_path

      console.warn "doesnt have base_path"
      window.location.pathname
    else

      
      index   = String( window.location.pathname ).indexOf( @base_path )
      address = String( window.location.pathname ).substr( index )
      address = address.replace @base_path, ''
      

  push:( url, title, state )->

    window.history.pushState state, title, url
    document.title = title if title?
    @emit 'url:change', window.location.pathname

  replace:( url, title, state )->

    window.history.replaceState state, title, url
    document.title = title if title?