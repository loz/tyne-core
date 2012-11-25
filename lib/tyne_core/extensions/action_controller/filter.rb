module TyneCore
  module Extensions
    # ActionController extensions
    module ActionController
      # Adds filter functionality to action controller
      module Filter
        extend ActiveSupport::Concern

        private
        def apply_filter(reflection)
          return reflection unless params[:filter]

          persist_filter_information!

          params[:filter].each do |filter|
            reflection = reflection.where(Hash[*filter])
          end

          reflection
        end

        def persist_filter_information!
          session[:filter] = params[:filter]
        end
      end
    end
  end
end
