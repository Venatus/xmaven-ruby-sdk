require 'test/unit'
require 'Xmaven'

class TestClass < Test::Unit::TestCase
  
  @@api = Xmaven::API.new(::XMAVEN_API_USER_ID, ::XMAVEN_API_KEY)
  
  def assert_date_format(str, message = '')
    assert_match(/^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$/i, str, message)
  end
  
  def assert_boolean(value, message = '')
    assert(!!value == value, message)
  end
  
  def assert_has_key(obj, key,  message = '')
    assert(obj.key?(key), message)
  end
  
end

