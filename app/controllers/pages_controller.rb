class PagesController < ApplicationController
  before_action:forbid_login_user, only: [:about]
  
  def top
  end
  
  def about
  end
end
