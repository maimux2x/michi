class ApplicationController < ActionController::Base
  include Authentication
  include Pagy::Backend

  helper_method :current_user
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_user
    @current_user ||= Current.user if Current.session
  end
end
