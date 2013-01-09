module TyneCore
  # Provides global view helpers for the core engine.
  module ApplicationHelper
    def available_members(team)
      scope = TyneAuth::User.scoped
      team.members.all.each do |member|
        scope = scope.where(TyneAuth::User.arel_table[:id].not_eq(member.user.id))
      end
      scope.all
    end
  end
end
