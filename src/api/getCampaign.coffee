'use strict'


module.exports = (campaignId, cb) ->
  query =
    campaignId: campaignId

  @request '/affiliates/api/2/offers.asmx/GetCampaign', query, cb
