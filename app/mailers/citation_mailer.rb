class CitationMailer < ActionMailer::Base
  default :from => "info@qajarwomen.org"
  
  def send_citation
  	@to = params[:to]
  	@from = params[:from]
  	@body = params[:notes].blank? "" : params[:notes]
  	@body += params[:citation] unless params[:citation].blank?
  	@subject = I18n.translate(:site_title) + ": " + I18n.translate(:email_citation)
  	mail(:to => @to, :from => @from, :subject => @subject)
  end
end
