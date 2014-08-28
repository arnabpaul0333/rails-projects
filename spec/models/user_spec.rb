require 'spec_helper'
describe User do
  let!(:user)  {FactoryGirl. create(:user) }

  it { should have_many (:microposts)}
  it { should have_many(:followed_users).through(:relationships)}
  it { should have_many(:followers).through(:reverse_relationships)}

  it{ should validate_presence_of (:name)}
  it{ should validate_presence_of(:email)}
  it{ should ensure_length_of(:name).is_at_most(50)}
  it{ should_not allow_value("user@foo,com", "user_at_foo.org example.user@foo.").for(:email)}
  it{ should ensure_length_of(:password).is_at_least(6)}
  it{ should validate_uniqueness_of(:email)}
  it{ should validate_confirmation_of (:password)}
  it{ should have_secure_password}

  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
    it "should be saved as all lower-case" do
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
  end

   describe "with admin attribute set to 'true'" do
    before do
      user.save!
      user.toggle!(:admin)
    end
  end

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      user.save
      user.follow!(other_user)
    end
  end
end



