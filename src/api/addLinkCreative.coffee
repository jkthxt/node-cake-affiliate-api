'use strict'


module.exports = (campaignId, data, cb) ->
  data.campaignId = campaignId

  @request '/api/2/offers.asmx/AddLinkCreative', cb