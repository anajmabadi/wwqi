# config/initializers/pdfkit.rb
PDFKit.configure do |config|
  #config.wkhtmltopdf = `which wkhtmltopdf`.strip
  config.default_options = {
    :page_size => 'Letter',
    :print_media_type => true,
    :encoding => 'UTF-8',
    :header_font_size => 6,
    :footer_font_size => 6,
    :footer_right => I18n.translate(:site_title).gsub("'", ""),
    :footer_center => "[page] of [toPage]",
    :footer_left => I18n.translate(:all_rights_reserved)
  }
end
