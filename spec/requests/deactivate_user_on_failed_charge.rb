require 'spec_helper'

describe 'Deactivate user on failed charge' do
  let(:event_data) do
    {
      "id" => "evt_1044js28PjG3dl110LC1Ml5D",
      "created" => 1400681318,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
        "object" => {
          "id" => "ch_1044js28PjG3dl118AwmDdOo",
          "object" => "charge",
          "created" => 1400681318,
          "livemode" => false,
          "paid" => false,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_1044jp28PjG3dl11WgFUqrea",
            "object" => "card",
            "last4" => "0341",
            "type" => "Visa",
            "exp_month" => 5,
            "exp_year" => 2018,
            "fingerprint" => "EovdprEDsRA6jCCW",
            "country" => "US",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country" => nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil,
            "customer" => "cus_44PyXoUGySL8xo"
          },
          "captured" => false,
          "refunds" => [],
          "balance_transaction" => nil,
          "failure_message" => "Your card was declined.",
          "failure_code" => "card_declined",
          "amount_refunded" => 0,
          "customer" => "cus_44PyXoUGySL8xo",
          "invoice" => nil,
          "description" => "payment to fail",
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_44js6RhmoRpCQa"
    }
  end
  it "should deactivate the user with the webhook data from Stripe for a failed charge", :vcr do
    alice = Fabricate(:user, active: true, customer_token: "cus_44PyXoUGySL8xo")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end
end