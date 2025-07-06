--Inner join to retrieve all bookings and the respective users who made those booking
select 
b.booking_id,
b.start_date,
b.end_date,
b.total_price,
u.user_id,
u.first_name,
u.last_name,
u.email
from bookings b INNER JOIN users u on b.user_id = u.user_id;

--Left join to retrieve retrieve all properties and their reviews, including properties that have no reviews.

SELECT 
    p.property_id, 
    p.name, 
    p.description, 
    r.review_id, 
    r.rating, 
    r.comment
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id;

--full outer join to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

SELECT 
    u.user_id,
    u.first_name, 
    u.last_name, 
    b.booking_id, 
    b.start_date, 
    b.end_date
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id;

