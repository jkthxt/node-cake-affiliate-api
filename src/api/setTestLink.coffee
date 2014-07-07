'use strict'


module.exports = (campaignId, testLink, cb) ->
  data =
    campaignId: campaignId
    testLink:   testLink

  @request '/affiliates/api/2/offers.asmx/SetTestLink', data, cb