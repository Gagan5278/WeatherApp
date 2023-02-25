# WeatherApp

* Used Xcode Version 14.2
* Used MVVM with coordinator design pattern.
* Swift Code for generating UI. Managing storyboard is tough within a team.
*  https://openweathermap.org/api used for city search and weather search.
* App includes 
  	1.	Search city screen: User can type any city name around the world. OpenWeather API used for retrieving city. 
  	2.	Weather Detail screen:  from searched cites. User can navigate to weather detail screen of any city.
  	3.	Saved City Screen: User can save city weather detail for offline mode from Weather detail screen.  Swipe to delete for saved cities.
  	4.	Empty State: Implemented Empty states for Search City and Saved city screen.
  	5.	Switch between temperature units: User can switch between Kelvin, Celsius, Fahrenheit from Search city screen. 

* Test cases are written.
* Use Of Combine framework for reactive programming and web service implementation. 

## Screen Shots

### Screen: Change Unit
<img width="316" alt="search_city_screen" src="https://user-images.githubusercontent.com/2304583/221371210-3ac865f5-fc98-4f03-aac9-30802d9bcfef.png">

### Screen: Search City Result
<img width="323" alt="search_city_screen_searched" src="https://user-images.githubusercontent.com/2304583/221371217-e5b90b39-1ecf-4274-80f8-d94ec9168988.png">

### Screen: Weather Detail screen with Save action alert (Plus button on Navigation bar)
<img width="310" alt="weather_detail_screen" src="https://user-images.githubusercontent.com/2304583/221371226-285119f8-1c0c-42ea-99ee-54c310bdb146.png">

### Screen: List of saved weather
<img width="321" alt="saved_city_weather_screen" src="https://user-images.githubusercontent.com/2304583/221371232-53328abd-ca8f-4500-b753-f4815c347975.png">
