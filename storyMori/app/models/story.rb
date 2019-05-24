class Story < ApplicationRecord
    has_many :pages, foreign_key: "story_id"
end
