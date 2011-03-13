# config/initializers/pdfkit.rb
PDFKit.configure do |config|
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  config.default_options = {
    :page_size => 'Legal',
    :print_media_type => true,
    :encoding => 'UTF-8',
    :header_font_size => 6,
    :footer_font_size => 6,
    :footer_right => I18n.translate(:site_title),
    :footer_center => "[page] of [toPage]",
    :footer_left => I18n.translate(:all_rights_reserved)
  }
end