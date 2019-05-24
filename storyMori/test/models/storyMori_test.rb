require 'test_helper'

class StoryMoriTest < ActionDispatch::IntegrationTest

    test "get story return 200" do
        get "http://localhost:3001/api/stories" 
        assert_equal 200, @response.status
        assert @response.body != nil
    end

    test "post story success" do
        post "http://localhost:3001/api/stories", as: :json, params: {title: "test", text: "ok"}
        assert_equal "test", Story.all.last.title
        assert_equal "ok", Page.find_by("story_id": Story.all.last.id).text
    end

    test "get page created return 201" do
        post "http://localhost:3001/api/stories", as: :json, params: {title: "test", text: "ok"}
        storyId = Story.all.last.id
        get "http://localhost:3001/api/stories/#{storyId}/pages/1" 
        assert_equal 201, @response.status
        assert @response.body != nil
    end

    test "post page success" do
        # post page success
        post "http://localhost:3001/api/stories", as: :json, params: {title: "test", text: "ok"}
        storyId = Story.all.last.id
        get "http://localhost:3001/api/stories/#{storyId}/pages/1" 
        post "http://localhost:3001/api/stories/#{storyId}/pages/1/next", as: :json, params: {name: "test", text: "ok"}
        assert_equal 200, @response.status
        # check page 2 is generated right
        get "http://localhost:3001/api/stories/#{storyId}/pages/2" 
        nextPage = JSON.parse(@response.body)
        assert_equal "test", nextPage["name"]
    end
end
