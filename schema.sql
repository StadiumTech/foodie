DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id INTEGER PRIMARY KEY AUTOINCREMENT,

  seat_number TEXT NOT NULL,
  contents TEXT NOT NULL,
  restaurant_association INTEGER NOT NULL
);

DROP TABLE IF EXISTS stadiums;
CREATE TABLE stadiums (
 
  id INTEGER PRIMARY KEY AUTOINCREMENT,
 
  name TEXT NOT NULL,
  logo TEXT NOT NULL,

  seating_format TEXT NOT NULL

);

DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
 
  name TEXT NOT NULL,
  logo TEXT NOT NULL,

  stadium_association INTEGER NOT NULL
 
);

DROP TABLE IF EXISTS menu_items;
CREATE TABLE menu_items (
 
  id INTEGER PRIMARY KEY AUTOINCREMENT,
 
  name TEXT NOT NULL,
  price REAL NOT NULL,
 
  restaurant_association INTEGER NOT NULL
 
);


INSERT INTO stadiums ( name, logo, seating_format ) VALUES (
  "Gilette Stadium",
  "uploads/logos/gilette_stadium.png",
  "[A-Z][0-9][0-9]"
);
INSERT INTO stadiums ( name, logo, seating_format ) VALUES (
  "Webster Bank Area",
  "uploads/logos/webster_bank.jpeg",
  "[A-Z][0-9][0-9]"
);
INSERT INTO stadiums ( name, logo, seating_format ) VALUES (
  "Metlife Stadium",
  "uploads/logos/metlife_stadium.jpg",
  "[A-Z][0-9][0-9]"
);
INSERT INTO stadiums ( name, logo, seating_format ) VALUES (
  "TD Garden",
  "uploads/logos/td_garden.png",
  "[A-Z][0-9][0-9]"
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Dunkin Donuts",
  "uploads/logos/dunkin_donuts.jpg",
  1
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Five Guys Burgers",
  "uploads/logos/five_guys.jpeg",
  1
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Moe’s Southwest Southern Grill",
  "uploads/logos/moes.jpeg",
  1
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Menchie’s Frozen Yogurt",
  "uploads/logos/menchies.jpeg",
  1
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Olive Garden",
  "uploads/logos/olive_garden.png",
  1
);
INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Red Robin",
  "uploads/logos/red_robin.jpeg",
  1
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Rita’s Italian Ice",
  "uploads/logos/ritas.jpg",
  2
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Sweet Street",
  "uploads/logos/sweet_street.png",
  2
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Bubba Burger",
  "uploads/logos/bubba_burger.png",
  3
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Calandra’s Bakery",
  "uploads/logos/calandras.png",
  3
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Sal’s Pizzeria",
  "uploads/logos/sals_pizza.jpeg",
  4
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Lucky’s Chicken",
  "uploads/logos/luckys_chicken.jpg",
  4
);

INSERT INTO restaurants ( name, logo, stadium_association ) VALUES (
  "Frito Lay Test Kitchen",
  "uploads/logos/frito_lay_test_kitchen.jpg",
  4
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Iced Coffee",
  3.5,
  1
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Hot Chocolate",
  3,
  1
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Boston Creme Donut",
  2.5,
  1
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Hamburger",
  7,
  2
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Cheeseburger",
  7.5,
  2
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Bacon Burger",
  8,
  2
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Steak Stack",
  9,
  3
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chicken Quesadilla",
  8.5,
  3
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Pork Tacos",
  8.5,
  3
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Original Strawberry",
  5,
  4
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Key Lime Pie",
  5,
  4
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Cookie Dough Monster",
  5,
  4
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Lasagna Frita",
  9.5,
  5
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chicken Alfredo Flatbread",
  10.5,
  5
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Spinach Artichoke Dip",
  8,
  5
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Towering Onion Rings",
  8,
  6
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "BBQ Boneless Wings",
  10,
  6
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chili Nachos",
  12,
  6
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Swedish Fish",
  6,
  7
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Watermelon",
  6,
  7
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Lemon",
  6,
  7
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Cotton Candy",
  5,
  8
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Fresh Lemonade",
  6,
  8
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Sno Cone",
  5,
  8
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Bubba Burger",
  8,
  9
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chili Dog",
  7,
  9
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chicken Sandwich",
  8,
  9
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Croissant",
  5,
  10
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Strawberry Shortcake",
  6,
  10
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chocolate Covered Pretzels (3 Pack)",
  6,
  10
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Hawaiian Pizza",
  8,
  11
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Pepperoni Pizza",
  8,
  11
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Cheese Pizza",
  7,
  11
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chicken Fingers",
  8,
  12
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chicken Caesar Wrap",
  7,
  12
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Chicken Gyro",
  9,
  12
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Cheetos Popcorn",
  7,
  13
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Doritos Tacos",
  9,
  13
);

INSERT INTO menu_items ( name, price, restaurant_association ) VALUES (
  "Flaming Hot Cheetos Mac & Cheese",
  10,
  13
);
