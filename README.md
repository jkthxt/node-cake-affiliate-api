CAKE Affiliate API for Node.js
=======================

[CAKE](http://getcake.com) is _SaaS platform providing marketing intelligence for perforfmance marketers_ (LinkedIn). These guys have many 
different APIs thus they provide big marketing platform. This module covers [Affiliate APIs](https://support.getcake.com/hc/en-us/sections/200129250-AFFILIATE-API-Documentation) group.

## Requirements

* CoffeeScript installed globally (for `cake build`)

## Installation

    npm install cake-affiliate-api --save

## Example

```js
'use strict'

var CakeAffiliateAPI = require('cake-affiliate-api')
  , options
  , client

options = {
  "apiKey":      "MY_API_KEY",
  "affiliateId": "100500",
  "baseUrl":     "https://cake.coolnetwork.com",
  "rawResponse": true
}

client = new CakeAffiliateAPI(options)

client.offerFeed({offerStatusId: 3}, handleResult)

function handleResult(err, data) {
  if (err) {
    // handle error...
  }
  else {
    handleData(data)
  }
}
```

## API

Keep in mind that every API option which is passed in `camelcase` is `underscore`d before making HTTP call. So it's OK to name options like `mediaTypeCategoryId` (converted to `media_type_category_id`).

### [getCampaign](https://support.getcake.com/hc/en-us/articles/200705940--Offers-GetCampaign-V2-Affiliate)(campaignId, callback)

### [getCreativeCode](https://support.getcake.com/hc/en-us/articles/200705950--Offers-GetCreativeCode-V2-Affiliate)(campaignId, creativeId, callback)

### [getCreativeTypes](https://support.getcake.com/hc/en-us/articles/200706350--Offers-GetCreativeTypes-V2-Affiliate)(callback)

### [getFeaturedOffer](https://support.getcake.com/hc/en-us/articles/200706360--Offers-GetFeaturedOffer-V2-Affiliate)(callback)

### [getMediaTypeCategories](https://support.getcake.com/hc/en-us/articles/200706370--Offers-GetMediaTypeCategories-V2-Affiliate)(callback)

### [getOfferStatuses](https://support.getcake.com/hc/en-us/articles/200706380--Offers-GetOfferStatuses-V2-Affiliate)(callback)

### [getPixelTokens](https://support.getcake.com/hc/en-us/articles/200705960--Offers-GetPixelTokens-V2-Affiliate)(callback)

### [getSubAffiliates](https://support.getcake.com/hc/en-us/articles/200706390--Offers-GetSubAffiliates-V2-Affiliate)(query, callback)

`query` options:

* `startAtRow` defaults to `1`
* `rowLimit` defaults to `0`

### [getSupressionList](https://support.getcake.com/hc/en-us/articles/200705970--Offers-GetSuppressionList-V2-Affiliate)(offerId, callback)

### [getTags](https://support.getcake.com/hc/en-us/articles/200706400--Offers-GetTags-V2-Affiliate)(callback)

### [getVerticalCategories](https://support.getcake.com/hc/en-us/articles/200705980--Offers-GetVerticalCategories-V2-Affiliate)(callback)

### [getVerticals](https://support.getcake.com/hc/en-us/articles/200705990--Offers-GetVerticals-V2-Affiliate)(callback)

### [offerFeed](https://support.getcake.com/hc/en-us/articles/200704910--Offers-OfferFeed-V4-Affiliate)(query, callback)

`query` options:

* `campaignName` defaults `''`
* `mediaTypeCategoryId` defaults to `0`
* `verticalCategoryId` defaults to `0`
* `verticalId` defaults to `0`
* `offerStatusId` defaults to `0`
* `tagId` defaults to `0`
* `startAtRow` defaults to `1`
* `rowLimit` defaults to `0`

## Options

* **apiKey** defaults to `null`

    * API key. Read [Affiliate API Documentation Notes](https://support.getcake.com/hc/en-us/articles/202456680-Affiliate-API-Documentation-Notes) to know where to get it.

* **affiliateId** defaults to `null`

    * Affiliate Id. Read documentation above.

* **baseUrl** defaults to `null`

    * API endpoint of CAKE-based network.

* _rawResponse_ defaults `false`

    * If `true` xml2js is not called for XML response and it's returned as string.

* _parser_ defaults to `null`

    * Should be a function like `parse(xmlString, callback)` where `callback` accepts `(err, response)`

* _xml2jsOptions_ defaults to `{explicitArray: false}`

    * Options passed to `xml2js.parseString()`. If specified will overwrite defaults. **Also if specified, client won't try to process response smartly (i.e. if response outputs collection it will return raw `xml2js` output instead of array).**

## FAQ

**Why module is writted on CoffeeScript but compiled to JavaScript after `npm install`?**

I really like CoffeeScript for fast module development but dislike when people do something like this:

    require('coffee-script');
    require('./module.coffee');

Why should we do this if in the end all is compiled to JavaScript? :wink:

## TODO

* Implement ALL APIs
