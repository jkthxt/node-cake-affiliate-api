'use strict'


module.exports = (exportFeedId, updatesSince, cb) ->
  data =
    exportFeedId: exportFeedId
    updatesSince: updatesSince

  @request '/affiliates/api/2/offers.asmx/CreativeFeed', data, cb