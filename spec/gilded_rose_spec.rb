# frozen_string_literal: true

require 'gilded_rose'
require 'item'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end
  end

  describe '#brie' do
    it 'quality increases the older it gets' do
      brie = [Item.new('Aged Brie', 0, 0)]
      gr = GildedRose.new(brie)
      gr.update_quality
      expect(gr.items[0].quality).to eq 1
    end
  end

  describe '#backstage_pass' do
    it 'increases in Quality by 2 when SellIn <= 10' do
      passes = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 2)]
      gr = GildedRose.new(passes)
      gr.update_quality
      expect(gr.items[0].quality).to eq 4
    end

    it 'increases in Quality by 3 when SellIn <= 5' do
      passes = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 2)]
      gr = GildedRose.new(passes)
      gr.update_quality
      expect(gr.items[0].quality).to eq 4
    end

    it 'drops Quality to zero after the concert' do
      passes = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 2)]
      gr = GildedRose.new(passes)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq 0
    end

    it 'Quality cannot be negative' do
      passes = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 0)]
      gr = GildedRose.new(passes)
      gr.update_quality
      expect(gr.items[0].quality).to eq 0
    end
  end
end
