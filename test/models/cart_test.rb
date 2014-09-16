require "test_helper"

class CartTest < MiniTest::Test
  def test_adds_one_item
    cart = Cart.new
    cart.add_item 1

    assert_equal cart.empty?, false
  end

  def test_adds_up_in_quantity
    cart = Cart.new
    3.times { cart.add_item 1 }

    assert_equal 1, cart.items.length
    assert_equal 3, cart.items.first.quantity
  end

  def test_retrieves_products
    product = Product.create! name: "Tomato", price: 1

    cart = Cart.new
    cart.add_item product.id

    assert_kind_of Product, cart.items.first.product
  end

  def test_serializes_to_hash
    cart = Cart.new
    cart.add_item 1

    assert_equal cart.serialize, session_hash["cart"]
  end

  def test_builds_from_hash
    cart = Cart.build_from_hash session_hash
    assert_equal 1, cart.items.first.product_id
  end

  private

  def session_hash
    {
      "cart" => {
        "items" => [
          { "product_id" => 1, "quantity" => 1 }
        ]
      }
    }
  end
end
