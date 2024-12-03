-- task 1
select avg(count)
from (
    select count(bet) as count
    from clear_logs
    where bet = 0
    group by user_id
    having bet_time < (
        select min(bet_time)
        from clear_logs l
        where l.bet != 0 and l.user_id = user_id
    )
)

-- task 2
select avg(procent_win)
from (
    select
        case when sum(win) != 0
        then (sum(win) * 100.0) / sum(bet)
        else 0
        end as procent_win
    from clear_logs
    group by user_id
)

-- task 3
select user_id, sum(win) - sum(bet) as balance
from clear_logs
group by user_id

-- task 4
select geo, avg(dohod) as avg_dohod
from (
    select user_id, sum(bet) - sum(win) as dohod
    from clear_logs
    group by user_id
) r join clear_users u where r.user_id = u.user_id
group by geo
order by avg_dohod desc

-- task 5
select geo, max(user_max_bet) as max_bet
from (
    select user_id, max(bet) as user_max_bet
    from clear_logs
    group by user_id
) r join clear_users u where r.user_id = u.user_id
group by geo
order by max_bet desc

-- task 6
from (
    select julianday(first_bet) - julianday(first_enter) as days
    from (
        select user_id, min(bet_time) as first_enter
        from clear_logs
        group by user_id
    ) e join (
        select user_id, min(bet_time) as first_bet
        from clear_logs
        where bet != 0
        group by user_id
    ) b on e.user_id = b.user_id
)