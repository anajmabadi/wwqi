class Exhibition < ActiveRecord::Base
  translates :title, :caption, :introduction, :conclusion, :author
end
