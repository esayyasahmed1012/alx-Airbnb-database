CREATE TYPE role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method AS ENUM ('credit_card', 'paypal', 'stripe');



CREATE TABLE if not exists users (
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


CREATE TABLE IF NOT EXISTS "locations" (
  "location_id" uuid PRIMARY KEY,
  "country" varchar NOT NULL,
  "state" varchar,
  "city" varchar,
  "postal_code" varchar,
  "latitude" decimal NOT NULL,
  "longitude" decimal NOT NULL
);

CREATE TABLE  if not exists properties(
  property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  host_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location gen_random_uuid() ,
  pricepernight DECIMAL NOT NULL CHECK (pricepernight > 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT valid_name CHECK (name <> ''),
  CONSTRAINT valid_description CHECK (description <> '')
);

CREATE TABLE if not exists bookings (
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

CREATE TABLE if not exits payments (
  payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id UUID NOT NULL UNIQUE REFERENCES bookings(booking_id) ON DELETE CASCADE,
  amount DECIMAL NOT NULL CHECK (amount > 0),
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method payment_method NOT NULL
);

CREATE TABLE if exits reviews (
  review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id UUID NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT valid_comment CHECK (comment <> '')
);

CREATE TABLE if not exits messages (
  message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sender_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  recipient_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT valid_message_body CHECK (message_body <> '')
);