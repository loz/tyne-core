module TyneCore
  class AdminController < TyneCore::ApplicationController
    def is_admin_area?
      true
    end
  end
end
