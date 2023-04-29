class Event < ApplicationRecord
  validates :end_date, presence: true
  validates :name, presence: true
  validates :start_date, presence: true

  scope :active, -> { where(active: true) }

  has_many :event_locations, dependent: :destroy
  has_many :locations, through: :event_locations

  has_many :event_organizations, dependent: :destroy
  has_many :organizations, through: :event_organizations

  ################################################################
  # Supporting start and end times as virtual attributes
  # but storing a single DateTime in the database
  ################################################################
  attr_writer :end_time, :start_time

  def end_time
    time = end_date&.strftime("%I:%M %p")
    time == "12:00 AM" ? nil : time
  end

  def start_time
    time = start_date&.strftime("%I:%M %p")
    time == "12:00 AM" ? nil : time
  end
end
