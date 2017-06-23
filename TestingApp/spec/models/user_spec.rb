require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "password_digest" do
    it "does not save passwords to the database" do
      User.create!(username: "bob", password: "burger1")
      user = User.find_by_username("bob")
      expect(user.password).not_to be("burger1")
    end

    it "encrypts the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "bob", password: "burger1")
    end
  end

  describe "session token" do
    it "assigns a session_token if one is not given" do
      bob1 = User.create(username: "bob", password: "burger1")
      expect(bob1.session_token).not_to be_nil
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(5) }

end
