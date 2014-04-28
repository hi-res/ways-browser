Event = require 'happens'

class PseudoHistory extends Array
  state: null


module.exports = class Hash extends Event

  history: null

  constructor:->
    @history = new PseudoHistory

    hash = window.location.hash
    pathname = window.location.pathname

    @base_path = window.location.base_path || ''

    pathname = pathname.replace @base_path, ''

    if pathname == '/' then pathname = ''

    console.log "@base_path ->", @base_path
    console.log "hash ->", hash
    console.log "pathname ->", pathname

    if hash is ''
      if pathname.length > 1

        console.warn 1 + " : " + @base_path + '#/'+ pathname
        window.location.href = @base_path + '#/'+ pathname
      # else
      #   console.warn 2

      #   window.location.href = @base_path + '#/'

    window.attachEvent 'onhashchange', =>
      console.warn 3

      @emit 'url:change', @pathname()
    , false

  pathname:->
    pathname = window.location.hash

    if pathname.substr( 0, 2 ) == '#/'
      pathname = pathname.substr( 2 )
    
    console.warn "pathname returning  -> ", pathname

    pathname


  push:( url, title, state )->

    if url.indexOf( @base_path ) != 0
      url = @base_path + url

    @history.push @history.state = state

    window.location.hash = url

    document.title = title if title?

    @emit 'url:change', @pathname()

  replace:( url, title, state )->

    @history[@history.length-1] = @history.state = state

    document.title = title if title?

    window.location.hash.replace url