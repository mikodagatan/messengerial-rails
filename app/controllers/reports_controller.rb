class ReportsController < ApplicationController

  helper_method :by_city_town, :by_city_town_complete, :by_city_town_with_issues, :by_city_town_open, :by_city_town_scheduled

  def location_report
    @locations = Address.pluck(:city_town).uniq
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
