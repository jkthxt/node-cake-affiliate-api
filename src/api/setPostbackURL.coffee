'use strict'


module.exports = (campaignId, postbackURL, cb) ->
  data =
    campaignId:  campaignId
    postbackUrl: postbackURL

  @request '/affiliates/api/2/offers.asmx/SetPostbackURL', data, cb