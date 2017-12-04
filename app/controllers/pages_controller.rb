class PagesController < ApplicationController
  def landing_page
  end

  def welcome_page
    @clients = Client.all
  end

end
