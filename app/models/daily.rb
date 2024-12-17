class Daily < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_one_attached :video
  has_many :revisions, dependent: :destroy

  validates :video, attached: true, content_type: ['video/mp4', 'video/mov'], size: { less_than: 500.megabytes }
end
