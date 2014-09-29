Event = require 'happens'

History = require './history'
Hash = require './hash'

module.exports = class Index extends Event
  
  api: null
  base_path: null

  constructor:->
    @base_path = window.location.base_path || ''

    if window.history.pushState?
      @api = new History @base_path
    else
      @api = new Hash @base_path
    

    @api.on 'url:change', (pathname)=>
      @emit 'url:change', pathname

    @history = @api.history

  pathname:->
    @api.pathname()

  push:( url, title, state )->
    @api.push url, title, state

  replace:( url, title, state )->
    @api.replace url, title, state