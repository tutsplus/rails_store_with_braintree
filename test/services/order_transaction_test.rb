require "test_helper"

class OrderTransactionTest < MiniTest::Test
  include FactoryGirl::Syntax::Methods

  def test_creates_a_transaction
    order = Order.new
    order.order_items << OrderItem.new(product: build(:product), quantity: 1)
    nonce = Braintree::Test::Nonce::Transactable
    transaction = OrderTransaction.new order, nonce

    transaction.execute
    assert transaction.ok?, "Expected transaction to be successful."
  end
end
