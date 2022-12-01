class Public::OrdersController < ApplicationController
  def new
    if current_customer.cart_items.count == 0
      redirect_to cart_items_path
    end
    @order = Order.new
  end

  def confirm
    if current_customer.cart_items.count == 0
      redirect_to cart_items_path
    end
    @cart_items=current_customer.cart_items
    @total_amount = 0
    @postage = 800

    @order = Order.new(order_params)

    if params[:order][:select_address] == "0"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] =="1"
        @address = Address.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
    else "2"
    end
  end


  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
    @order_product = OrderProduct.new
    @order_product.item_id = cart_item.item_id
    @order_product.order_id = @order.id
    @order_product.amount = cart_item.amount
    @order_product.price = cart_item.item.with_tax_price
    @order_product.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @total_amount = 0
    @postage = 800

  end

  private

  def order_params
  params.require(:order).permit(:method_of_payment,:postal_code, :address, :name, :postage, :amount_builled)
  end

end