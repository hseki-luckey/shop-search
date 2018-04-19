json.array!(@posts) do |post|
  json.extract! post, :id, :shop, :area, :genre, :rate_u, :rate_l, :url
  json.url post_url(post, format: :json)
end
