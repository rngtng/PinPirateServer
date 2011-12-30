require 'spec_helper'

describe GamesController do

  render_views

  it "returns valid page" do
    get :index
    response.status.should == 200
  end

  it "assigns game" do
    get :index
    assigns(:game).should_not be_nil
  end

  it "assigns games" do
    get :index
    assigns(:games).should_not be_nil
  end


end
