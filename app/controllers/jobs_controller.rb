class JobsController < ApplicationController
  def new
    @job = Job.new
    @clients = Client.all
    @contact_persons = Array.wrap(nil)
    @addresses = Array.wrap(nil)
    @resources = User.all
    @statuses = Status.all
  end

  def create
    @job = Job.new(job_params)
    @job.status_id = Status.find_by(name: "Open")
    @job.user_id = current_user
    if @job.save
      flash[:success] = "job saved"
      redirect_to root_url
    else
      flash[:danger] = "submission not saved"
      render action: :new
    end
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
      :user_id,
      :address,
      :request_description,
      :contact_person_id,
      :notes_to_resource,
      :resource_id,
      :status_id,
      :resource_notes
    )
  end

end
