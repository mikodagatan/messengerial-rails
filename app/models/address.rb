class Address < ApplicationRecord
  belongs_to :target_client
  has_many :jobs

  def complete
    "#{first_line}, #{second_line} #{city_town}, #{province}, #{country} #{zipcode}"
  end

end
