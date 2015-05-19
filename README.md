## «Present Cobuy» ##
#### Make present headaches a thing of the past! ####

===============
Project Outline (as understood by the team before talking to client)
===============

===============
Roadmap
===============

- Sign up & sign in
- Create a gift
- Invite contributors
- Contributors can contribute
- Purchase actioned on last contribution (MVP1)

```
As an efficient friend
So that I don't end up over paying
I want an app that encourages a group to contribute

As the assigned buyer
So that I can only make a purchase when all funds are received
I want to be notified when we reach our target

As the group coordinator
So that I can split the cost evenly
I want to be able to add the present and the cost

As a secretive member of the present-buying community
So that the recipient is not aware of our plans
I want to restrict access to my present-buying page
```


Extended features
-----------------

```
As a good friend
So that I can cover part of the cost of a present for my friend
I want to add an arbitrary sum to the pool

As a time-limited friend
So that I don’t have to deal with the complexity
I want the app to be able to manage purchase including postage
```

===============
Questions for the client
===============

* How is the present chosen? Does it come from a wishlist, a search, and so on?
* How do you want to invite people?
* Do you want the process to be hidden from the recipient?
* Is the cost split evenly or is the contribution amount arbitrary?
* Final payment options: use Zinc.io (automated purchase) or trust one of the group with the money (with a possible voting process to decide who to trust)?

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

===============
API Routes
===============

GET /gifts () => { gifts: [ giftID: 1, items: [ { amazonID: 1, cost: 3.00 }, … ], title: 'Dan’s 30th Birthday', costCovered: 1.00, recipient: 'Dan', organizer: 'Rob', contributers: [ contributionID: 1, … ], … ] }

POST /gifts ( { items: [ { amazonID: 1, cost: 3.00 }, … ], title: 'Dan’s 30th Birthday', costCovered: 1.00, recipient: 'Dan', organizer: 'Rob', contributers: [ { userId: 1, amount: 1.00, token: 'jhjdsgfhsjdgfsdjhs' }, … ] } ) => { giftID: 2 }

GET /gifts/:id () => { giftID: 1, items: [ { amazonID: 1, cost: 3.00 }, … ], title: 'Dan’s 30th Birthday', costCovered: 1.00, recipient: 'Dan', organizer: 'Rob', contributers: [ contributionID: 1, … ] }

POST /contributions ( { giftID: 1, userID: 1, token: 'jhjdsgfhsjdgfsdjhs', amount: 1.00 } ) => { contributionID: 1 }

GET /contributions/:id () => { contributionID: 1, giftID: 1, userID: 1, token: 'jhjdsgfhsjdgfsdjhs', amount: 2.00 }

PATCH /contributions/:id ( { giftID: 1, userID: 1, token: 'jhjdsgfhsjdgfsdjhs', amount: 2.00 } ) => { contributionID: 1, giftID: 1, userID: 1, token: 'jhjdsgfhsjdgfsdjhs', amount: 2.00 }

GET /users () => { users: [ { userID: 1, name: 'Joe', passwordDigest: 'fjkdshgfkj', email: 'me@us.ie' }, … ] }

POST /users ( { name: 'Rob', passwordDigest: 'fjkdshgfkj', email: 'me@us.ie' } ) => { userID: 2 }

GET /users/:id () => { userID: 1, name: 'Joe', passwordDigest: 'fjkdshgfkj', email:'me@us.ie' }

PATCH /users/:id ( { email: 'me@changed.ie' } ) => { userID: 1, name: 'Joe', passwordDigest: 'fjkdshgfkj', email: 'me@changed.ie' }

GET /users/:id/contributions () => { userID: 1, name: 'Joe', contributions: [ { contributionID: 1, giftID: 1, userID: 1, token: 'jhjdsgfhsjdgfsdjhs', amount: 2.00 }, … ] }


===============
Models
===============

- Gifts => has users(contributers) through contributions, belongs to users(as organizers)
- Users => has many gifts(as contributers and organizers)
- Contributions => belongs to gifts and belongs to users
