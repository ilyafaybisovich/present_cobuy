Master:
[![Build Status](https://travis-ci.org/Gwasanaethau/present_cobuy.svg?branch=master)](https://travis-ci.org/Gwasanaethau/present_cobuy)
[![Coverage Status](https://coveralls.io/repos/Gwasanaethau/present_cobuy/badge.svg?branch=master)](https://coveralls.io/r/Gwasanaethau/present_cobuy?branch=master)

Development:
[![Build Status](https://travis-ci.org/Gwasanaethau/present_cobuy.svg?branch=develop)](https://travis-ci.org/Gwasanaethau/present_cobuy)
[![Coverage Status](https://coveralls.io/repos/Gwasanaethau/present_cobuy/badge.svg?branch=develop)](https://coveralls.io/r/Gwasanaethau/present_cobuy?branch=develop)


# Giftbox #

[www.ronin-giftbox.co.uk](https://www.ronin-giftbox.co.uk)

A final project at Makers Academy, for a team of Ronin students carried out between 18-29 June 2015. The team comprised of [Iciar](https://github.com/Icicleta), [Ilya](https://github.com/ilyafaybisovich), [Mark](https://github.com/Gwasanaethau) and [Rob](https://github.com/RBGeomaticsRob).

The whole project was designed and implemented by the team of 4 working remotley using Google Hangouts and Github to remotely pair. The project was implemented using an agile BDD approach, with full test-driven development throughout.

Giftbox is a collaborative service to allow groups to collectively purchase gifts for an individual. A simple process allows the user to select a gift, add contributers, take payments and automatically make the purchase and ship on receiving the last contribution.

The project was [presented](https://www.dropbox.com/s/rzkvuqnnk3z3fvo/Presentation.key?dl=0) on 29 June at Makers Academy Graduation.

Appoach

The team initially met with the client and crafted a set of user stories to better understand the clients requirement. Using these the team then crafted a MVP roadmap being aware of the basic domain design upfront, but letting the specifics of this emerge as the project developed.

The group split this MVP roadmaps down into tickets and used a Trello [kanban board](https://trello.com/b/earxI39d/giftbox) to manage the work processes, working in pairs to complete each ticket requirement. Meeting for twice daily standups to check on progress and blockages to the team, including a focus on current test coverage and status.

Rob blogged some further details of the progress of the project [here](http://rbgeomaticsrob.github.io/)

### Giftbox - Making present headaches a thing of the past! ###

### User Stories ###

```
As an cost-aware friend
So that I don't end up covering other peoples costs
I want an app that encourages a group to collaborate

As the group coordinator
So that I can split the cost evenly
I want to be able to add the present and the cost

As a picky shopper
So that I can have a large range of products available to choose from
I want to be able to select products from amazon

As a secretive member of the present-buying community
So that the recipient is not aware of our plans
I want to restrict access to my present-buying page

As a time-limited friend
So that I don’t have to deal with the complexity
I want the app to be able to manage purchase including despatch
```

### Technologies ###

Development
- Ruby on Rails
- Postgres
- Front-end - HTML5, CSS3, Bootstrap, JQuery
- Payment - Stripe, Zinc.io

Testing
- RSpec
- Capybara
- Poltergeist
- Puffing Billy

CI
- Travis

Security
- The production domain is setup with SSL for compliance with Stripe.

### Models (EDUF) ###

- Gifts => has users(contributers) through contributions, belongs to users(as organizers)
- Users => has many gifts(as contributers and organizers)
- Contributions => belongs to gifts and belongs to users

### MVP Roadmap ###

- Sign up & sign in
- Create a gift
- Invite contributors
- Contributors can contribute
- Purchase actioned on last contribution (MVP1)

### Tests ###

```
GiftsController
  Receives a response from Amazon –
    returns a hash with a list of products
    returns an empty hash when no products found
  Formats the response from Amazon –
    returns the correct number of items
    returns the correct number of key-value pairs in the hash
    returns the correct value for an ASIN
    returns the correct value for an image path
    returns the correct value for a URL path
    returns the correct value for a title
    returns the correct value for a price
    returns nil when a key is not available in the Amazon response

Amazon Search
  When user is not signed in –
    user cannot search for an Amazon product
  When signed in and on the giftbox creation page –
    user sees the product search form
    user searches for a valid product on Amazon
    user searches for an invalid product on Amazon
    user selects a product for the giftbox
    before performing a search –
      user cannot see any Amazon products

Create Giftbox
  When user is not signed in –
    user cannot create a giftbox
  When user is signed in –
    user sees button to create a giftbox
    user can navigate to the giftbox creation page
    user navigates to the giftbox creation page –
      user can create a giftbox
      organiser is also a contributor
      additional contributors can be added to giftbox
      contributors can be removed from giftbox

Manage Giftbox
  Organiser creates a giftbox –
    organiser sees the giftbox title
    organiser sees the delivery address
    organiser sees the item title
    organiser sees the item cost split between contributors
    organiser sees the item image
    organiser sees all contributors
    organiser sees a progress bar
  Contributors make payments –
    progress bar at 0% before any payments
    progress bar updates on payment
    action zinc.io payment on all purchases being made

User Page
  When user is not signed in –
    user cannot see any profile page
  When user is signed in –
    user sees a button to view their profile
    user cannot see anyone else’s profiles
    user navigates to their profile page –
      user sees their name
      user sees their email address
      user sees an empty list if they are not contributing to anything
    user creates a giftbox –
      user sees giftbox on profile page after creation
      user sees two giftboxes on profile page
  When added as a contributor by another user –
    user sees giftboxes they were added to before signing up
    user sees giftboxes they can contribute to but did not create

User Session
  When not signed in –
    visitor navigates to the home page –
      visitor sees tag-line, sign in form and sign up button
      visitor cannot see sign out button
      visitor can navigate to sign up page
    visitor navigates to the sign up page –
      visitor signs up
    previous user signs in –
      user signs back in
  When signed in –
    user navigates to the home page –
      user cannot see sign in form or sign up button
      user sees sign out button
      user can sign out and see visitor’s home page

ContributorMailer
  renders the headers
  renders the body

Contributor
  should belong to gift

Gift
  should have many contributors
  calculates a split price
  re-calculates a split price when a contributor is removed
  calculates the number of contributers that have paid
  calculates the % contribution
  detects that not everyone has contributed
  detects when everyone has contributed
```