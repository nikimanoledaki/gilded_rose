# frozen_string_literal: true

require_relative 'item.rb'

class GildedRose
  attr_reader :items
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        backstage_pass(item)
      elsif item.name == 'Aged Brie'
        brie(item)
      else
        if item.quality > 0
          if item.name != 'Sulfuras, Hand of Ragnaros'
            item.quality = item.quality - 1
          end
        end
      end

      if item.name != 'Sulfuras, Hand of Ragnaros'
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            if item.quality > 0
              if item.name != 'Sulfuras, Hand of Ragnaros'
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        end
      end

    end
  end
end

def reduce_sell_in(item)
  item.sell_in = item.sell_in - 1
end


# Items that age well

def increase_quality(item)
  if item.quality < 50
    item.quality = item.quality + 1
  end
end

def brie(item)
  increase_quality(item)
  reduce_sell_in(item)
end

def backstage_pass(item)
  if item.sell_in <= 10
    item.quality = item.quality + 2
  elsif item.sell_in <= 5
    item.quality = item.quality + 3
  elsif item.sell_in == 0
    item.quality = 0
  else
    increase_quality(item)
  end
  reduce_sell_in(item)
end
