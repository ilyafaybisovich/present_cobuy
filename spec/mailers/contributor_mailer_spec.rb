RSpec.describe ContributorMailer, type: :mailer do
  let(:item) { double(:item, title: 'A Birthday Gift') }
  let(:gift) do
    double(:gift, item: item, title: 'Dad’s Birthday',
                  organiser: 'Rob', description: '')
  end
  let(:contributor) { double(:contributor, email: 'rob@rbgeomatics.co.uk') }
  let(:mail) { described_class.invited(gift, contributor) }

  it 'renders the headers' do

    expect(mail.subject).to match 'You can make this happen!'
    expect(mail.to).to eq ['rob@rbgeomatics.co.uk']
    expect(mail.from).to eq ['gifts@ronin-giftbox.co.uk']
  end

  it 'renders the body' do
    expect(mail.body.encoded).to match 'Hello there'
  end
end
