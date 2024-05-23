LOAD DATA LOCAL INFILE 'loadData.txt' 
INTO TABLE works 
FIELDS TERMINATED BY "^" 
LINES TERMINATED BY '\n' 
(title, year_created, medium, size, image_url, number, description, price, sold, accepting_offer);
