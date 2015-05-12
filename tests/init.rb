$LOAD_PATH << '../src'

require 'Xmaven'

xm = Xmaven::API.new('YOUR-USER-ID','YOUR-API-KEY')
resp = xm.makeRequest('GET','/v1/media?limit=5')

puts resp