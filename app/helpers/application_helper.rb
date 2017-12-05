module ApplicationHelper

  def better_date(date)
    date.strftime("%B %d, %Y") if date.present?
  end

  def better_date2(date)
    date.strftime("%B %d, %Y - %A") if date.present?
  end

  def default_date(date)
    date.strftime("%Y-%m-%d") if date.present?
  end

  def better_time(time)
    time.strftime("%I:%M%p")
  end

  def better_datetime(datetime)
    datetime.strftime('%b %d, %Y - %I:%M%p')
  end

  def nan_to_0(number)
    number.nan? ? 0 : number
  end

  def this_month
    Time.zone.today.strftime("%B")
  end

  def zero_to_non(number)
    number == 0 ? "" : number
  end

  def bignum(number)
    number_with_precision(number, :precision => 2, :delimiter => ',')
  end

  def status(status)
    case status
    when "Open"
      "primary"
    when "Scheduled"
      "warning"
    when "Completed"
      "success"
    when "With Issues"
      "danger"
    end
  end


end
