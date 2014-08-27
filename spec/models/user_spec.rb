require 'spec_helper'
describe User do
  let(:user) { FactoryGirl.build(:user)}

  it { should respond_to(:name , :email, :password_digest, :password, :password_confirmation, :authenticate) }
  it { should have_many (:microposts)}
  it { should have_many(:followed_users).through(:relationships)}
  it { should have_many(:followers).through(:reverse_relationships)}

  it{ should validate_presence_of (:name)}
  it{ should validate_presence_of(:email)}
  it{ should ensure_length_of(:name).is_at_most(50)}
  it{ should_not allow_value("user@foo,com", "user_at_foo.org example.user@foo.",).for(:email)}
  it{ should ensure_length_of(:password).is_at_least(6)}
  it{ should validate_uniqueness_of(:email)}
  it{ should validate_confirmation_of (:password)}
  it{ should have_secure_password}
    
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
    it "should be saved as all lower-case" do
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
  end
end



