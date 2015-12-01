require 'docking_station'

describe DockingStation do

  describe '#initialize' do

    it 'sets capacity to argument passed' do
      station = DockingStation.new(30)
      expect(station.capacity).to eq(30)
    end

    it 'if no argument passed, set\'s capacity to default capacity' do
      expect(subject.capacity).to eq(DockingStation::DEFAULT_CAPACITY)
    end

  end

  describe '#capacity' do
    it { is_expected.to respond_to(:capacity)}
  end

  describe '#dock' do

    it 'raises an error if full' do
      subject.capacity.times {subject.dock(Bike.new)}
      expect{subject.dock(Bike.new)}.to raise_error('Docking station full')
    end

    it { is_expected.to respond_to(:dock).with(1).argument }

    it 'docks something' do
      bike = Bike.new
      expect(subject.dock(bike)).to eq [bike]
    end

  end

  describe '#release_bike' do

    it { is_expected.to respond_to :release_bike }

    it  'raises an error if there are no bikes' do
      expect{subject.release_bike}.to raise_error('No bikes available')
    end

    it 'raises an error when the only bikes available are broken' do
      2.times do
        bike = Bike.new
        bike.report_broken
        subject.dock(bike)
      end
      expect{subject.release_bike}.to raise_error('No working bikes')
    end

    it 'releases working bikes' do
      subject.dock(Bike.new)
      bike = subject.release_bike
      expect(bike).to be_working
    end

  end

end
