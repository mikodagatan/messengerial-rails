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
