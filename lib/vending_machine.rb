class VendingMachine
  attr_reader :change

  def initialize
    @moneys = []
    @change = []
  end
  def put_in(money)
    if [10, 50, 100, 500, 1000].include?(money)
      @moneys << money
    else
      @change << money
    end
  end

  def total
    @moneys.inject(0, &:+)
  end

  def back
    @change += @moneys
    @moneys  = []
  end
end
