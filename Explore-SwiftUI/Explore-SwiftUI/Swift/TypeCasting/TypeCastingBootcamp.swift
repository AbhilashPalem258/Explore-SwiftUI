//
//  TypeCastingBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/11/22.
//

import SwiftUI

/*
 Source:
 
 Definition:
 
 Notes:
- Casting doesn’t actually modify the instance or change its values. The underlying instance remains the same; it’s simply treated and accessed as an instance of the type to which it has been cast.
 
- Swift provides two special types for working with nonspecific types:
    Any can represent an instance of any type at all, including function types.
    AnyObject can represent an instance of any class type.
 
 - The Any type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type Any is expected. If you really do need to use an optional value as an Any value, you can use the as operator to explicitly cast the optional to Any, as shown below.
 
     let optionalNumber: Int? = 3
     things.append(optionalNumber)        // Warning
     things.append(optionalNumber as Any) // No warning
 */

fileprivate class MediaItem {
    let name: String
    init(name: String) {
        self.name = name
    }
}

fileprivate class Movie: MediaItem {
    let director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

fileprivate class Song: MediaItem {
    let artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

fileprivate struct DataManager {
    //The type of the library array is inferred by initializing it with the contents of an array literal. Swift’s type checker is able to deduce that Movie and Song have a common superclass of MediaItem
    let library = [
        Movie(name: "Movie 1", director: "Director 1"),
        Song(name: "Song 1", artist: "Artist 1"),
        Movie(name: "Movie 2", director: "Director 2"),
        Song(name: "Song 2", artist: "Artist 2"),
        Movie(name: "Movie 3", director: "Director 3"),
        Song(name: "Song 3", artist: "Artist 3"),
        Movie(name: "Movie 4", director: "Director 4"),
        Movie(name: "Movie 5", director: "Director 5"),
        Movie(name: "Movie 6", director: "Director 6"),
    ]
}

fileprivate class ViewModel: ObservableObject {
    let dataManager = DataManager()
    
    func checkMovieAndSongCount() {
        var movieCount = 0, songCount = 0
        for item in dataManager.library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        print("MovieCount: \(movieCount), SongCount: \(songCount)")
    }
    
    func differentiateMovieAndSong() {
        var movies = [Movie](), songs = [Song]()
        for item in dataManager.library {
            if let movie = item as? Movie {
                movies.append(movie)
            } else if let song = item as? Song {
                songs.append(song)
            }
        }
        print("Movies: \(movies), Songs: \(songs)")
    }
}

struct TypeCastingBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        VStack {
            Button {
                vm.checkMovieAndSongCount()
            } label: {
                Text("Check Casting: is")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.black)
                    .cornerRadius(10.0)
            }
            
            Button {
                vm.differentiateMovieAndSong()
            } label: {
                Text("Type Casting: as")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.black)
                    .cornerRadius(10.0)
            }
        }
    }
}

struct TypeCastingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypeCastingBootcamp()
    }
}
