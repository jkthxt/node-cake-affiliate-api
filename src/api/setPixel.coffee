'use strict'


module.exports = (campaignId, pixelHtml, cb) ->
  data =
    campaignId: campaignId
    pixelHtml:  pixelHtml

  @request '/affiliates/api/2/offers.asmx/SetPixel', data, cb