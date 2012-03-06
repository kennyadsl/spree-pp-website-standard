class PaypalController < CheckoutController 
  protect_from_forgery :except => [:confirm] 
  skip_before_filter :persist_gender

  def confirm
    @order = Order.find_by_number(params[:invoice]) || current_order
    # Empty session after valid payments
    session[:order_id] = nil
    if @order
      flash[:notice] = I18n.t(:order_processed_successfully)
      flash[:commerce_tracking] = "nothing special"
      redirect_to order_path(@order)
    else
      redirect_to cart_path
    end
  end

end
