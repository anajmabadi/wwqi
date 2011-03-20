class Admin::AdminController < ApplicationController
  
  require 'csv'
  
  # adds basic security to all admin controllers that inherit from this one
  before_filter :admin_required

  # assign the admin layout to all the admin pages which inherit from here
  layout 'admin'

end
