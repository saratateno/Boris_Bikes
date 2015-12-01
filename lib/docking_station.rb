require_relative 'bike'

class DockingStation
  attr_reader :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    fail 'No bikes available' if empty?
    fail 'No working bikes' if !any_working_bikes?
    bikes.pop
  end

  def dock(bike)
    fail 'Docking station full' if full?
    bikes << bike
  end

  def any_working_bikes?
    @bikes.any? { |bike| bike.working }
  end


  private

  attr_reader :bikes


  def full?
    bikes.size >= capacity
  end

  def empty?
    bikes.empty?
  end

end
