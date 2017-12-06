class PagesController < ApplicationController
  def landing_page
  end

  def welcome_page
    @clients = Client.all
    @jobs = Job.all.by_required_date
  end

  def your_jobs
    @jobs = Job.where(resource_id: current_user.id).by_required_date
  end

end
