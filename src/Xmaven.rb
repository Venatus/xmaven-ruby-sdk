require 'curb'
require 'json'

module Xmaven

  class APIError < StandardError
  end

  class API

    @@baseUri = 'https://api.xmaven.com'

    def initialize(userId, privateKey, accountId = nil)
      @userId = userId
      @privateKey = privateKey
      @accountId = nil
    end

    def makeRequest(type='GET', endPoint='/', data={})
      case type
      when 'GET'
        http = Curl.get(@@baseUri + endPoint) do|http|
          http.headers['USERID'] = @userId
          http.headers['APIKEY'] = @privateKey
          http.headers['ACCOUNTID'] = @accountId
        end
      when 'POST'
        http = Curl.post(@@baseUri + endPoint, data.to_json) do |http|
          http.headers['USERID'] = @userId
          http.headers['APIKEY'] = @privateKey
          http.headers['ACCOUNTID'] = @accountId
          http.headers['Content-Type'] = 'application/json'
        end
      when 'PUT'
        http = Curl.put(@@baseUri + endPoint, data.to_json) do |http|
          http.headers['USERID'] = @userId
          http.headers['APIKEY'] = @privateKey
          http.headers['ACCOUNTID'] = @accountId
          http.headers['Content-Type'] = 'application/json'
        end
      when 'DELETE'
        http = Curl.delete(@@baseUri + endPoint, data.to_json) do |http|
          http.headers['USERID'] = @userId
          http.headers['APIKEY'] = @privateKey
          http.headers['ACCOUNTID'] = @accountId
          http.headers['Content-Type'] = 'application/json'
        end
      else
        raise 'Unknown request type'
      end
      jsonString = http.body_str
      begin
        jsonHash = JSON.parse jsonString
      rescue
        raise Xmaven::APIError, 'Unable to parse response'
      end
      return jsonHash
    end
  end

end