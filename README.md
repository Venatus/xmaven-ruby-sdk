# XMAVEN SDK for Ruby

[![@XmavenVideo on Twitter](http://img.shields.io/badge/twitter-%40xmavenvideo-blue.svg?style=flat)](https://twitter.com/xmavenvideo)

This module has been created for Ruby developers using the Xmaven platform. It provides a very lightweight wrapper to communicate with Xmaven API. Getting started could not be easier, simply add this module to your code base.

### Requirements

This library makes use of curb. All the details can be found here: https://github.com/taf2/curb

### Ruby Examples

```ruby

# Import the module

require 'Xmaven'

# Create an instance of the wrapper class

xm = Xmaven::API.new('YOUR-USER-ID','YOUR-API-KEY')

# Return media in the library

resp = xm.makeRequest('GET','/v1/media?limit=5')

# Create a new media item

resp = xm.makeRequest('POST','/v1/media',{'title'=>'test'})

```

### Documentation

More information can be found in the online documentation at
https://docs.xmaven.com/api/01-installation