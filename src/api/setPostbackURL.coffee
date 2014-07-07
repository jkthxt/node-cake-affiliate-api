'use strict'


module.exports = (campaignId, postbackHtml, cb) ->
  data =
    campaignId:   campaignId
    postbackHtml: postbackHtml

  @request '/affiliates/api/2/offers.asmx/SetPostbackURL', data, cb