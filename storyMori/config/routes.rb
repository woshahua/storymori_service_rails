Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/api/stories" => "stories#getStories"
  post "/api/stories" => "stories#saveStories"
  get "/api/stories/:storyId/pages/:pageId" => "pages#getPage"
  post "/api/stories/:storyId/pages/:pageId/next" => "pages#nextPage"
  get "/api/*" => "stories#notFound"

end
