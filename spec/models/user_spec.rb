require "rails_helper"

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
    b = @user.name.length
    expect(b).to be_between(1,51).inclusive
  end

  it "email should not to be long" do
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

  describe "remember token" do
    before { @user.save }
    it(:remember_token) { should_not be_blank}
  end

  it "should forget the user" do 
    @user.forget
    expect(@user.remember_digest).to be nil
  end

  it "should return a valid digest bcrypt password" do
    expect { User.digest("vijay") }.not_to raise_error
  end

  it "should generate token" do
    expect { User.new_token }.not_to raise_error
  end

  it "user should be remember" do
    @user.remember
    expect(@user.remember_digest).not_to be nil
  end

  it "user should activated" do
    @user.save
    @user.activate
    expect(@user.activated).to be true
  end

  it "user should not activated yet" do
    @user.save
    expect(@user.activated).to be false 
  end

  it "should send an activation email" do
    @user.save
    expect { @user.send_activation_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it "should create reset the digest" do
    @user.save
    expect(@user.create_reset_digest).not_to be nil
  end

  it "password reset should be expired" do
    @user.save
    @user.reset_sent_at = Time.zone.now - 3.hour
    expect(@user.password_reset_expired?).to be true
  end

  it "password reset should not expired" do 
    @user.reset_sent_at = Time.zone.now - 1.hour
    expect(@user.password_reset_expired?).to be false
  end

  describe "follow and unfollow" do

    let(:other_user) { User.new(name: "user", email: "vijay@railstutorial.org", password: "123456", password_confirmation: "123456") }

    context "follow" do
      it "should follow the user" do
      @user.follow(other_user)
      expect(@user.following_ids).to include(other_user.id)
      end

       it "should following other user" do
        @user.follow(other_user)
        expect(@user.following?(other_user)).to be true
      end
    end

    context "unfollow" do
      it "should unfollow the other user" do
        @user.follow(other_user)
        @user.unfollow(other_user)
        expect(@user.following_ids).not_to include(other_user.id)
      end

      it "should not following the other user" do
        @user.follow(other_user)
        @user.unfollow(other_user)
        expect(@user.following?(other_user)).to be false
      end
    end
  end
end