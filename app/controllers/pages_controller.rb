class PagesController < ApplicationController
  helper_method :sort_direction, :sort2

  def landing_page
  end

  def welcome_page
    @clients = Client.all

    @sort_values = sort_values

    @jobs = Job.where("jobs.status_id = ?", status_id(status)).order("#{sort2}")
    @jobs = Job.all.order("#{sort2}") if status.nil? || status == "All"
    @jobs = @jobs.by_required_date if sort2.nil?
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(5)
  end

  def your_jobs
    @start_date = params[:start_date] || Time.zone.today - 1.year
    @end_date = params[:end_date] || Time.zone.today + 1.year
    @jobs = Job.where(resource_id: current_user.id).where("required_date between ? and ?", @start_date, @end_date).by_required_date
    # kit = PDFKit.new(html, :page_size => 'Letter')
    # kit.stylesheets << '/app/stylesheets/application.scss'
  end

  def your_requests
    @jobs = Job.where(user_id: current_user.id).by_required_date
  end

  def print_tasks
    @start_date = params[:start_date] || Time.zone.today - 1.year
    @end_date = params[:end_date] || Time.zone.today + 1.year
    @jobs = Job.where(resource_id: current_user.id).where("required_date between ? and ?", @start_date, @end_date).by_required_date
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort(value)
    if params[:sort] == 'name'
      @inputs = Input.all.order("form_name #{sort_direction}")
    elsif params[:sort] == 'created_at'
      @inputs = Input.all.order("created_at #{sort_direction}")
    else
      @inputs = Input.all
    end
  end

  def sort2
      if params[:sort].present? && params[:sort][:sort].present?
        params[:sort][:sort]
      end
  end


  def sort_values
    v1 = SortHash.new(key: 'Required Date Latest', value: 'required_date DESC')
    v2 = SortHash.new(key: 'Request Date Latest', value: 'created_at DESC')
    v3 = SortHash.new(key: 'Required Date Oldest', value: 'required_date ASC')
    v4 = SortHash.new(key: 'Request Date Oldest', value: 'created_at ASC')
    sort_value_array = [v1,v2,v3,v4]
    return sort_value_array
  end

  def status_id(status_name)
    Status.find_by(name: status_name).nil? ? nil : Status.find_by(name: status_name).id
  end

  def status
    if params[:status].present?
      return params[:status]
    end
  end




end
