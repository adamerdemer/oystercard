require "oystercard"

describe Oystercard do
  minimum_fare = Oystercard::MINIMUM_FARE

  subject(:oystercard) {described_class.new}

  let(:entry_station){ double :station}
  let(:exit_station){ double :station}

  it "has a balanace of zero" do
    expect(oystercard.balance).to eq(0)
  end

  it 'is initially not in a journey' do
    expect(oystercard.in_journey?).to be false
  end

  describe "#touch_in" do

    it "raises an error when minimum fare not reached" do
      expect{ oystercard.touch_in(entry_station) }.to raise_error "insufficent balance"
    end

    it "remembers entry station" do
      oystercard.top_up minimum_fare
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station

    end
  end

  describe "#touch_out" do
    it "can touch out" do
      oystercard.top_up minimum_fare
      oystercard.touch_in(entry_station)
      expect(oystercard.touch_out(exit_station)).to be exit_station
    end

    it "charges the card on touch_out" do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-minimum_fare)
    end

    it "remembers the exit station" do
      oystercard.top_up(minimum_fare)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_station).to eq exit_station
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
