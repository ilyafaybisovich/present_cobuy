require "rails_helper"

RSpec.describe ContributorMailer, type: :mailer do

  describe "invited" do

    let(:item) { double(:item, title: "A Birthday Gift") }
    let(:gift) { double(:gift, item: item, title: "Dads Birthday", organiser: "Rob", description: "") }
    let(:contributor) { double(:contributor, email: "rob@rbgeomatics.co.uk") }
    let(:mail) { described_class.invited(gift, contributor) }

    it "renders the headers" do

      expect(mail.subject).to match("You can make this happen!")
      expect(mail.to).to eq(["rob@rbgeomatics.co.uk"])
      expect(mail.from).to eq(["makers_academy_test@rbgeomatics.co.uk"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello there")
    end
  end

end
