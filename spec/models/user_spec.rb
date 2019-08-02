require "rails_helper"
require "./app/models/user.rb"
describe User do
  before(:each) do
    @user = User.new(name: "user", email: "vijay@railstutorial.org", password: "123456", password_confirmation: "123456")
  end

  it "user should be valid" do
    expect(@user.valid?).to be true
  end

  it "user should be invalid" do
    @user.password_confirmation = "456667"
    expect(@user.valid?).to be false
  end

  it "name should be present" do
    expect(@user.name).not_to eq("  ")
  end

  it "email should be present" do
    expect(@user.email).not_to eq("  ")
  end

  it "name should not to be long" do
    #@user.name = "a" * 51
    b = @user.name.length
    expect(b).to be_between(1,51).inclusive
  end

  it "email should not to be long" do
    #@user.email = "a" * 244 +"@example.com"
    b = @user.email.length
    expect(b).to be_between(1,256).inclusive
  end

  it "email validation should be accept valid address" do
    @user.email = "Vijay@gmail.com"
    expect(@user.valid?).to be true
  end

  it "email validation should be reject for invalid address" do
    @user.email = "Foo@24gmail.com123"
    expect(@user.valid?).to be false
  end

  it "email address should be unique" do
    ur = @user.dup
    ur.email = @user.email.upcase
    @user.save
    expect(ur.valid?).to be false
  end

  it "email address should be save as downcase" do
    ur = "Foo@GMAIL.com"
    @user.email = ur
    @user.save
    expect(ur.downcase).to eql(@user.email) 
  end

  it "password should be match" do
    @user.password_confirmation = "856745"
    @user.save
    expect(@user.valid?).to be false
  end

  it "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user.valid?).to be false
  end

  it "password should not be too short" do
    @user.password = @user.password_confirmation = "1" *5
    expect(@user.valid?).to be false
  end

  it "passwoed should be authenticate" do
    @user.save
    ur = User.find_by(email: @user.email)
    expect(ur.authenticate(@user.password)).to eq(@user.authenticate(@user.password))
  end
end  