class Admin::AdminController < ApplicationController
  
  # adds basic security to all admin controllers that inherit from this one
  before_filter :admin_required
  
end
