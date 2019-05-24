class PagesController < ApplicationController
    def getPage
        page = Page.find_by("cur_pageId": params[:pageId], "story_id": params[:storyId])
        childrenPage = Page.where("parent_id": params[:pageId]) 
        render json: {"id": page.cur_pageId, "name": page.name, "text": page.text, "children": childrenPage}, status: :created
    end

    def nextPage
        page = Page.find_by("story_id": params[:storyId])
        cur_page = Page.where("story_id": params[:storyId]).length
        childPage = Page.new(name: params[:name], text: params[:text])
        childPage.story_id = page.story_id
        childPage.parent_id = page.id
        childPage.cur_pageId = cur_page + 1
        childPage.save
        render json: {"id": childPage.cur_pageId}, status: 200
    end
end
