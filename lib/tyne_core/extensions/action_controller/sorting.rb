module TyneCore
  module Extensions
    # ActionController extensions
    module ActionController
      # Adds sorting functionality to action controller
      module Sorting
        extend ActiveSupport::Concern

        private
        def apply_sorting(reflection)
          return reflection.order("created_at ASC") unless params[:sorting]

          column = get_sort_column(reflection)
          order = get_sort_order

          if sort_scope(reflection)
            reflection = reflection.send(sort_scope(reflection), order)
          else
            reflection = reflection.order("#{column} #{order}")
          end
          reflection
        end

        def get_sort_column(reflection)
          if reflection.klass.column_names.include?(params[:sorting][:field])
            params[:sorting][:field]
          else
            "id"
          end
        end

        def get_sort_order
          case params[:sorting][:order]
          when "asc"
            "ASC"
          when "desc"
            "DESC"
          else
            "ASC"
          end
        end

        def sort_scope(reflection)
          sort_method = :"sort_by_#{params[:sorting][:field]}"
          sort_method if reflection.respond_to? sort_method
        end
      end
    end
  end
end
