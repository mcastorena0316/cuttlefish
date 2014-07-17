class Filters::Dkim < Filters::Delivery
  def data
    if active?
      Dkim.sign(delivery.data, selector: 'cuttlefish', private_key: delivery.app.dkim_key, domain: delivery.app.from_domain)
    else
      delivery.data
    end
  end

  def active?
    delivery.app.dkim_enabled && delivery.from_domain == delivery.app.from_domain
  end
end