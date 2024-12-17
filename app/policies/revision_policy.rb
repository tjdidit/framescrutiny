class RevisionPolicy < ApplicationPolicy
  def create?
    user.lead_animator? || user.animator?
  end

  def update?
    user.lead_animator? || user.admin?
  end
end