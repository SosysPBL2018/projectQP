require 'test_helper'

class PostControllerTest < ActionDispatch::IntegrationTest
  test "topics index page should exist" do
    get topics_url
    assert_response :success
  end

  test "topics show page should exist" do
    @topic = topics(:topic0)
    get topic_path(@topic)
    assert_response :success
  end

  test "topics create action should create new topic" do
    assert_difference('Topic.count') do
      post topics_path(topic: { title: 'test_title', body: 'test_body', genre_id: 1})
    end
    assert_response :redirect
    assert_redirected_to topic_path(assigns(:topic))
  end
end
