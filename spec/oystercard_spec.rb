require "oystercard"

describe Oystercard do
  minimum_fare = Oystercard::MINIMUM_FARE

  subject(:oystercard) {described_class.new}

  it "has a balanace of zero" do
    expect(oystercard.balance).to eq(0)
  end

  it 'is initially not in a journey' do
    expect(oystercard.in_journey?).to be false
  end

  describe "#touch_in" do

    it "can touch in" do
      oystercard.top_up(1)
      expect(oystercard.touch_in).to be true
    end

    it "raises an error when minimum fare not reached" do
      expect{ oystercard.touch_in }.to raise_error "insufficent balance"
    end
  end

  describe "#touch_out" do
    it "can touch out" do
      oystercard.top_up minimum_fare
      oystercard.touch_in
      expect(oystercard.touch_out).to be false
    end

    it "charges the card on touch_out" do
      expect{oystercard.touch_out}.to change{oystercard.balance}.by(-minimum_fare)
    end
  end

  it "raises an error if the maximum balance is exceeded" do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    oystercard.top_up maximum_balance
    expect{ oystercard.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
  end

  describe "#top_up" do
    it "can top up the balance" do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end
  end

end
