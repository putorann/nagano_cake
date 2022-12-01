class Public::HomesController < ApplicationController
  def top
   #@item = Item.limit(4).order(" created_at DESC ")
   reverse_items = Item.order(id:"DESC")
   @items = reverse_items.first(4)
  end

  def about
  end
end