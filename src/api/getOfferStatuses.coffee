'use strict'


module.exports = (cb) ->
  @request('/affiliates/api/2/offers.asmx/GetOfferStatuses', cb)
