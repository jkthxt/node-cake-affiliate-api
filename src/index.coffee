'use script'

createCustomError = require 'custom-error-generator'
debug             = (require 'debug') 'cake-affiliate-api'
fs                = require 'fs'
request           = require 'request'
lodash            = require 'lodash'
path              = require 'path'
xml2js            = require 'xml2js'


CakeAPIError = createCustomError 'CakeAPIError', null, (@message, @code) ->


class CakeAffiliateAPI
  constructor: (options) ->
    if not options.affiliateId or not options.apiKey or not options.baseUrl
      throw new Error 'Credentials for Affiliate API are not specified'

    {
      affiliateId: @affiliateId,
      apiKey:      @apiKey,
      baseUrl:     @baseUrl,
      rawResponse: @rawResponse,
      parser:      @parser
    } = options

    if not @parser
      defaultOptions =
        explicitArray: false

      if not options.xml2jsOptions
        @parserOptions = defaultOptions
      else
        @parserOptions = options.xml2jsOptions

      self = @

      @parser = (data, callback) ->
        xml2js.parseString data, self.parserOptions, (err, result) ->
          return callback new CakeAPIError 'Result parse error', -1, err if err

          return callback null, result if self.parserOptions is not defaultOptions

          response = self.getResponseObject result

          if response instanceof Error
            callback response
          else
            callback null, response


  underscoreQuery: (query) ->
    lodash.each query, (value, key) ->
      newKey = key.replace /([A-Z])/g, ($1) -> '_' + $1.toLowerCase()
      query[newKey] = value
      delete query[key]

  getResponseObject: (xmlDoc) ->
    keys = Object.keys xmlDoc

    responseKey = key for key in keys when ~key.indexOf('_response')

    xmlDoc = xmlDoc[responseKey]

    if not xmlDoc.success
      # api_response:
      #   success: false
      #   message: 'Bad boy! :P'
      new CakeAPIError xmlDoc.message, -1

    # api_response:
    #   success: true
    #   row_count: 1
    #   items:
    #     result: [
    #       itemA,
    #       itemB
    #     ]

    keys = Object.keys xmlDoc
    idx = keys.indexOf 'row_count'

    if idx is -1 or idx + 1 is keys.length
      xmlDoc

    if xmlDoc.row_count is 0
      []

    listKey = keys[idx + 1]

    # items:
    #   result: [
    #     itemA,
    #     itemB
    #   ]
    xmlDoc = xmlDoc[listKey]

    arrayKey = (Object.keys xmlDoc).shift()

    # [
    #   itemA,
    #   itemB
    # ]
    #
    # or just
    #
    # itemA
    array = xmlDoc[arrayKey]

    if Array.isArray array
      array
    else
      [array]

  request: (method = 'GET', api, query = {}, callback) ->
    if arguments.length is 3 and typeof api is 'object'
      callback = query
      query = api
      api = method
      method = 'GET'
    else if arguments.length is 3
      callback = query
      query = {}
    if arguments.length is 2
      callback = api
      api = method
      method = 'GET'
      query = {}

    self = @

    @underscoreQuery query

    query.api_key = @apiKey
    query.affiliate_id = @affiliateId

    req =
      uri:    @baseUrl + api
      method: 'GET'
      qs:     query

    debug('REQUEST ' + JSON.stringify(req))
    request req, (err, res, data) ->
      return callback new CakeAPIError 'Request error', -1, err if err

      return callback new CakeAPIError data, res.statusCode if res.statusCode is not 200

      return callback null, data if self.rawResponse

      self.parser data, callback

module.exports = CakeAffiliateAPI


(fs.readdirSync __dirname + '/api').forEach (filename) ->
  if not /\.js$/.test filename
    return

  name = path.basename filename, '.js'

  CakeAffiliateAPI.prototype.__defineGetter__ name, () ->
    return require './api/' + name
