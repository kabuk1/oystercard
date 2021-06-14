class Journey
  attr_reader :entry_station, :journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  def start(station)
    @penalty = true if @entry_station
    @entry_station = station  
  end

  def end(station)
    @penalty = @entry_station ? false : true
    @journey = { entry_station: @entry_station, exit_station: station }
    @entry_station = nil
  end

  def fare
    return PENALTY_FARE if @penalty
    return MIN_FARE if @journey
    0
  end

  def delete_entry_station
    @entry_station = nil
  end
end