class StoriesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def getStories
        story = Story.all
        render json: story.as_json, status: 200
    end

    def saveStories
        story = Story.create(title: params[:title], summary: params[:text])
        page = story.pages.create(name: params[:title], text: params[:text], cur_pageId: 1)
        story.parentId = page.id
        story.save
        render json: {"storyId": story.id, "pageId": page.id}, status: :created
    end

end
