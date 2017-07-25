require 'rails_helper'

RSpec.describe "Api::Users", type: :request do

  describe "POST /users" do

    describe "on success" do

      before(:each) do
        params = {
          user: {
            name: 'user',
            email: 'user@email.com',
            password: 'password'
          }
        }

        post "/api/users",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

        @response = response
      end

      it "creates a user from the params" do
        expect(User.all.count).to eq(1)
      end

      it "returns the new user and a JWT token" do
        body = JSON.parse(@response.body)

        expect(@response.status).to eq(200)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['name']).to eq('user')
        expect(body['user']['email']).to eq('user@email.com')
        expect(body['user']['password_digest']).to eq(nil)
        expect(body['token']).not_to eq(nil)
      end
    end

    describe "on error" do

      it "requires a name, valid email, and valid password" do
        params = {
          user: {
            name: '',
            email: '',
            password: ''
          }
        }

        post "/api/users",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

        body = JSON.parse(response.body)

        expect(response.status).to eq(500)
        expect(body["errors"]).to eq({
          "name"=>["can't be blank"],
          "password"=>["can't be blank"],
          "email"=>["can't be blank", "is invalid"]
        })
      end
    end
  end
end
