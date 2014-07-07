'use strict'


module.exports = (exportFeedId, data, cb) ->
  data.exportFeedId = exportFeedId

  @request '/affiliates/api/2/offers.asmx/CreativeFeed', data, cb