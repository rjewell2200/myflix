require 'spec_helper'

describe "Create payment on successful charge" do
  let(:event_data) do
    {
      "id" => "evt_1043hI28PjG3dl11xZU8F0fC",
      "created" => 1400441074,
      "livemode" => false,
      "type" => "charge.succeeded",
      "data" => {
        "object" => {
          "id" => "ch_1043hI28PjG3dl11vR3JcyXc",
          "object" => "charge",
          "created" => 1400441074,
          "livemode" => false,
          "paid" => true,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_1043hI28PjG3dl11GNSVGceQ",
            "object" => "card",
            "last4" => "4242",
            "type" => "Visa",
            "exp_month" => 5,
            "exp_year" => 2016,
            "fingerprint" => "OETLyPF3B8PxfIYx",
            "customer" => "cus_43hI5kLqIem4LA",
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
            "address_zip_check" => nil
          },
          "captured" => true,
          "refunds" => [],
          "balance_transaction" => "txn_1043hI28PjG3dl117bC2JF3a",
          "failure_message" => nil,
          "failure_code" => nil,
          "amount_refunded" => 0,
          "customer" => "cus_43hI5kLqIem4LA",
          "invoice" => "in_1043hI28PjG3dl119phtZt9p",
          "description" => nil,
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_43hIROfCStjoGG"
    }
  end

  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end
end