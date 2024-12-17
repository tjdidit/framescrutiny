class DailyPolicy < ApplicationPolicy
  def create?
    user.lead_animator? || user.admin?
  end

  def update?
    user.lead_animator? || user.admin?
  end
end
