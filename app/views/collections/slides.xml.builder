xml.instruct!
xml.DATA do
  xml.SLIDESHOW(:AUTOPLAY=>"0", :AUTOLOOP=>"1", :SLIDELIST=>"0", :GALLERYHEIGHT=>"80", :GALLERYPOSITION=>"bottom", :GALLERYTOOLTIPS=>"1",:GALLERYBACKCOLOR=>"CCCCCC")
  @slides.each do |slide|
    xml.SLIDE(:ID=>slide.id.to_s,
      :MEDIA=>slide.item.zoomify_url(slide.position),
      :NAME=>slide.title.blank? ? slide.item.title : slide.title,
      :INITIALX=>"",
      :INITIALY=>"",
      :INITIALZOOM=>"-1",
      :MINZOOM=>"-1",
      :MAXZOOM=>"100",
      :INTERVAL=>"2000",
      :TRANSITION=>"Fade",
      :DURATION=>"500")
  end
end