'use script'

createCustomError = require 'custom-error-generator'
debug             = (require 'debug') 'cake-affiliate-api'
fs                = require 'fs'
qs                = require 'querystring'
request           = require 'request'
lodash            = require 'lodash'
path              = require 'path'
util              = require 'utils'
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
      rawResponse: @rawResponse
    } = options

  underscoreQuery: (query) ->
    lodash.each query, (value, key) ->
      newKey = key.replace /([A-Z])/g, ($1) -> '_' + $1.toLowerCase()
      query[newKey] = value
      delete query[key]

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
      if err
        return callback new CakeAPIError 'Request error', -1, err
      else if res.statusCode is not 200
        return callback new CakeAPIError data, res.statusCode

      if self.rawResponse
        return callback null, result

      xml2js.parseString data, explicitArray: false, (err, result) ->
        if err
          return callback new CakeAPIError 'Result parse error', -1, err

        callback null, result


module.exports = CakeAffiliateAPI


(fs.readdirSync __dirname + '/api').forEach (filename) ->
  if not /\.js$/.test filename
    return

  name = path.basename filename, '.js'

  CakeAffiliateAPI.prototype.__defineGetter__ name, () ->
    return require './api/' + name
