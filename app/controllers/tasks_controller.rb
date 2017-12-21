class TasksController < ApplicationController

  def new
    @task = Task.new
    @clients = Client.all
    @contact_persons = Array.wrap(nil)
    @addresses = Array.wrap(nil)
    @resources = User.all
    @statuses = Status.all
    @request_types = RequestType.all
    @target_clients = Array.wrap(nil)
  end

  def create
    @task = Task.new(task_params)
    @task.status_id = Status.find_by(name: "Open").id
    @task.user_id = current_user.id
    if @task.save
      flash[:success] = "Task created for resource, #{@task.resource.full_name}, and client, #{@task.client.name}, with target client, #{@task.target_client.name}"
      redirect_to root_url
      notif_new_task(@task)
    else
      flash[:danger] = @task.errors.full_messages
      redirect_to new_task_url
    end
  end

  def edit
    @task = Task.find(params[:id])
    @clients = Client.all
    @contact_persons = Array.wrap(@task.client.contact_persons)
    @addresses = Array.wrap(@task.client.addresses)
    @resources = User.all
    @statuses = Status.all
    @request_types = RequestType.all
  end

  def update
    @task = Task.find(params[:id])
    if params[:Scheduled]
      @task.update(status_id: 2)
      redirect_to root_url
      notif_change_status_scheduled(@task)
    elsif params[:Completed]
      @task.update(status_id: 3)
      redirect_to root_url
      notif_change_status_completed(@task)
    elsif params[:With_Issues]
      @task.update(status_id: 4)
      redirect_to root_url
      notif_change_status_with_issues(@task)
    elsif params[:Resource_Notes]
      redirect_to root_url
      notif_resource_notes(@task)
    elsif @task.update_attributes(task_params)
      flash.now[:success] = "task Edited"
      redirect_to root_url
      notif_edit_task(@task)
    else
      flash.now[:danger] = "task cannot be edited"
      render action: :new
    end
  end

  def resource_notes
    @task = Task.find(params[:task_id])
    @tasks = Array.wrap(task.find(params[:task_id]))
  end

  def history
    @task = Task.find(params[:task_id])
    @tasks = Array.wrap(@task)
    @completed = 3
    @history = Notification.joins(:task)
      .where(third_id: nil)
      .where(task: @task)
      .where.not(tasks: {status_id: @completed})
      .where.not(notification_type: "notif_welcome")
      .order(created_at: :desc)
  end

  def index
  end

  def show
    @task = Task.find(params[:id])
  end

  def pass_task
    @task = Task.find(params[:task_id])
    @tasks = Array.wrap(@task)
    @users = User.all
  end

  def pass_task2
    @task = Task.find(params[:task_id])
    @users = User.all
    if @task.update_attributes(task_params)
      flash[:success] = "task passed to " + @task.resource.full_name
      notif_pass_task(@task)
      redirect_to your_tasks_url
    else
      flash[:danger] = @task.errors.full_message
      redirect_to tasks_pass_task_url(@task)
    end
  end

  def pass_all_tasks
    @users = User.all
  end

  def pass_all_tasks2
    @users = User.all
    @resource = User.find(params[:pass_all_tasks][:resource_id])
    Task.where(resource_id: current_user.id, status: { name: !'Completed'}).update_all(
      resource_id: @resource.id
    )
    notif_pass_all_tasks
  end

  private

  def task_params
    params.require(:task).permit(
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

  def notif_change_status_scheduled(task)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.resource_id,
      task_id: task.id,
      notification_type: 'notif_change_status_scheduled'
    )
  end
  def notif_change_status_with_issues(task)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.resource_id,
      task_id: task.id,
      notification_type: 'notif_change_status_with_issues'
    )
  end
  def notif_change_status_completed(task)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.resource_id,
      task_id: task.id,
      notification_type: 'notif_change_status_completed'
    )
  end
  def notif_new_task(task)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.resource_id,
      task_id: task.id,
      notification_type: 'notif_new_task'
    )
  end
  def notif_edit_task(task)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.resource_id,
      task_id: task.id,
      notification_type: 'notif_edit_task'
    )
  end
  def notif_resource_notes(task)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.user_id,
      task_id: task.id,
      notification_type: 'notif_resource_notes'
    )
  end
  def notif_pass_task(task)
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.resource_id,
      task_id: task.id,
      notification_type: 'notif_pass_task'
    )
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.user_id,
      third_id: task.resource_id,
      task_id: task.id,
      notification_type: 'notif_pass_task_owner'
    )
  end
  def notif_pass_all_tasks
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.resource_id,
      notification_type: 'notif_pass_all_tasks'
    )
    Notification.create(
      sender_id: current_user.id,
      recipient_id: task.user_id,
      third_id: task.resource_id,
      notification_type: 'notif_pass_all_tasks_owner'
    )
  end
end
