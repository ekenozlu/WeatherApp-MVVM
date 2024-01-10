# WeatherApp MVVM
This application is built for a case study assignment.

## Small Notes about Case Study
1. I handled the pagination as fetching the same data with "limit" keyword. Since the given API is not supporting the traditional "limit" and "offset" keywords at the same time.
2. I fetched the same data of the selected weather in DetailVC again. Since it is a more common situtation in other API's
3. Wrote documentation comment lines in manager classes such as API, CoreData. And also used Mark annotations across the files for better understanding.

##App Contains
1. MVVM Structure
2. OOP and POP
3. Unit Tests, UI Tests
4. CoreData
5. Documentated Functions
6. URLSession and Pagination
7. DispatchQueue, DispatchGroup
8. MapKit and other UIKit elements
9. NSLayoutConstraint
10. Error Messages Handling

## App Lifecycle
1. User can see the weather forecast of some cities by 10 items per page.
2. User can refresh the data (unfortunately it is the same data)
3. Each time user refresh the data it cache the first 10 to CoreData (Update values if already exist)
4. User can search cities from search bar
5. User can see details of each city. Detail contains location, humidity, wind and next 2 days forecast.
6. User can favourite/unfavourite the city by Details Page or swiping left from Home and Favs tab
7. Favourite cities are stored in CoreData and also available without connection
8. User can share the forecast information with UIActivityViewController
9. Different type of explaining errors around the app for better experience.

| App Icon |
| -------- |
| <img src="https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/AppIcon.png" width="200" alt="App Icon"> |

| Online Home Screen | Favs Screen (Empty) | Favs Screen | Offline Home Screen |
| ------------------ | ------------------- | ----------- | ------------------- |
| ![Online Home Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_online.png "Online Home Screen") | ![Favs Screen (Empty)](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/favs_nofavs.png "Favs Screen (Empty)") | ![Favs Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/favs.png "Favs Screen") | ![Offline Home Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_offline.png "Offline Home Screen") |
| Offline Home Screen (Empty) | Home Screen Pagination Indicator | Home Screen Search (Result) | Home Screen Search (No Result) |
| ![Offline Home Screen (Empty)](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_offline_nocacheddata.png "Offline Home Screen (Empty)") | ![Home Screen Pagination Indicator](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_paginationindicator.png "Home Screen Pagination Indicator") | ![Home Screen Search (Result)](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/search_found.png "Home Screen Search (Result)") | ![Home Screen Search (No Result)](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/search_nofound.png "Home Screen Search (No Result)") |
| Detail Screen | Detail Screen (Connection Error) | Detail Screen Activity Controller | Activity Controller Result |
| ![Detail Screen](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/detail.png "Detail Screen") | ![Detail Screen (Connection Error)](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/detail_connectionerror.png "Detail Screen (Connection Error)") | ![Detail Screen Activity Controller](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/detail_activityvc.png "Detail Screen Activity Controller") | ![Activity Controller Result](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/activityvc_result.png "Activity Controller Result") |
| Swipe to Add Fav | Swipe to Remove Fav | Home Screen Refresh Control |
| ![Swipe to Add Fav](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_addtofav.png "Swipe to Add Fav") | ![Swipe to Remove Fav](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_removefromfav.png "Swipe to Remove Fav") | ![Home Screen Refresh Control](https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/home_refreshcontrol.png "Home Screen Refresh Control") |

| Other Devices |
| ------------- |
| <img src="https://github.com/ekenozlu/WeatherApp-MVVM/blob/main/GitImages/all_devices.png" width="1000" alt="Other Devices"> |

