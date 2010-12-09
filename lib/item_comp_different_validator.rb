class ItemCompDifferentValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    if value ==  object.comp_id
      object.errors[attribute] << (options[:message] || "cannot equal comp_id")  
    end  
  end  
end 