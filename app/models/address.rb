class Address < ApplicationRecord
  belongs_to :target_client
  has_many :tasks

  validates :first_line, :second_line, :city_town, :province, :country, :target_client_id, presence: true
  validates :zipcode, presence: true, numericality: true
  
  def complete
    "#{first_line}, #{second_line} #{city_town}, #{province}, #{country} #{zipcode}"
  end

end
