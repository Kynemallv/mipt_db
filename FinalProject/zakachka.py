import csv
import sqlite3

from datetime import datetime


def main():
    users = []
    logs = []

    with open('users1.csv', encoding='koi8-r') as user:
        user.readline()
        for user_id, email, geo in csv.reader(user, delimiter='\t', skipinitialspace=True):
            user_id = str(user_id).lower() if user_id else None
            email = str(email) if email else None
            geo = str(geo) if geo else None
            users.append((user_id, email, geo))

    with open('log1.csv') as log:
        for user_id, bet_time, bet, win in csv.reader(log):
            user_id = str(user_id).lower() if user_id else None
            bet_time = datetime.strptime(bet_time[1:], '%Y-%m-%d %H:%M:%S').timestamp() if bet_time else None
            bet = int(bet) if bet else 0
            win = int(win) if win else 0
            logs.append((user_id, bet_time, bet, win))

    with sqlite3.connect('raw_db.sqlite3') as conn:
        cur = conn.cursor()

        with open('schema.sql') as schema:
            cur.executescript(schema.read())

        for user_id, email, geo in users:
            cur.execute('INSERT OR IGNORE INTO users VALUES (?, ?, ?)', (user_id, email, geo))
        conn.commit()

        for user_id, bet_time, bet, win in logs:
            cur.execute('INSERT OR IGNORE INTO logs VALUES (?, ?, ?, ?, ?)', (None, user_id, bet_time, bet, win))
        conn.commit()

        with open('clean.sql') as clean:
            cur.executescript(clean.read())


if __name__ == '__main__':
    main()