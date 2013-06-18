require "spec_helper"

describe SMS do
  describe "#balance" do
    context "response successful" do
      before do
        @response = double(:response)
        @response.stub(:body) {"100||999"}
        Net::HTTP.stub(:get_response) { @response}
      end

      it "should got the balance" do
        SMS.new.balance.should include "999"
      end
    end

    context "response failed" do
      before do
        @response = double(:response)
        @response.stub(:body) {"200||999"}
        Net::HTTP.stub(:get_response) { @response}
      end

      it "should got the balance" do
        SMS.new.balance.should_not include "999"
      end
    end
  end

  describe "#send" do
    context "response successful" do
      before do
        @response = double(:response)
        @response.stub(:body) {"100"}
        Net::HTTP.stub(:get_response) { @response}
      end

      it "should got the response" do
        SMS.new.send("a", "b").should == "100"
      end
    end

    context "response failed" do
      before do
        @response = double(:response)
        @response.stub(:body) {"200"}
        Net::HTTP.stub(:get_response) { @response}
      end

      it "should got the response" do
        SMS.new.send("1", "2").should == "200"
      end
    end
  end
end
