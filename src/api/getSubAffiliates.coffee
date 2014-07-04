'use strict'

module.exports = (query = {}, cb) ->
  query.startAtRow ?= 1
  query.rowLimit ?= 0

  @request '/affiliates/api/2/offers.asmx/GetSubAffiliates', query, cb