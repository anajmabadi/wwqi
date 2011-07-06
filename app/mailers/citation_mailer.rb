class CitationMailer < ActionMailer::Base
  default :from => "wwqi@fas.harvard.edu"
  
  def email_citation(to, from, note, html_citations, text_citations)
  	@note = note
  	@html_citations = html_citations
  	@text_citations = text_citations
  	subject = I18n.translate(:site_title) + ": " + I18n.translate(:email_citation)
  	mail(:to => to, :from => 'wwqi@fas.harvard.edu', :reply_to => from, :subject => @subject)
  end

end
