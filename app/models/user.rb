class User < ApplicationRecord
  # Associations
  has_and_belongs_to_many :projects
  has_many :assigned_revisions, class_name: "Revision", foreign_key: "animator_id"

  # Devise Modules
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Enums for roles
  enum role: { admin: 0, lead_animator: 1, animator: 2 }

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :role, presence: true

  # Callbacks
  before_validation :assign_default_role, on: :create

  private

  # Assigns a default role if none is provided
  def assign_default_role
    self.role ||= :animator # Default role is animator
  end
end