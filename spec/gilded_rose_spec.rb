# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
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

  describe '#regular' do
    it 'cannot be negative' do
      books = [Item.new('Book', 1, 4)]
      gr = GildedRose.new(books)
      gr.update_quality
      expect(gr.items[0].quality).not_to eq -1
    end

    it 'degrades twice as fast after the sell by date' do
      books = [Item.new('Book', 0, 4)]
      gr = GildedRose.new(books)
      gr.update_quality
      expect(gr.items[0].quality).to eq 2
    end
  end

  context '#sulfuras' do
    it 'sell_in does not change' do
      sulfuras = [Item.new('Sulfuras, Hand of Ragnaros', 0, 0)]
      gr = GildedRose.new(sulfuras)
      before = gr.items[0].sell_in
      gr.update_quality
      expect(gr.items[0].sell_in).to eq before
    end

    it 'quality does not decrease' do
      sulfuras = [Item.new('Sulfuras, Hand of Ragnaros', 0, 0)]
      gr = GildedRose.new(sulfuras)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq before
    end
  end

  describe '#brie' do
    it 'quality increases the older it gets' do
      brie = [Item.new('Aged Brie', 0, 0)]
      gr = GildedRose.new(brie)
      gr.update_quality
      expect(gr.items[0].quality).to eq 1
    end

    it 'cannot be more than 50' do
      brie = [Item.new('Aged Brie', -25, 50)]
      gr = GildedRose.new(brie)
      gr.update_quality
      expect(gr.items[0].quality).to eq 50
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

    it 'Quality cannot be more than 50' do
      item = [Item.new('Backstage passes to a TAFKAL80ETC concert', 2, 50)]
      gr = GildedRose.new(item)
      gr.update_quality
      expect(gr.items[0].quality).to eq 50
    end
  end
end

# expired items
# approach_zero