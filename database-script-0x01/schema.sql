CREATE TYPE role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method AS ENUM ('credit_card', 'paypal', 'stripe');

-- Users table: Stores user information
CREATE TABLE IF NOT EXISTS users (
  user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  email VARCHAR NOT NULL UNIQUE,
  password_hash VARCHAR NOT NULL,
  phone_number VARCHAR,
  role role NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT valid_email CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);
COMMENT ON TABLE users IS 'Stores user data for authentication and authorization';

-- Locations table: Stores geographical information
CREATE TABLE IF NOT EXISTS "locations" (
  "location_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Added DEFAULT
  "country" VARCHAR NOT NULL,
  "state" VARCHAR,
  "city" VARCHAR,
  "postal_code" VARCHAR,
  "latitude" DECIMAL NOT NULL,
  "longitude" DECIMAL NOT NULL
);
COMMENT ON TABLE "locations" IS 'Stores geographical details for property locations';

-- Properties table: Stores property details
CREATE TABLE IF NOT EXISTS properties (
  property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  host_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location_id UUID NOT NULL REFERENCES "locations"("location_id") ON DELETE CASCADE, -- Consistent quoting
  pricepernight DECIMAL NOT NULL CHECK (pricepernight > 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT valid_name CHECK (name <> ''),
  CONSTRAINT valid_description CHECK (description <> '')
);
COMMENT ON TABLE properties IS 'Stores details of properties listed for booking';
COMMENT ON COLUMN properties.updated_at IS 'On Update set now()';

-- Trigger to update properties.updated_at
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_properties_timestamp
BEFORE UPDATE ON properties
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Bookings table: Stores booking details
CREATE TABLE IF NOT EXISTS bookings (
  booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id UUID NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL CHECK (total_price >= 0),
  status booking_status NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT valid_dates CHECK (start_date < end_date)
);
COMMENT ON TABLE bookings IS 'Stores booking details linking users and properties';

-- Payments table: Stores payment details
CREATE TABLE IF NOT EXISTS payments (
  payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id UUID NOT NULL UNIQUE REFERENCES bookings(booking_id) ON DELETE CASCADE,
  amount DECIMAL NOT NULL CHECK (amount > 0),
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method payment_method NOT NULL
);
COMMENT ON TABLE payments IS 'Stores payment details for bookings';

-- Reviews table: Stores property reviews
CREATE TABLE IF NOT EXISTS reviews (
  review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id UUID NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT valid_comment CHECK (comment <> '')
);
COMMENT ON TABLE reviews IS 'Stores user reviews and ratings for properties';
COMMENT ON COLUMN reviews.rating IS 'Value between 1 and 5';

-- Messages table: Stores user messages
CREATE TABLE IF NOT EXISTS messages (
  message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sender_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  recipient_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT valid_message_body CHECK (message_body <> '')
);
COMMENT ON TABLE messages IS 'Stores messages between users';

-- Indexes 
CREATE INDEX IF NOT EXISTS "idx_user_email" ON "users" ("email");
CREATE INDEX IF NOT EXISTS "idx_property_location" ON "properties" ("location_id"); -- Fixed column name
CREATE INDEX IF NOT EXISTS "idx_property_host" ON "properties" ("host_id");
CREATE INDEX IF NOT EXISTS "idx_booking_guest" ON "bookings" ("user_id");
CREATE INDEX IF NOT EXISTS "idx_booking_property" ON "bookings" ("property_id");
CREATE INDEX IF NOT EXISTS "idx_payment_booking" ON "payments" ("booking_id");