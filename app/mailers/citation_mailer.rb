class CitationMailer < ActionMailer::Base
  default :from => "info@qajarwomen.org"
  
  def email_citation(to,from,note,html_citations,text_citations)
  	@note = note
  	@html_citations = html_citations
  	@text_citations = text_citations
  	subject = I18n.translate(:site_title) + ": " + I18n.translate(:email_citation)
  	mail(:to => to, :from => from, :subject => @subject)
  end
end
