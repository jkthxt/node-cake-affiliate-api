'use strict'


module.exports = (campaignId, creativeId, contactId, cb) ->
  data =
    campaignId: campaignId
    creativeId: creativeId
    contactId:  contactId

  @request '/affiliates/api/2/offers.asmx/SendCreativePack', data, cb