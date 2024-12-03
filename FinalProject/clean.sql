INSERT INTO clear_users
SELECT user_id, email, geo FROM users
WHERE (user_id IS NOT NULL) AND (email is not null) AND (geo IS NOT NULL)
;

INSERT INTO clear_logs
SELECT l.log_id,
    substr(l.user_id, instr(l.user_id, " - ") + 3),
    l.bet_time, l.bet, l.win 
FROM logs l INNER JOIN clear_users cu ON substr(l.user_id, instr(l.user_id, " - ") + 3) = cu.user_id
WHERE (bet_time IS NOT NULL)
;