class Exhibition < ActiveRecord::Base
  translates :title, :caption, :introduction, :conclusion, :author, :display_date
end
