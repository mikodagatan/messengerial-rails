class ReportsController < ApplicationController

  helper_method :by_city_town, :by_city_town_complete, :by_city_town_with_issues, :by_city_town_open, :by_city_town_scheduled

  def location_report
    @start_date = params[:start_date] || Time.zone.today - 10.years
    @start_date = Date.new(params[:months]["start_date(1i)"].to_i,params[:months]["start_date(2i)"].to_i, params[:months]["start_date(3i)"].to_i) if params[:months].present?
    @end_date = params[:end_date] || Time.zone.today + 10.years
    @end_date = Date.new(params[:months]["end_date(1i)"].to_i,params[:months]["end_date(2i)"].to_i,params[:months]["end_date(3i)"].to_i) if params[:months].present?
    @locations = Address.where("addresses.created_at between ? and ?", @start_date, @end_date).pluck(:city_town).uniq
  end

  def by_city_town(city_town)
    Job.joins(:address).where(addresses: {city_town: city_town}).count
  end

  def by_city_town_complete(city_town)
    Job.joins(:address, :status).where(addresses: {city_town: city_town}, statuses: {name: 'Complete'}).count
  end

  def by_city_town_scheduled(city_town)
    Job.joins(:address, :status).where(addresses: {city_town: city_town}, statuses: {name: 'Scheduled'}).count
  end

  def by_city_town_with_issues(city_town)
    Job.joins(:address, :status).where(addresses: {city_town: city_town}, statuses: {name: 'With Issues'}).count
  end

  def by_city_town_open(city_town)
    Job.joins(:address, :status).where(addresses: {city_town: city_town}, statuses: {name: 'Open'}).count
  end
end
