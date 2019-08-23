require 'rails_helper'

RSpec.describe Micropost do
  let(:user) { User.new(name: "user", email: "vijay@railstutorial.org", password: "123456", password_confirmation: "123456") }
  
  let(:micropost) { Micropost.new(content: "Lorem ipsum", user_id: user.id) }
  
  before(:each) do
    user.save
    micropost.save
  end

  # it "user id should be present" do
  #   micropost.user_id = nil
  #   expect(micropost.user_id).not_to be_valid?
  # end

  # it "content should be present" do
  #   expect(micropost.content).not_to be nil
  # end

  # it "content should not to be long" do
  #   micropost.content = "hello" * 28
  #   expect(micropost.content.length).to be_valid?
  # end
end
