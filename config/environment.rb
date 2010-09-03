# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Qajar::Application.initialize!

# patching mysql over coding issues
require 'mysql_utf8'

# providing a persian page number rendered
require 'persian_link_renderer'
