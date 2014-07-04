'use strict'


module.exports = (offerId, cb) ->
  query =
    offerId: offerId

  @request '/affiliates/api/2/offers.asmx/GetSuppressionList', query, cb