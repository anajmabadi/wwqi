class PersianLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  protected 

  def page_number(page)
    unless page == current_page
      link(localize_number(page), page, :rel => rel_value(page))
    else
      tag(:em, localize_number(page))
    end
  end
  
  private 
  
  def localize_number(number=0)
    return I18n.locale == :fa ? number.to_farsi : number.to_s
  end  
  
end