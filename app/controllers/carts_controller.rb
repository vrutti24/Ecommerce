class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def show
    @cart = current_user.cart || Cart.new
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add_item
    product = Product.find(params[:product_id])
    
    @cart = if current_user.present? && cookies[:cart_id].present? 
      check_for_cart
    elsif current_user.present?
      current_user.current_cart
    elsif cookies[:cart_id].present? 
      Cart.find_by_id(cookies[:cart_id]) 
    end
    
    @cart = Cart.create unless @cart.present?
    existing_item =  @cart.cart_items.find_by(product_id: product.id)

    if existing_item.present?
      existing_item.quantity = existing_item.quantity + params[:quantity].to_i
      existing_item.total = product.price * existing_item.quantity
      existing_item.save
    else
      @cart.cart_items.create(
        product_id: product.id,
        quantity: params[:quantity],
        total: product.price * params[:quantity].to_i
      )
    end

    cookies[:cart_id] = @cart.id unless current_user.present?
    
    redirect_to root_path, notice: "Item added to cart"
  end

  def show
    @cart = if current_user.present? && cookies[:cart_id].present?
      check_for_cart
    elsif current_user.present?
      current_user.current_cart
    elsif cookies[:cart_id].present? 
      Cart.find_by_id(cookies[:cart_id])
    end
  end

  def checkout
    current_user&.current_cart&.update(status: "checkout")
    redirect_to root_path, notice: "Cart Checkout successfully"
  end
  
  private

  def check_for_cart
    current_cart = current_user.current_cart
    current_cart = Cart.create(user_id: current_user.id) unless current_cart.present?
    cookie_cart = Cart.find_by_id(cookies[:cart_id])
    current_cart.cart_items << cookie_cart&.cart_items
    cookie_cart.reload
    cookie_cart.destroy
    cookies.delete(:cart_id)
    current_cart
  end
end
