def clear_stripe_customer_data
  if Rails.env == 'test' || Rails.env == 'development'
    Stripe::Customer.list(limit: 5000).each{|c| Stripe::Customer.delete(c.id)}
  end
end


def clear_product_data
  if Rails.env == 'test' || Rails.env == 'development'
    Stripe::Price.list({limit: 5000}).each{|p| Stripe::Price.update(p.id, active: false)}
    Stripe::Product.list({limit: 5000}).each{|p| Stripe::Product.delete(p.id)}
  end
end
