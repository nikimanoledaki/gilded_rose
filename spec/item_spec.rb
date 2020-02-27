# frozen_string_literal: true

require 'item'

describe Item do
  describe '#to_s' do
    it 'creates string with name, sell_in, quality' do
      item = Item.new('foo', 0, 0)
      expect(item.to_s).to eq 'foo, 0, 0'
    end
  end
end
