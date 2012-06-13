require "spec_helper"

describe Notifier do
  describe "new_user_creation" do
    let(:mail) { Notifier.new_user_creation }

    it "renders the headers" do
      mail.subject.should eq("New user creation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
