require 'rails_helper'

RSpec.describe "Api::Users", type: :request do

  before(:each) do
    @user = User.create(
      name: 'user',
      email: 'user@jetlog.com',
      password: 'password'
    )
  end

  describe "POST /auth" do

    describe "on success" do

      before(:each) do
        params = {
          user: {
            name: 'user',
            email: 'user@jetlog.com',
            password: 'password'
          }
        }

        post "/api/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

        @response = response
      end

      it "returns the existing user (from params) and a JWT token" do
        body = JSON.parse(@response.body)

        expect(@response.status).to eq(200)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['email']).to eq('user@jetlog.com')
        expect(body['user']['password_digest']).to eq(nil)
        expect(body['token']).not_to eq(nil)
      end
    end

    describe "on error" do

      it "unable to find user with email" do
        params = {
          user: {
            email: 'user@codeschool.com',
            password: 'password'
          }
        }

        post "/api/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

        body = JSON.parse(response.body)

        expect(response.status).to eq(500)
        expect(body["errors"]).to eq({
          "email"=>["Unable to find a user with the provided email address"]
        })
      end

      it "password does not match the provided email" do
        params = {
          user: {
            name: 'user',
            email: 'user@jetlog.com',
            password: 'wrongpass'
          }
        }

        post "/api/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

        body = JSON.parse(response.body)

        expect(response.status).to eq(500)
        expect(body["errors"]).to eq({
          "password"=>["Password does not match the provided email"]
        })
      end
    end
  end

#   describe "POST /auth/refresh" do
#
#      describe "on success" do
#
#       it "returns the existing user (from the headers JWT) and a new JWT token" do
#         token = Auth.create_token(@user.id)
#
#         post "/api/auth/refresh",
#           headers: {
#             'Content-Type': 'application/json',
#             'Authorization': "Bearer: #{token}"
#           }
#
#         body = JSON.parse(response.body)
#
#         expect(response.status).to eq(200)
#         expect(body['user']['id']).not_to eq(nil)
#         expect(body['user']['email']).to eq('user@jetlog.com')
#         expect(body['user']['password_digest']).to eq(nil)
#         expect(body['token']).not_to eq(nil)
#       end
#     end
#
#     describe "on error" do
#
#       it "unable to find user with email" do
#         token = 'abc.123.def.456'
#
#         post "/api/auth/refresh",
#           headers: {
#             'Content-Type': 'application/json',
#             'Authorization': "Bearer: #{token}"
#           }
#
#         body = JSON.parse(response.body)
#
#         expect(response.status).to eq(403)
#         expect(body["errors"]).to eq([{ "message" => "Token is invalid!" }])
#       end
#     end
#   end
end
