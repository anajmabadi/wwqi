class CitationMailer < ActionMailer::Base
  default :from => "info@qajarwomen.org"
  
  def email_citation(to,from,note,citation)
  	@to = to
  	@from = from
  	@note = note
  	@citation = citation
  	logger.info "citation: " + citation.to_s
  	@subject = I18n.translate(:site_title) + ": " + I18n.translate(:email_citation)
  	mail(:to => @to, :from => @from, :subject => @subject)
  end
end
