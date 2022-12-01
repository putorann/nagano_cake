class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total_amount = 0
    @postage = 800
  end
end
