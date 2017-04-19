require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "has a balanace of zero" do
    expect(oystercard.balance).to eq(0)
  end

  it 'decuts an amount from the balance' do
    oystercard.top_up(20)
    expect{ oystercard.deduct 3}.to change { subject.balance }.by -3
  end

  it 'is initially not in a journey' do
    expect(oystercard).not_to be_in_journey
  end
  it "can touch in" do
    oystercard.touch_in
    expect(oystercard).to be_in_journey
  end

  it "raises an error if the maximum balance is exceeded" do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    oystercard.top_up maximum_balance
    expect{ oystercard.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "can top up the balance" do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end

  end

  #it { is_expected.to respond_to(:deduct).with(1).argument }

  # it 'decuts an amount from the balance' do
  #   oystercard.top_up(20)
  #   expect{ oystercard.deduct 3}.to change { subject.balance }.by -3
  # end
  #
  # it 'is initially not in a journey' do
  #   expect(oystercard).not_to be_in_journey
  # end





end
