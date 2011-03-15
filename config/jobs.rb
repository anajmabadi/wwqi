require 'stalker'
include Stalker

require File.expand_path("../environment", __FILE__)

job "make_pdfs" do |args|
  html = args["html"]
  pdf_path = args["pdf_path"]
  kit = PDFKit.new(html, :encoding => 'UTF-8')
  kit.stylesheets << "#{Rails.root}/public/stylesheets/pdf.css"
  kit.stylesheets << "#{Rails.root}/public/stylesheets/pdf_fa.css" if I18n.locale == :fa
  kit.to_file(pdf_path)
end

job "make_live_pdfs" do |args|
  url = args["url"]
  pdf_path = args["pdf_path"]
  kit = PDFKit.new(url)
  kit.to_file(pdf_path)
end