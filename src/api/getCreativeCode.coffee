'use strict'


module.exports = (campaignId, creativeId, cb) ->
  query =
    campaignId: campaignId
    creativeId: creativeId

  @request '/affiliates/api/2/offers.asmx/GetCreativeCode', query, cb
