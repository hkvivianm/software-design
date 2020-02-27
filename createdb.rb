# Set up for the application and database. DO NOT CHANGE. ##############
require "sequel"                                                       #
DB = Sequel.connect "sqlite://#{Dir.pwd}/development.sqlite3"          #
########################################################################  

# Database schema - this should reflect your domain model
DB.create_table! :events do
  primary_key :id
  String :title
  String :description, text: true #This text:true thing means that this is a larger column => Longer string
  String :date
  String :location
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id #It comes with a special validation, can be used to link with the events table
  Boolean :going #This is binary - 1 / 0 if you go or not
  String :name
  String :email
  String :comments, text: true #String is 240 characters, you need the text if you want it to be longer
end

# Insert initial (seed) data
events_table = DB.from(:events) #We are talking to the events table => Inserting data

events_table.insert(title: "Bacon Burger Taco Fest", 
                    description: "Here we go again bacon burger taco fans, another Bacon Burger Taco Fest is here!",
                    date: "June 21",
                    location: "Kellogg Global Hub")

events_table.insert(title: "Kaleapolooza", 
                    description: "If you're into nutrition and vitamins and stuff, this is the event for you.",
                    date: "July 4",
                    location: "Nowhere")

# Open new terminal to get into sql space by runnung sh sql, enter .exit to leave. End each query with ;