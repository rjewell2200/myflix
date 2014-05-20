class Admin::PaymentsController < AdminController
  before_action :authorize, :ensure_admin
  
  def index
    @payments = Payment.all
  end
end