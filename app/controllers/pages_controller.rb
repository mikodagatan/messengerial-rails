class PagesController < ApplicationController
  def landing_page
  end

  def welcome_page
    @clients = Client.all
    @jobs = Job.all.by_required_date
  end

end
