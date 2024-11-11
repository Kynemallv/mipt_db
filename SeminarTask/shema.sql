CREATE table User (
    Id INTEGER PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    username TEXT NOT NULL
);

CREATE table Movie (
    Id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    genres TEXT NOT NULL
);

CREATE table Review (
    timestamp INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL,
    FOREIGN KEY (userId) REFERENCES User (Id),
    movieId INTEGER NOT NULL,
    FOREIGN KEY (movieId) REFERENCES Movie (Id),
    rating INTEGER NOT NULL
);