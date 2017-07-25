json.user do
  json.(@user, :id, :name, :email)
end
json.token(Auth.create_token(@user.id))
