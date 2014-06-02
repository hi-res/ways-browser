Event = require 'happens'

class PseudoHistory extends Array
  state: null


module.exports = class Hash extends Event

  history: null

  constructor: (@base_path)->

    @history = new PseudoHistory

    hash     = window.location.hash
    pathname = window.location.pathname.replace @base_path, ""

    # if hash is ''
    #   if pathname.length > 1
    #     window.location.href = '/#'+ pathname
    #   else
    #     window.location.href = '#/'

    window.attachEvent 'onhashchange', =>
      @emit 'url:change', @pathname()

    , false

  pathname:->
    if !@base_path
      window.location.hash
    else
      index   = String( window.location ).indexOf( @base_path )
      address = String( window.location ).substr( index )
      address.replace @base_path, ''


  push:( url, title, state )->

    if @base_path?
      if url.indexOf( @base_path ) != -1
        url = url.replace @base_path, ''

    @history.push @history.state = state
    window.location.hash = url
    document.title = title if title?
    # @emit 'url:change', @pathname()

  replace:( url, title, state )->

    if @base_path?
      if url.indexOf( @base_path ) != -1
        url = url.replace @base_path, ''
    
    @history[@history.length-1] = @history.state = state
    document.title = title if title?
    window.location.hash.replace url