require "oystercard"

describe Oystercard do
  minimum_fare = Oystercard::MINIMUM_FARE

  subject(:oystercard) {described_class.new}

  let(:station){ double :station}

  it 'is initially not in a journey' do
    expect(oystercard.in_journey?).to be false
  end

  describe "#touch_in" do

    it "raises an error when minimum fare not reached" do
      expect{ oystercard.touch_in(@station) }.to raise_error "insufficent balance"
    end

    it "remembers entry station" do
      oystercard.top_up minimum_fare
      oystercard.touch_in(@station)
      expect(oystercard.entry_station).to eq @station

    end
  end

  describe "#journeys" do

    it "checks that the card has an empty list of journeys by default" do
      expect(oystercard.journeys).to eq []
    end

    it "checks that touching in and out creates one journey" do
      oystercard.top_up 20
      oystercard.touch_in("station_1")
      oystercard.touch_out("station_2")
      expect(oystercard.journeys).to eq [{"entry_station"=>"station_1", "exit_station"=>"station_2"}]
    end
  end

  describe "#touch_out" do

    it "charges the card on touch_out" do
      expect{oystercard.touch_out(@station)}.to change{oystercard.balance}.by(-minimum_fare)
    end
  end

  describe "#balance" do

    it "has a balanace of zero" do
      expect(oystercard.balance).to eq(0)
    end

    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up maximum_balance
      expect{ oystercard.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end

    it "can top up the balance" do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end
  end


end
