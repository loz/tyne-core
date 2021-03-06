#Formatting context to generate html output
class TyneCore::FormatContexts::Html
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper
  include TyneCore::AvatarHelper

  delegate :controller, :image_tag, :to => :view_context

  private
  def view_context
    @view_context ||= ActionView::Base.new
  end
end
