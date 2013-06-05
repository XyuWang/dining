require 'spec_helper'

describe StoresController do

  describe "#index" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "#show" do
    let!(:store) {create :store}

    it "returns http success" do
      get :show, id: store.id
      response.should be_success
    end
  end
end
