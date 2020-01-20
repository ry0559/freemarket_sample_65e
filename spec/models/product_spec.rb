require 'rails_helper'
describe Product do
  describe '#create' do
    it "商品ページのテスト" do
    end

    it "imageが空で登録出来ない事" do
      product = Product.new(image:"")
      product.valid?
      expect(product.errors[:image]).to include("can't be blank")
    end

aaaaaaaaa


  end
end