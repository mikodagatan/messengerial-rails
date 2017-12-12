class JobsController < ApplicationController


  def new
    @job = Job.new
    @clients = Client.all
    @contact_persons = Array.wrap(nil)
    @addresses = Array.wrap(nil)
    @resources = User.all
    @statuses = Status.all
    @request_types = RequestType.all
    @target_clients = Array.wrap(nil)
  end

  def create
    @job = Job.new(job_params)
    @job.status_id = Status.find_by(name: "Open").id
    @job.user_id = current_user.id
    if @job.save
      flash[:success] = "Task created for resource, #{@job.resource.full_name}, and client, #{@job.client.name}, with target client, #{@job.target_client.name}"
      redirect_to root_url
      notif_new_task(@job)
    else
      flash[:danger] = @job.errors.full_messages
      redirect_to new_job_url
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
      notif_change_status_scheduled(@job)
    elsif params[:Completed]
      @job.update(status_id: 3)
      redirect_to root_url
      notif_change_status_completed(@job)
    elsif params[:With_Issues]
      @job.update(status_id: 4)
      redirect_to root_url
      notif_change_status_with_issues(@job)
    elsif params[:Resource_Notes]
      redirect_to root_url
      notif_resource_notes(@job)
    elsif @job.update_attributes(job_params)
      flash.now[:success] = "Job Edited"
      redirect_to root_url
      notif_edit_task(@job)
    else
      flash.now[:danger] = "Job cannot be edited"
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
      :target_client_id,
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

  def notif_change_status_scheduled(job)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: job.resource_id,
      job_id: job.id,
      notification_type: 'notif_change_status_scheduled'
    )
  end
  def notif_change_status_with_issues(job)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: job.resource_id,
      job_id: job.id,
      notification_type: 'notif_change_status_with_issues'
    )
  end
  def notif_change_status_completed(job)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: job.resource_id,
      job_id: job.id,
      notification_type: 'notif_change_status_completed'
    )
  end
  def notif_new_task(job)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: job.resource_id,
      job_id: job.id,
      notification_type: 'notif_new_task'
    )
  end
  def notif_edit_task(job)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: job.resource_id,
      job_id: job.id,
      notification_type: 'notif_edit_task'
    )
  end
  def notif_resource_notes(job)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: job.user_id,
      job_id: job.id,
      notification_type: 'notif_resource_notes'
    )
  end
end
