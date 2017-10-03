# TinierUrl

### Rough roadmap
  - Tech?
    - Rails 5 let's make it REST
    - DB? - Postgres vs **Cassandra**
      - PG would be easy to use here and would be good for showing the top 100 sites
      - then i could also allow users to create their own link easily
        - but is that necessary?
      - haven't used Cassandra before  
      - but the fast read/write will be good
      - look into how to connect it to heroku
        - instaclustr https://devcenter.heroku.com/articles/instaclustr
    - An easy vanilla job here would probably be fine
    - Testing with Cassandra?

#### Backend
  - Model for the ShortenedLink
    - number of times visited
    - timestamps
    - original destintation
    - slug
    - id -> this will be a class method that I can call so upon reaching teh create
      - I'll auto increment the id and encode the number using a base conversion alg
      - then i'll feed that into the model
      - if it doesn't persist then I won't increment
  - method to create the shortenedlink create/post
    - ensure fair amount of additionals
    - ensure that it's not a duplicate
    - base64 encoding looks pretty good
  - method to go to the link get/show
  - displaying and





### Things that I want to do with this project
  - Have an input on home page that upon submission returns a url of the shortest possible length
    * what's the shortest possible length?
      * what's the use case how many possibilities do we need here
      *  `n^l` usable characters and l positions would equate to the number that are needed
      * bitly uses 7
  - redirected to the full URL when we enter the short url
    * maybe clickable into a new tab as well?
  - Top 100 board with the most frequented sites
    * that means that each model will have to have a count of number of times visited
    * Should I include that upon the homepage?
      - Probably as otherwise I'd use up a possible combination
  - Deploy it
  - Prepopulate it with some fake urls to provide smoke and mirrors so people think it's in use
