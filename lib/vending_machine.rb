# -*- coding: utf-8 -*-

class VendingMachine
  attr_reader :change

  def initialize
    @moneys = []
    @change = []
    @products = [Juice.new("コーラ", 120)]*5
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

  def store(product)
    @products << product
  end

  def products
    @products
  end

  def stock
    keys = @products.map {|p| p.name}.uniq
    keys.map {|key| [key, @products.count {|p| p.name == key} ]}
  end

  def purchasable(name)
    product = @products.find{|product| product.name == name}
    if product.nil?
      return false
    end
    return product.price <= total
  end

end
