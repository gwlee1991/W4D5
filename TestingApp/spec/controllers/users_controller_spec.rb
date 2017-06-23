require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the new users template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid parameters" do
      it "validates the presence if the user's username and password" do
        post :create, user: { username: "bob", password: "buga" }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates the password is a minimum 5 characters long" do
        post :create, user: { username: "bob", password: "burg" }
        expect(response).to render_template("new")
        expect(flash[:errors]). to be_present
      end
    end

    context "with valid parameters" do
      it "redirects user to goals index on success" do
        post :create, user: { username: "bob", password: "burger1"}
        expect(response).to redirect_to(goals_url)
      end

      it "logs in the user" do
        post :create, user: { username: "bob", password: "burger1"}
        user = User.find_by_username("bob")

        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end

end
