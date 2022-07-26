# MyMovies

My Movies is an app to see trending movies and where to watch them. It is my first authorial app as an iOS Developer. 

***

My Movies fetch movie data from `tmdb api` and presents the trending movies in the app, the user can watch the trailer, read movie details and see which stream services are streaming the movie so the user can go and watch.

![ezgif com-gif-maker-6](https://user-images.githubusercontent.com/3867413/179374738-219d7ae9-e45d-4f0e-b2e4-84167d1fa70a.gif)
![ezgif com-gif-maker-7](https://user-images.githubusercontent.com/3867413/179374786-993e6586-57dd-45bc-9fd7-4dc2027d2f22.gif)
![ezgif com-gif-maker-8](https://user-images.githubusercontent.com/3867413/179374829-1f0e0d51-65f2-4caa-881c-36d36b1fc4bb.gif)
---
### Updates:
- i will implement a search bar on homeScreen so the user can search any movie he wants.
---
### Technologies:
- UIKit
- Dependency management using cocoapods ( kingfisher, FirebaseAuth )
- MVVM architecture
- ViewCode and xib
- API consumption using URLSessions
- Favorites data persisted locally via UserDefaults
- Authentication via FirebaseAuth

### Small optimizations
- Pagination of 20 movies. When the user reaches the end of the ScrollView loads more 20 movies, until the end of the list.
- API fetch calls while the user is scrolling, to give an infinite scroll effect.
- Stream options requests are made individually when loading the SelectedMovies View, this way you avoid overloading the network by making too many requests.
