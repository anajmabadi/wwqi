class Era < ActiveRecord::Base
    translates :title
    globalize_accessors :en, :fa
    default_scope :include => [:translations]
end
