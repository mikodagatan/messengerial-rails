class JobsController < ApplicationController
  def new
    @job = Job.new
    @clients = Client.all
    @contact_persons = Array.wrap(nil)
    @addresses = Array.wrap(nil)
    @resources = User.all
    @statuses = Status.all
    @request_types = RequestType.all
  end

  def create
    @job = Job.new(job_params)
    @job.status_id = Status.find_by(name: "Open").id
    @job.user_id = current_user.id
    if @job.save
      flash[:success] = "job saved"
      redirect_to root_url
    else
      flash[:danger] = @job.errors.full_messages
      render action: :new
    end
  end

  def edit
    @job = Job.find(params[:id])
    @clients = Client.all
    @contact_persons = Array.wrap(@job.client.contact_persons)
    @addresses = Array.wrap(@job.client.addresses)
    @resources = User.all
    @statuses = Status.all
    @request_types = RequestType.all
  end

  def update
    @job = Job.find(params[:id])
    if params[:Scheduled]
      @job.update(status_id: 2)
      redirect_to root_url

    elsif params[:Completed]
      @job.update(status_id: 3)
      redirect_to root_url

    elsif params[:With_Issues]
      @job.update(status_id: 4)
      redirect_to root_url

    elsif @job.update_attributes(job_params)
      flash[:success] = "Job Edited"
      redirect_to root_url
    else
      flash[:danger] = "Job cannot be edited"
      render action: :new
    end
  end

  def resource_notes
    @job = Job.find(params[:job_id])
    @jobs = Array.wrap(Job.find(params[:job_id]))
  end


  def index
  end

  def show
    @job = Job.find(params[:id])
end

  private

  def job_params
    params.require(:job).permit(
      :id,
      :required_date,
      :client_id,
      :request_type_id,
      :user_id,
      :address_id,
      :request_description,
      :contact_person_id,
      :notes_to_resource,
      :resource_id,
      :status_id,
      :resource_notes
    )
  end

end
