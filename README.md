# MyMovies

My Movies is my first app as an iOS Developer. 
***
My Movies fetch movie data from `tmdb api` and presents the trending movies in the app, the user can watch the trailer, read movie details and see which stream services are streaming the movie so the user can go and watch.

![ezgif com-gif-maker-4](https://user-images.githubusercontent.com/3867413/177428443-d8a51c4f-8b14-4bc9-bc4e-5cd39a2f9a07.gif)
---
### Technologies:
- UIKit
- Dependency management using cocoapods ( kingfisher )
- MVVM architecture
- ViewCode
- API consumption using URLSessions and Decodable Protocol
- Data persisted locally by enconding/decoding Data with NSEnconder and saving/loading in .documentDirectory

### Small optimizations
- Pagination of 20 movies. When the user reaches the end of the ScrollView loads more 20 movies, until the end of the list.
- Stream option requests are made individually when loading the SelectedMovies View, this way you avoid overloading the network by making too many requests.
