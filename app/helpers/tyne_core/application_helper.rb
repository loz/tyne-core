module TyneCore
  # Provides global view helpers for the core engine.
  module ApplicationHelper
    # Creates a simple form with disabled form elements
    # def disabled_form_for(object, *args, &block)
    #   options = args.extract_options!
    #   simple_form_for(object, *(args << options.merge(:builder => TyneCore::FormBuilder::DisabledFormBuilder)), &block)
    # end
    def markup_to_html(markup)
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :no_intra_emphasis => true).render(markup).html_safe
    end
  end
end
