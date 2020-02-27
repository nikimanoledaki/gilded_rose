# frozen_string_literal: true

require_relative 'item.rb'

class GildedRose
  attr_reader :items
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      classify(item)
      reduce_sell_in(item)
    end
  end
end

def classify(item)
  if item.name == "Backstage passes to a TAFKAL80ETC concert"
    backstage_pass(item)
  elsif item.name == 'Aged Brie'
    brie(item)
  else
    regular(item)
  end
end

def regular(item)
  if item.quality > 0
    unless sulfuras?(item)
      if item.sell_in > 0
        item.quality = item.quality - 1
      else
        item.quality = item.quality - 2
      end
    end
  end
end

def reduce_sell_in(item)
  unless sulfuras?(item)
    item.sell_in = item.sell_in - 1
  end
end

# def decrease_quality(item)
#   unless sulfuras?(item)
#     item.quality = item.quality + 1
#   end
# end

# Items that age well

def limit(item)
  item.quality >= 50
end

def brie(item)
  item.quality = item.quality + 1 unless limit(item)
end

def backstage_pass(item)
  if item.sell_in == 0
    item.quality = 0
  elsif limit(item)
    item
  elsif item.sell_in <= 10
    item.quality = item.quality + 2
  elsif item.sell_in <= 5
    item.quality = item.quality + 3
  else
    increase_quality(item)
  end
end

private

def sulfuras?(item)
  item.name == "Sulfuras, Hand of Ragnaros"
end
