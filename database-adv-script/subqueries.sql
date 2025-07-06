--  a query to find all properties where the average rating is greater than 4.0 using a subquery
-- non correlated
select 
    p.property_id,
    p.name,
    p.description,
    (select avg(rating) from reviews r where r.property_id = p.property_id) as average_rating
from 
    properties p
where 
    (select avg(rating) from reviews r where r.property_id = p.property_id) > 4.0;

-- correlated subquery to find users who have made more that  3 bookings
select
    u.user_id,
    u.first_name,
    u.last_name,
    (select count(*) from bookings b where b.user_id = u.user_id) as booking_count
from
    users u
where
    (select count(*) from bookings b where b.user_id = u.user_id) > 3;
