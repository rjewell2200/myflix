class UserSignup
  attr_reader :error_message, :successful
  #attr_writer :successful

  def initialize(user)
    @user = user  
  end

  def sign_up(stripe_token, invitation_token)
    if @user.valid?
      customer = StripeWrapper::Customer.create(
        :user => @user,
        :card => stripe_token
        )
      if customer.successful?
        @user.save
        handles_invitation(invitation_token)
        AppMailer.delay.notify_on_registration(@user.id)
        @status = :success
        @successful = customer.successful?
        self
      else
        @status = :failed
        @error_message = customer.error_message
        self
      end
    else
      @status = :failed
      @error_message = "Invalid user information. Please check the errors below."
      self
    end
  end

  #def successful?
  #  @status == :success
  #end

private

  def handles_invitation(invitation_token)
    if invitation_token.present?
      invitation = Invitation.where(invitation_token: invitation_token).first
      @user.follow!(invitation.inviter)
      invitation.inviter.follow!(@user)
      invitation.update_columns(invitation_token: nil)
    end
  end
end