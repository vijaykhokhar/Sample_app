require "rails_helper"

describe " user signup" do

   before(:each) do
    @user = User.new(name: "user", email: "vijay@railstutorial.org", password: "123456", password_confirmation: "123456")
  end

  describe "invalid user" do
    it "invalid user should not be accepted" do
      if !@user.valid?
        !@user.save 
        render_template 'user/new'
      end
    end
  end

  describe "valid user" do
    it "valid user should be accepted" do
      if @user.valid?
        @user.save
        render_template 'user/show'
        #expect(flash[:notice]).to eq "Welcome to the Sample App"
      end
    end

    it "login with valid information" do
      get '/login'
      post '/login', params: { session: { email: @user.email, password: 'password' } }
    #  redirect_to @user
     # follow_redirect!
     # render_template 'users/show'
      #render_select "a[href=?]", '/login', count: 0
      #render_select "a[href=?", '/logout'
      #render_select "a[href=?", '/user(@user)'
    end

    #describe "after the user saving" do 
      #before { @user.save }
      #let(:user) { User.find_by(email: "user@gmail.com") }
      #it { should get '/signout'}
    #end
  end

  describe "login" do
    it "login with invalid information" do
      get '/login'
      render_template 'sessions/new'
      post '/login', params: { session: { email: "", password: "" } }
      render_template 'sessions/new'
      !flash.empty?
      get '/'
      flash.empty?
    end
  end
end