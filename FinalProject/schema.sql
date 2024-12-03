DROP TABLE IF EXISTS logs;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS clear_logs;
DROP TABLE IF EXISTS clear_users;

CREATE TABLE logs (
    log_id INTEGER PRIMARY KEY,
    user_id TEXT,
    bet_time TIMESTAMP,
    bet INTEGER,
    win INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE users (
    user_id TEXT PRIMARY KEY,
    email TEXT,
    geo TEXT
);

CREATE TABLE clear_logs (
    log_id INTEGER PRIMARY KEY,
    user_id TEXT NOT NULL,
    bet_time TIMESTAMP NOT NULL,
    bet INTEGER NOT NULL,
    win INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE clear_users (
    user_id TEXT PRIMARY KEY,
    email TEXT NOT NULL,
    geo TEXT NOT NULL
);