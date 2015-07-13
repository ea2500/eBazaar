json.array!(@orders) do |order|
  json.extract! order, :id, :name, :email, :pay_type, :address
  json.url order_url(order, format: :json)
end
