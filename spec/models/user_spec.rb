require 'spec_helper'
describe User do
  let!(:user)  { create(:user) }

  it { should have_many (:microposts) }
  it { should have_many(:followed_users).through(:relationships) }
  it { should have_many(:followers).through(:reverse_relationships) }

  it { should validate_presence_of (:name) }
  it { should validate_presence_of(:email) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should_not allow_value("user@foo,com", "user_at_foo.org example.user@foo.").for(:email) }
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of (:password) }
  it { should have_secure_password }

  context "callbacks" do
    context "email address with mixed case" do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
      let!(:user2) { build(:user, name: "Foo", email: "foo@example.com" , password: "arnabpaul", password_confirmation: "arnabpaul") }
      before { user2.save}
        it{ user2.email.should eq mixed_case_email.downcase }
      end
    context "remember_token" do
      let!(:user2) { build(:user, remember_token: nil) }
      before { user2.save }
      it "should return not be nil" do
      user2.remember_token.should_not be_nil
      end
    end
  end

  describe "#following" do
    let!(:other_user) { create(:user) }
    it "should match relationship" do
      user.follow!(other_user)
      user.following?(other_user).should eq(Relationship.last)
    end
    it "should return nil" do
      user.following?(other_user).should be_nil
    end
  end

  context "following and unfollowing users" do
      let!(:count){ Relationship.count }
      let!(:other_user) { create(:user) }
    describe "#follow" do
      before do
        user.follow!(other_user)
      end
      it "should count the no. of followers " do
        Relationship.count.should eq (count+1)
      end
    end
    describe "#unfollow" do
      before do
        user.follow!(other_user)
        user.unfollow!(other_user)
      end
      it "should unfollow the user" do
        Relationship.count.should eq (count)
      end
    end
  end
end



