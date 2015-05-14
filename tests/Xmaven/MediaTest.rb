require 'TestClass'

class MediaTest < TestClass
  @@created_media_id = nil
  
  def setup
    @testTitle = 'Xmaven SDK RubyUnit Test Title'
    @testDescription = 'Xmaven SDK RubyUnit Test Description'
    @testTags = ['RubyUnit', 'Test']
    @isPublished = false
    @isMarketplace = false
    @testState = 0
  end
  
  def assert_media_object_array_correct(obj)
    assert_has_key(obj, 'id', 'Missing id')
    assert_has_key(obj, 'title', 'Missing title')
    assert_has_key(obj, 'description', 'Missing description')
    assert_has_key(obj, 'tags', 'Missing tags')
    assert_has_key(obj, 'is_published', 'Missing is_published')
    assert_has_key(obj, 'is_marketplace', 'Missing is_marketplace')
    assert_has_key(obj, 'author_screen_name', 'Missing author_screen_name')
    assert_has_key(obj, 'date_created', 'Missing date_created')
    assert_has_key(obj, 'date_updated', 'Missing date_updated')
    assert_has_key(obj, 'state', 'Missing state')
    assert_has_key(obj, 'nice_state', 'Missing nice_state')
    assert_has_key(obj, 'simple_state', 'Missing simple_state')
    assert_has_key(obj, 'error', 'Missing error')
    assert_has_key(obj, 'ready', 'Missing ready')
    
    assert_match(/^[0-9a-z]+$/i, obj['id'], 'Wrong id')
    assert_match(/^.+$/, obj['nice_state'], 'Wrong nice_state')
    assert_match(/^.+$/, obj['simple_state'], 'Wrong simple_state')
    
    assert_boolean(obj['error'], 'Wrong error')
    assert_boolean(obj['ready'], 'Wrong ready')
    
    assert_date_format(obj['date_created'], 'Wrong date_created')
    assert_date_format(obj['date_updated'], 'Wrong date_updated')
  end
  
  def assert_test_data_matches(obj)
    assert_equal(@testTitle, obj['title'])
    assert_equal(@testDescription, obj['description'])
    assert_equal(@testTags, obj['tags'])
    assert_equal(@isPublished, obj['is_published'])
    assert_equal(@isMarketplace, obj['is_marketplace'])
    assert_equal(@testState, obj['state'])
    assert_equal(false, obj['error'])
    assert_equal(@testState != 0, obj['ready'])
  end
  
  def test_1_create_media
    r = @@api.makeRequest('POST','/v1/media', {
      'title' => @testTitle,
      'description' => @testDescription,
      'tags' => @testTags,
      'is_published' => @isPublished,
      'is_marketplace' => @isMarketplace,
    })
    
    assert_has_key(r, 'success')
    assert_equal(true, r['success'])
    assert_has_key(r, 'obj')
    obj = r['obj']
    
    assert_media_object_array_correct(obj)
    assert_test_data_matches(obj)
    
    @@created_media_id = obj['id']
  end
  
  def test_2_list_media
    r = @@api.makeRequest('GET','/v1/media?filter_title=' + @testTitle[0, 15] + '&sort_on=title&sort_direction=-1&limit=1')
    
    assert_has_key(r, 'success')
    assert_equal(true, r['success'])
    assert_has_key(r, 'obj_count')
    assert_equal(1, r['obj_count'])
    assert_has_key(r, 'sort')
    assert_equal({'title' => -1}, r['sort'])
    assert_has_key(r, 'objs')
    objs = r['objs']
    assert_instance_of(Array, objs)
    assert_equal(1, objs.size)
    obj = objs[0]
    
    assert_media_object_array_correct(obj)
    assert_test_data_matches(obj)
  end
  
  def test_3_update_media
    @testTitle += ' Updated';
    @testDescription += ' Updated';
    @testTags << 'Updated';
    r = @@api.makeRequest('PUT','/v1/media', {
      'id' => @@created_media_id,
      'title' => @testTitle,
      'description' => @testDescription,
      'tags' => @testTags,
    })
    
    assert_has_key(r, 'success')
    assert_equal(true, r['success'])
    assert_has_key(r, 'obj')
    obj = r['obj']
    
    assert_media_object_array_correct(obj)
    assert_test_data_matches(obj)
  end
  
  def test_4_delete_media
    r = @@api.makeRequest('DELETE','/v1/media', {
      'id' => @@created_media_id,
    })
    
    assert_has_key(r, 'success')
    assert_equal(true, r['success'])
    assert_equal(@@created_media_id, r['id'])
  end
  
end