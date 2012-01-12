require 'spec_helper'

describe VlController do

  it "returns valid page" do
     get :bc
     response.status.should == 200
   end

end
