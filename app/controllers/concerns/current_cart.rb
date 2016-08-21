
module CurrentCart
  extend ActiveSupport::Concern

  private



  	#if you want to access your current cart so you will include CurrentCart
    def set_cart 
      @cart = Cart.find(session[:cart_id])
      # for handling exception 
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
end
