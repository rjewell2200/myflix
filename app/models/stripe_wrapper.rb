module StripeWrapper
  class Charge
    def initialize(response)
      @response = response
    end

    def self.create(options={})
      response = Stripe::Charge.create(
        amount: options[:amount],
        currency: 'usd',
        card: options[:card],
        description: options[:description]
      )
      new(response)
    end
    def successful?
      @response.present?
    end
  end
end