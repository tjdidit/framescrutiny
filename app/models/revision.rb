class Revision < ApplicationRecord
  belongs_to :daily
  belongs_to :user
  belongs_to :assigned_user, class_name: 'User', optional: true

  # Regex to validate NTSC format HH:MM:SS:FF
  validates :timestamp, presence: true, format: { with: /\A\d{2}:\d{2}:\d{2}:\d{2}\z/, message: "must be in HH:MM:SS:FF format" }
  validates :comment, presence: true
end