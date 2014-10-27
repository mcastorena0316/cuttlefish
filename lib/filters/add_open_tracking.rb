# Insert a tracking image at the bottom of the html email
class Filters::AddOpenTracking < Filters::Tracking
  include ActionView::Helpers::AssetTagHelper
  include Rails.application.routes.url_helpers

  def process_html(input, delivery)
    if open_tracking_enabled?
      filter.set_open_tracked!
      input + image_tag(url, alt: nil)
    else
      input
    end
  end

  # The url for the tracking image
  def url
    tracking_open_url(
      host: host,
      protocol: protocol,
      delivery_id: id,
      hash: HashId.hash(id),
      format: :gif
    )
  end
end
