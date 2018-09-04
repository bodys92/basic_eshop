require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(code: "test00001", 
                            url: "testovaci-produkt",
                            title: "Testovaci produkt", 
                            short_description: "Kratky popisek produktu", 
                            description: "Dlouhy popis produktu",
                            price: 12.90) 
                            #old_price: 0, 
                            #ratings: ratings, 
                            #rating_sum: r, 
                            #stock: stock, 
                            #images_count: images_count, 
                            #hidden: false)
  end

  test "validity test" do
    assert @product.valid?
  end

  test "code should be present" do
    @product.update_attribute(:code, "      ")
    assert_not @product.valid?
  end
  test "url should be present" do
    @product.update_attribute(:url, "      ")
    assert_not @product.valid?
  end
  test "title should be present" do
    @product.update_attribute(:title, "      ")
    assert_not @product.valid?
  end
  test "short_description should be present" do
    @product.update_attribute(:short_description, "      ")
    assert_not @product.valid?
  end
  test "description should be present" do
    @product.update_attribute(:description, "      ")
    assert_not @product.valid?
  end
  test "price should be present" do
    @product.update_attribute(:price, "      ")
    assert_not @product.valid?
  end
  test "price should be number" do
    @product.update_attribute(:price, "trinact")
    assert_not @product.valid?
  end
  test "code should not be too long" do
    @product.code = "a" * 256
    assert_not @product.valid?
  end
  test "url should not be too long" do
    @product.url = "a" * 256
    assert_not @product.valid?
  end
  test "title should not be too long" do
    @product.title = "a" * 256
    assert_not @product.valid?
  end
  test "description should not be too long" do
    @product.description = "a" * 256
    assert_not @product.valid?
  end
  test "short_description should not be too long" do
    @product.short_description = "a" * 51
    assert_not @product.valid?
  end
  test "url should be same like title" do
        assert @product[:title].downcase.split.join("-") == @product[:url]
  end

end
