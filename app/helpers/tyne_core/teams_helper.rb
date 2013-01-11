module TyneCore
  # Provides view helpers for the team area in the core engine.
  module TeamsHelper
    # Returns the list of potentional team members.
    # You cannot add user which are already part of the team.
    def available_members(team)
      scope = TyneAuth::User.scoped
      team.members.all.each do |member|
        scope = scope.where(TyneAuth::User.arel_table[:id].not_eq(member.user.id))
      end
      scope.all
    end
  end
end
