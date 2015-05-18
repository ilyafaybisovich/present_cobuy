===============
Project Outline (as understood by the team before talking to client)
===============

```
As a caring and efficient friend
So that I can co-buy presents with other people
I want an app that automatically buys presents once everybody's paid in

As a finance-aware buyer
So that I can only make a purchase when all funds are received
I want to be notified when we reach our target

As a good friend
So that I can cover part of the cost of a present for my friend
I want to add an arbitrary sum to the pool

As a time-limited friend
So that I don’t have to deal with the complexity
I want the app to be able to manage purchase including postage

As a secretive member of the present-buying community
So that the recipient is not aware of our plans
I want to restrict access to my present-buying page
```

===============
Questions for the client
===============

* Is the cost split evenly or is the contribution amount arbitrary?
* Final payment options: use Zinc.io or trust one of the group with the money?
* How is the present chosen? Does it come from a wishlist, a search, and so on?

===============
Technologies
===============

* Ruby on Rails with the stripe gem as we’re probably interacting with just one API?
* Angular front-end as this will give us more functionality?
* Bootstrap or foundation for CSS?
* PostgreSQL?
* Security technologies to be researched as we’re dealing with card details.

===============
Overview
===============

* Wireframe! Get a rough idea of what the user will want to do and how they’re going to do it before we attempt to start building feature tests and adding functionality.
* Defining the API early on is essential as this allows the project to be split up and worked on separately with full understanding of how the parts will interact. Required to integrate the parts later on without headaches.
