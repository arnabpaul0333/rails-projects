require 'spec_helper'
describe Micropost do

  let!(:micropost) { create(:micropost) }

  it { should belong_to (:user) }
  
  it { should validate_presence_of (:user_id) }
  it { should validate_presence_of (:content) } 
  it { should ensure_length_of(:content).is_at_most(140) }

  context "default scope" do
    let!(:newer_micropost) { create(:micropost, created_at: 1.hour.ago) }

     it "should arrange in the right order" do
     Micropost.all == [newer_micropost, micropost]
    end
  end
  
  describe ".from users followed by other users" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:micropost) { create_list(:micropost , 7,user: other_user) }
    it "should have the microposts of followers" do
    user.follow!(other_user)
    Micropost.from_users_followed_by(user).should == other_user.microposts
    end
  end
end
