# Dine in the Middle
Term Project for CSC690 (Interactive Multimedia App Development (iOS)): a Swift app that finds the midway point between two locations and displays a list of restaurants around those coordinates.

## Update as of 5/17/2018:
As mentioned in my most recent commit, I was able to get the network request of restaurants successfully; the json data gets printed onto the console when the user taps on the FIND button. Future work will include parsing the json data, representing it in a nice TableView and implement more Nice to Have Feautures.

#### Mock-up/Wireframe:
- 4/17/2018
![alt text](https://preview.ibb.co/fttWsS/IMG_4917.jpg)

- 5/17/2018
![alt text](https://image.ibb.co/dKEu0d/i_OSWireframe51718.png)

##### Map View:
- Contains two text fields to contain locations A and B.
- When the 'Dine' button is pressed, it will take in the coordinates of the two locations as arguments and use Google's interpolate function to find the median point. The median point will be marked, then display a Table View of restaurants around the median point.
- Menu Bar item will be used to represent the nice to have features.
##### Table View:
- Contains cells that has information about restaurants around the median point.
- 'Map' button will take them back to the Map View.

4/17/2018
![alt text](https://image.ibb.co/iT47z7/Screen_Shot_2018_04_17_at_1_13_24_PM.png)

#### Must Have Feautures:
1) User shall type two locations and then the median point is marked.
2) A TableView shall appear that lists restaurants by top rated Yelp reviews. User can navigate back to the Map view using a back button.

#### Nice to Have Feautures:
1) The app could be more general and include different criteria such as 'Drinks' and 'Entertainment.'
2) The map would display the median point AND sub-median points (a total of 3 points).
3) User could adjust the radius range.
4) Everytime the map opens, it would open to the user's current location, (as of 4/14/18, the Bay Area's coordinates are hardcoded in).

#### Tasks:
1) Display location A and B textfields and 'Dine' button asset over GoogleMaps View.
2) Ask for user location permission.
3) Implement method that takes in locations A and B and returns the median distance.
4) Implement Yelp API.
5) Make Yelp TableView with button to go back to Map View.
##### If there's time:
6) Make circular thumbnails of three restaurants that appear over the median point in the Map View.
