class Page < ActiveRecord::Base
  translates :title, :caption, :body, :author
end
