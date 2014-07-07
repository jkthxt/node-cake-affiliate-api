'use strict'


module.exports = (offerContractId, data, cb) ->
  data.offerContractId = offerContractId

  @request '/api/3/offers.asmx/ApplyForOffer', data, cb