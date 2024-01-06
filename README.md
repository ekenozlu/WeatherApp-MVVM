# WeatherApp MVVM
This application is built for a case study assignment.

##Small Notes for Case Study

##App Contains
1. MVVM Structure
2. OOP and POP
3. Unit Tests, UI Tests
4. CoreData
5. URLSession and Pagination
6. DispatchQueue, DispatchGroup
7. MapKit and other UIKit elements
8. NSLayoutConstraint
9. Error Messages Handling

##App Lifecycle
1. User can see the weather forecast of some cities by 10 items per page.
2. User can refresh the data (unfortunately it is the same data)
3. Each time user refresh the data it cache the first 10 to CoreData (Update values if already exist)
4. User can search cities from search bar
5. User can see details of each city. Detail contains location, humidity, wind and next 2 days forecast.
6. User can favourite/unfavourite the city by Details Page or swiping left from Home and Favs tab
7. Favourite cities are stored in CoreData and also available without connection
8. User can share the forecast information with UIActivityViewController
9. Different type of explaining errors around the app for better experience.

https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/AppIcon.png


| App Icon |
| -------- |
| <img src="https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/AppIcon.png" width="200" alt="App Icon"> |

| Online Home Screen | Favs Screen (Empty) | Favs Screen | Offline Home Screen |
| ------------------ | ------------------- | ----------- | ------------------- |
| ![Online Home Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_online.png "Online Home Screen") | ![Favs Screen (Empty)](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/favs_nofavs.png "Favs Screen (Empty)") | ![Favs Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/favs.png "Favs Screen") | ![Offline Home Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_offline.png "Offline Home Screen") |
| Main Screen | Favourite Screen | Convert Screen | Favourite Screen |
| ![Online Home Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_online.png "Online Home Screen") | ![Favs Screen (Empty)](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/favs_nofavs.png "Favs Screen (Empty)") | ![Favs Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/favs.png "Favs Screen") | ![Offline Home Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_offline.png "Offline Home Screen") |
| Main Screen | Favourite Screen | Convert Screen | Favourite Screen |
| ![Online Home Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_online.png "Online Home Screen") | ![Favs Screen (Empty)](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/favs_nofavs.png "Favs Screen (Empty)") | ![Favs Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/favs.png "Favs Screen") | ![Offline Home Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_offline.png "Offline Home Screen") |





