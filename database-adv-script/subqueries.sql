-- a query to find all properties where the average rating is greater than 4.0 using a subquery
-- non correlated
SELECT 
    p.property_id,
    p.name,
    p.description,
    (SELECT AVG(rating) FROM reviews r WHERE r.property_id = p.property_id) AS average_rating
FROM 
    properties p
WHERE 
    (SELECT AVG(rating) FROM reviews r WHERE r.property_id = p.property_id) > 4.0;

-- correlated subquery to find users who have made more than 3 bookings
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    (SELECT COUNT(*) FROM bookings b WHERE b.user_id = u.user_id) AS booking_count
FROM
    users u
WHERE
    (SELECT COUNT(*) FROM bookings b WHERE b.user_id = u.user_id) > 3;