<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><%= wicked_pdf_stylesheet_link_tag "pdf" -%><%= wicked_pdf_javascript_include_tag "number_pages" %>
		<title></title>
	</head>
	<body onload='number_pages'>
		<div id="header">
			<%= wicked_pdf_image_tag 'mysite.jpg' %>
		</div>
		<div id="content">
			<%= yield %>
		</div>
	</body>
</html>