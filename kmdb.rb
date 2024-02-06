# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)rails db:migrate:status
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!

Studio.destroy_all
Movie.destroy_all
Actor.destroy_all
Cast.destroy_all

# Generate models and tables, according to the domain model.
# TODO!

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

# Insert data in to studio

studio_1 = Studio.new
studio_1 ["name"] = "Warner Bros"
studio_1 ["location"] = "Burbank, California"

studio_1.save

# Insert data into Movies

movie_1 = Movie.new
movie_1 ["title"]         = "Batman Begins"
movie_1 ["year_released"] = 2005
movie_1 ["mpaa_rating"]   = "PG-13"
movie_1 ["studio_id"]     = 1

movie_1.save

movie_2 = Movie.new
movie_2 ["title"]         = "The Dark Knight"
movie_2 ["year_released"] = 2008 
movie_2 ["mpaa_rating"]   = "PG-13"
movie_2 ["studio_id"]     = 1

movie_2.save

movie_3 = Movie.new
movie_3 ["title"]         = "The Dark Knight Rises"
movie_3 ["year_released"] = 2012
movie_3 ["mpaa_rating"]   = "PG-13"
movie_3 ["studio_id"]     = 1

movie_3.save

# Insert data into Actors                  ###### Using different insert syntax to ease up the data insertion process#######

actors_data = [
  ['Christian Bale', 'British'],
  ['Michael Caine', 'British'],
  ['Liam Neeson', 'Irish'],
  ['Katie Holmes', 'American'],
  ['Gary Oldman', 'British'],
  ['Heath Ledger', 'Australian'],
  ['Aaron Eckhart', 'American'],
  ['Maggie Gyllenhaal' ,'American'],
  ['Tom Hardy', 'British'],
  ['Joseph Gordon-Levitt',  'American'],
  ['Anne Hathaway',  'American']
]

actors_data.each do |name, nationality|
  Actor.create(name: name, nationality: nationality)
end

# Insert data into Cast
casts_data = [
  [1, 1, 'Bruce Wayne'],
  [1, 2, 'Alfred'],
  [1, 3, 'Ra\'s Al Ghul'],
  [1, 4, 'Rachel Dawes'],
  [1, 5, 'Commissioner Gordon'],
  [2, 1, 'Bruce Wayne'],
  [2, 6, 'Joker'],
  [2, 7, 'Harvey Dent'],
  [2, 2, 'Alfred'],
  [2, 8, 'Rachel Dawes'],
  [3, 1, 'Bruce Wayne'],
  [3, 5, 'Commissioner Gordon'],
  [3, 9, 'Bane'],
  [3, 10, 'John Blake'],
  [3, 11, 'Selina Kyle']
]

casts_data.each do |movie_id, actor_id, character_name|
  Cast.create(movie_id: movie_id, actor_id: actor_id, character_name: character_name)
end

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!

movies = Movie.all

for movie in movies

    # read the relevant columns from the movie row
    movie_title = movie["title"]
    movie_released = movie["year_released"]
    movie_rating = movie["mpaa_rating"]
    movie_studio = movie["studio_id"]
  
    # display a string with the relevant columns
    puts "#{movie_title} #{movie_released} #{movie_rating} #{movie_studio}"
  end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

movies = Movie.includes(casts: :actor).all

for movie in movies
  puts "Movie: #{movie.title}"

  for cast in movie.casts
    actor_name = cast.actor.name 
    character_name = cast.character_name 
    puts "  - #{actor_name} as #{character_name}"
  end
end

  
  ######## I think my query is right but having an issue in association and that not giving me expected output. I doubled check my db migration and its
  ########  looks fine.