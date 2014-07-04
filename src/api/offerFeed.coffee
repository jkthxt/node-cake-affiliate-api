'use strict'


module.exports = (query, cb) ->
  if arguments.length is 1
    cb = query
    query = {}

  query.campaignName ?= ''
  query.mediaTypeCategoryId ?= 0
  query.verticalCategoryId ?= 0
  query.verticalId ?= 0
  query.offerStatusId ?= 0
  query.tagId ?= 0
  query.startAtRow ?= 1
  query.rowLimit ?= 0

  @request '/affiliates/api/4/offers.asmx/OfferFeed', query, cb
