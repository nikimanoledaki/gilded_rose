require 'gilded_rose'
require 'item'

describe 'Feature tests' do

  context 'Quality of regular items' do
    
    it 'degrades twice as fast after the sell by date' do
      books = [Item.new("Book", 1, 4)]
      gr = GildedRose.new(books)
      gr.update_quality
      expect(gr.items[0].quality).to eq 3
      gr.update_quality
      expect(gr.items[0].quality).to eq 1
    end

    it 'cannot be negative' do
      books = [Item.new("Book", 1, 4)]
      gr = GildedRose.new(books)
      gr.update_quality
      expect(gr.items[0].quality).not_to eq -1
    end
  end

  context 'Quality of any item' do
    it 'cannot be more than 50' do
      brie = [Item.new("Aged Brie", -25, 50)]
      gr = GildedRose.new(brie)
      gr.update_quality
      expect(gr.items[0].quality).to eq 50
    end
  end

  context 'Aged Brie' do
    it 'quality increases the older it gets' do
      brie = [Item.new("Aged Brie", 0, 0)]
      gr = GildedRose.new(brie)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to be > before
    end
  end

  context 'Sulfuras' do
    it 'quality does not decrease' do
      sulfuras = [Item.new("Sulfuras", 0, 0)]
      gr = GildedRose.new(sulfuras)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq before
    end

    it 'quality does not decrease' do
      sulfuras = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
      gr = GildedRose.new(sulfuras)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq before
    end
  end

  context 'Backstage Passes' do
    it 'increases in Quality by 2 when SellIn <= 10' do
      passes = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 2)]
      gr = GildedRose.new(passes)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq 4
    end

    it 'increases in Quality by 3 when SellIn <= 10' do
      passes = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 2)]
      gr = GildedRose.new(passes)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq 4
    end

    it 'drops Quality to zero after the concert' do
      passes = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 2)]
      gr = GildedRose.new(passes)
      before = gr.items[0].quality
      gr.update_quality
      expect(gr.items[0].quality).to eq 0
    end
  end

end
