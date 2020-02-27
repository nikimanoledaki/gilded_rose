# frozen_string_literal: true

require 'gilded_rose'
require 'item'

describe 'Feature tests' do
  context 'Quality of regular items' do
    it 'degrades twice as fast after the sell by date' do
      books = [Item.new('Book', 1, 4)]
      gr = GildedRose.new(books)
      gr.update_quality
      gr.update_quality
      expect(gr.items[0].quality).to eq 1
    end

    it 'cannot be negative' do
      books = [Item.new('Book', 1, 4)]
      gr = GildedRose.new(books)
      gr.update_quality
      expect(gr.items[0].quality).not_to eq -1
    end
  end

  context 'Quality of any item' do
    it 'cannot be more than 50' do
      brie = [Item.new('Aged Brie', -25, 50)]
      gr = GildedRose.new(brie)
      gr.update_quality
      expect(gr.items[0].quality).to eq 50
    end
  end

  context 'Sulfuras' do
    it 'quality does not decrease' do
      sulfuras = [Item.new('Sulfuras', 0, 0)]
      gr = GildedRose.new(sulfuras)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq before
    end

    it 'quality does not decrease' do
      sulfuras = [Item.new('Sulfuras, Hand of Ragnaros', 0, 0)]
      gr = GildedRose.new(sulfuras)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq before
    end
  end

end
