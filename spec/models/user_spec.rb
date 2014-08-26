require 'spec_helper'

describe User do

  let(:user)  {User.create(name: "Example User", email: "user@example.com", password: "arnabpaul", password_confirmation: "arnabpaul") }


  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}


  describe "when name is not present" do
    it "should have a name" do
    user.name = " "
    expect(user.valid?).to be_false
    end
  end

  describe "when email is not present" do
    it "should have a email" do
    user.email = " "
    expect(user.valid?).to be_false
    end
  end

  describe "when name is too long" do
    it "should have a proper name" do 
    user.name = "a"*51
    expect(user.valid?).to be_false
    end
  end

  describe "should have a valid email" do
    context "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user.valid?).to be_false
        end
      end
    end
    context "when email format is valid" do
      it "should be valid email" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          user.email = valid_address
          expect(user.valid?).to be_true
        end
      end
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
    it "should be saved as all lower-case" do
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "email address is already been taken" do
    it "should be unique" do
      user_with_same_mail = user.dup
      user_with_same_mail.save
      expect(user_with_same_mail.valid?).to be_false
    end
  end

  describe " password is too short" do
    it "should have a proper password" do
      user.password = "a"*5
      expect(user.valid?).to be_false
    end
  end

  describe "passwords does not match" do
    it "should not be valid" do
      user.password_confirmation = "missed"
      expect(user.valid?).to be_false
    end
  end

  describe "return value of authenticated method" do
    let(:found_user) {User.find_by(email: user.email)}
    describe "with valid password" do
      it {user.should eq found_user.authenticate(user.password)}
    end
    describe "with invalid password" do
      let(:user_for_invalid_password){found_user.authenticate("invalid")}
      it { user.should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
 end
