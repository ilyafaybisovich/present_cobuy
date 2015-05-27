def stripe_payment
  visit '/gifts/1'
  page.find('.stripe-button-el').click
  stripe = all('iframe[name=stripe_checkout_app]').last
  page.within_frame stripe do
    fill_in_stripe_fields
    page.find('#submitButton').click
  end
  sleep 5
end

private

def fill_in_stripe_fields
  fill_in 'email', with: 'test@test.com'
  fill_in 'card_number', with: '4242 4242 4242 4242'
  fill_in 'cc-exp', with: '12/18'
  fill_in 'cc-csc', with: '123'
end
