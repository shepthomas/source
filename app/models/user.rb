class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :stripe_token, presence: true

  # custom definition to save a user AND subscribe them to stripe
  # in model because it could be used in multiple places other than just user controller
  def save_and_subscribe
    # return false or true to controller
    # check if the user is valid
    # check the stripe token exists

    if self.valid?
      # create a stripe customer
      customer = Stripe::Customer.create(source: self.stripe_token, description: self.email)

      # make a subscription on stripe
      subscription = Stripe::Subscription.create(customer: customer.id, items: [
        {
          plan: self.subscription_plan
        }
      ])

      # save customer id to the database
      self.stripe_customer = customer.id

      # save subscription id to database
      self.stripe_subscription = subscription.id

      # save everything
      self.save

    else
      false
    end

  rescue Stripe::CardError => e

    @message = e.json_body[:error]

    self.errors.add(:stripe_token, @message)

    return false

  end


  def update_with_stripe(form_params)
    # update model with form params
    # check if valid
    # if valid update stripe
    # update database

    # fill model with data attributes but dont save to database
    self.assign_attributes(form_params)

    if self.valid?
      # get subscription from stripe
      subscription = Stripe::Subscription.retrieve(self.stripe_subscription)

      # get first item from subscription
      item_id = subscription.items.data[0].id

      # make our new items list
      items = [
        {
          id: item_id,
          plan: self.subscription_plan
        }
      ]

      #update subscription with new items
      subscription.items = items

      #save subscription to stripe
      subscription.save

      # save our data to database
      self.save

    else
      false
    end

  end

  def destroy_and_unsubscribe
    # get subscription from stripe
    subscription = Stripe::Subscription.retrieve(self.stripe_subscription)

    # delete description
    subscription.delete

    # remove user completely
    self.destroy 
  end

end
