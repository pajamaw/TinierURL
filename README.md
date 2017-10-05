# TinierUrl
## To run
  - go to https://apoco.herokuapp.com

# Overview
  - Shortest possible lengths - we'll convert the id's of the links into a custom base 66 conversion, that will slowly increment the lenght of the url's
    - should probably consider removing some of the characters that look alike
  - display generated url after creation
  - Want the top 100 visited displayed
    - Cache these?
    - so rails actually caches the results of database calls
    - issue is is that the cache is deleted upon a create or an update - so after another's created there's really no point
  - Add some bootstrap to make it a little prettier
  - maybe add a little javascript to check if valid websites
  - let's add a feature where you can create custom ones as well
    - in order to make that work i'll need another attribute so that I can then path that correctly


### Rough roadmap
  - Tech?
    - Rails 5 let's make it REST
    - DB? - Postgres vs **Cassandra**
      - Actually let's swap out with **mysql**
      - PG would be easy to use here and would be good for showing the top 100 sites
      - then i could also allow users to create their own link easily
        - but is that necessary?
      - haven't used Cassandra before  
      - but the fast read will be good
      - look into how to connect it to heroku
        - instaclustr https://devcenter.heroku.com/articles/instaclustr
    - An easy vanilla job here would probably be fine

#### Backend
  - Model for the ShortenedLink
    - number of times visited
    - timestamps
    - original destintation
    - slug
    - id -> this will be a class method that I can call so upon reaching teh create
      - for cassandra
        - I'll auto increment the id and encode the number using a base conversion alg
        - then i'll feed that into the model
        - if it doesn't persist then I won't increment
      - for mysql
        -
  - method to create the shortenedlink create/post
    - ensure fair amount of additionals
      - actually can't really check that
    - base64 encoding looks pretty good
      - let's add a couple and use 66
  - method to go to the link get/show
  - Let's build a quick Scraper to get a list of websites to use from https://moz.com/top500


### Things that I want to do with this project
  - Have an input on home page that upon submission returns a url of the shortest possible length
    * what's the shortest possible length?
      * what's the use case how many possibilities do we need here
      *  `n^l` usable characters and l positions would equate to the number that are needed
      * bitly uses 7
      * they're also only at
  - redirected to the full URL when we enter the short url
    * maybe clickable into a new tab as well?
  - Top 100 board with the most frequented sites
    * that means that each model will have to have a count of number of times visited
  - Deploy it
  - Prepopulate it with some fake urls to provide smoke and mirrors so people think it's in use
