'use strict'


module.exports = (offerContractId, data, cb) ->
  data.offerContractId = offerContractId

  if data.agreedToTerms
    data.agreedToTerms = 'TRUE'
  else
    data.agreedToTerms = 'FALSE'

  @request '/api/3/offers.asmx/ApplyForOffer', data, cb