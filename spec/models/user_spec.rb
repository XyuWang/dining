require 'spec_helper'

describe User do
  it{should have_one :store}
  it{should have_one :cart}
  it{should have_many :line_items}
  it{should have_many :orders}
  it{should have_many :comments}

  describe "scope storers" do
    let!(:user_1) {create :user}
    let!(:user_2) {create :user}

    context "0 storer" do
      it "should got []" do
        User.storers.should == []
      end
    end

    context "1 storer" do
      before do
        user_1.roles << :storer
        user_1.save
      end

      it "should got 1 user" do
        User.storers.should == [user_1]
      end
    end

    context "2 storer" do
      before do
        user_1.roles << :storer
        user_1.save

        user_2.roles << :storer
        user_2.save
      end

      it "should got 2 user" do
        User.storers.should == [user_1, user_2]
      end
    end
  end
end
