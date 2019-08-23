require "rails_helper"

describe StaticPagesController do
  subject { page }
  it "should get home page" do
    get '/'
    expect(response.status).to eql 200
  end

  it "should get help page" do
    get '/help'
    expect(response.status).to eql 200
  end

  it "should get about page" do
    get '/about'
    expect(response.status).to eql 200
  end

  it "should get contact page" do
    get '/contact'
    expect(response.status).to eql 200
  end
end
