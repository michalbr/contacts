class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :set_labels
  after_action :render_flash_stream, if: -> { request.format.turbo_stream? && flash[:notice].present? }

  private

  def set_labels
    @labels = Rails.cache.fetch("labels") { Label.order(:name) }
  end

  def render_flash_stream
    response.body = response.body + render_to_string(partial: "shared/toast")
  end
end
