-- Insert users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
  ('550e8400-e29b-41d4-a716-446655440000', 'Alice', 'Smith', 'alice.smith@email.com', 'hashed_password_123', '555-0101', 'guest', '2025-06-01 10:00:00'),
  ('550e8400-e29b-41d4-a716-446655440001', 'Bob', 'Johnson', 'bob.johnson@email.com', 'hashed_password_456', '555-0102', 'guest', '2025-06-02 12:00:00'),
  ('550e8400-e29b-41d4-a716-446655440002', 'Carol', 'Williams', 'carol.williams@email.com', 'hashed_password_789', '555-0103', 'guest', '2025-06-03 14:00:00'),
  ('550e8400-e29b-41d4-a716-446655440003', 'David', 'Brown', 'david.brown@email.com', 'hashed_password_012', '555-0104', 'host', '2025-06-04 09:00:00'),
  ('550e8400-e29b-41d4-a716-446655440004', 'Emma', 'Davis', 'emma.davis@email.com', 'hashed_password_345', '555-0105', 'admin', '2025-06-05 11:00:00');

-- Insert locations
INSERT INTO locations (location_id, country, state, city, postal_code, latitude, longitude) VALUES
  ('660e8400-e29b-41d4-a716-446655440000', 'USA', 'California', 'San Francisco', '94105', 37.7749, -122.4194),
  ('660e8400-e29b-41d4-a716-446655440001', 'USA', 'New York', 'New York City', '10001', 40.7128, -74.0060),
  ('660e8400-e29b-41d4-a716-446655440002', 'Canada', 'Ontario', 'Toronto', 'M5V 2T6', 43.6532, -79.3832);

-- Insert properties
INSERT INTO properties (property_id, host_id, name, description, location_id, pricepernight, created_at, updated_at) VALUES
  ('770e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440003', 'Cozy San Francisco Loft', 'A modern loft with bay views in downtown SF.', '660e8400-e29b-41d4-a716-446655440000', 150.00, '2025-06-10 08:00:00', '2025-06-10 08:00:00'),
  ('770e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', 'NYC Studio Apartment', 'Compact studio in the heart of Manhattan.', '660e8400-e29b-41d4-a716-446655440001', 200.00, '2025-06-11 09:00:00', '2025-06-11 09:00:00'),
  ('770e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', 'Toronto Lakefront Condo', 'Spacious condo with lake views.', '660e8400-e29b-41d4-a716-446655440002', 180.00, '2025-06-12 10:00:00', '2025-06-12 10:00:00');

-- Insert bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
  ('880e8400-e29b-41d4-a716-446655440000', '770e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440000', '2025-07-10', '2025-07-12', 300.00, 'confirmed', '2025-06-20 14:00:00'),
  ('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '2025-07-15', '2025-07-18', 600.00, 'pending', '2025-06-21 15:00:00'),
  ('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '2025-07-20', '2025-07-22', 360.00, 'confirmed', '2025-06-22 16:00:00'),
  ('880e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440001', '2025-08-01', '2025-08-03', 300.00, 'canceled', '2025-06-23 17:00:00');

-- Insert payments
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
  ('990e8400-e29b-41d4-a716-446655440000', '880e8400-e29b-41d4-a716-446655440000', 300.00, '2025-06-20 14:30:00', 'credit_card'),
  ('990e8400-e29b-41d4-a716-446655440001', '880e8400-e29b-41d4-a716-446655440001', 600.00, '2025-06-21 15:30:00', 'paypal'),
  ('990e8400-e29b-41d4-a716-446655440002', '880e8400-e29b-41d4-a716-446655440002', 360.00, '2025-06-22 16:30:00', 'stripe');

-- Insert reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at) VALUES
  ('aa0e8400-e29b-41d4-a716-446655440000', '770e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440000', 4, 'Great stay, very cozy!', '2025-07-13 09:00:00'),
  ('aa0e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 5, 'Amazing view and location!', '2025-07-23 10:00:00');

-- Insert messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
  ('bb0e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440003', 'Is the San Francisco loft available for July 10-12?', '2025-06-19 10:00:00'),
  ('bb0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440000', 'Yes, it’s available! Please confirm your booking.', '2025-06-19 11:00:00');