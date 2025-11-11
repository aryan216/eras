/*
  # Holiday Home Rental Platform Database Schema

  ## Overview
  Complete database schema for a holiday home rental platform with properties, bookings, reviews, and user favorites.

  ## New Tables

  ### `properties`
  - `id` (uuid, primary key) - Unique property identifier
  - `title` (text) - Property title/name
  - `description` (text) - Detailed property description
  - `location` (text) - Full address/location
  - `city` (text) - City name for filtering
  - `country` (text) - Country name
  - `latitude` (numeric) - GPS latitude
  - `longitude` (numeric) - GPS longitude
  - `price_per_night` (numeric) - Nightly rate
  - `bedrooms` (integer) - Number of bedrooms
  - `bathrooms` (integer) - Number of bathrooms
  - `max_guests` (integer) - Maximum guest capacity
  - `property_type` (text) - Type: villa, apartment, cottage, etc.
  - `images` (jsonb) - Array of image URLs
  - `amenities` (jsonb) - Array of amenity names
  - `rating` (numeric) - Average rating (0-5)
  - `review_count` (integer) - Total number of reviews
  - `host_id` (uuid) - Reference to property owner
  - `featured` (boolean) - Featured property flag
  - `available` (boolean) - Availability status
  - `created_at` (timestamptz) - Creation timestamp
  - `updated_at` (timestamptz) - Last update timestamp

  ### `bookings`
  - `id` (uuid, primary key) - Unique booking identifier
  - `property_id` (uuid) - Reference to property
  - `user_id` (uuid) - Reference to user
  - `check_in` (date) - Check-in date
  - `check_out` (date) - Check-out date
  - `guests` (integer) - Number of guests
  - `total_price` (numeric) - Total booking cost
  - `status` (text) - confirmed, pending, cancelled
  - `confirmation_code` (text) - Unique confirmation code
  - `created_at` (timestamptz) - Booking creation time

  ### `reviews`
  - `id` (uuid, primary key) - Unique review identifier
  - `property_id` (uuid) - Reference to property
  - `user_id` (uuid) - Reference to reviewer
  - `rating` (integer) - Rating 1-5
  - `comment` (text) - Review text
  - `cleanliness` (integer) - Cleanliness rating
  - `communication` (integer) - Communication rating
  - `checkin` (integer) - Check-in rating
  - `accuracy` (integer) - Accuracy rating
  - `location` (integer) - Location rating
  - `value` (integer) - Value rating
  - `created_at` (timestamptz) - Review date

  ### `favorites`
  - `id` (uuid, primary key) - Unique favorite identifier
  - `user_id` (uuid) - Reference to user
  - `property_id` (uuid) - Reference to property
  - `created_at` (timestamptz) - When favorited

  ### `user_profiles`
  - `id` (uuid, primary key) - References auth.users
  - `full_name` (text) - User's full name
  - `avatar_url` (text) - Profile picture URL
  - `bio` (text) - User biography
  - `phone` (text) - Phone number
  - `created_at` (timestamptz) - Profile creation time
  - `updated_at` (timestamptz) - Last profile update

  ## Security
  - Enable RLS on all tables
  - Policies for authenticated users to manage their own data
  - Public read access for properties and reviews
  - Restricted write access based on ownership
*/

-- Create properties table
CREATE TABLE IF NOT EXISTS properties (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL,
  location text NOT NULL,
  city text NOT NULL,
  country text NOT NULL,
  latitude numeric,
  longitude numeric,
  price_per_night numeric NOT NULL,
  bedrooms integer NOT NULL DEFAULT 1,
  bathrooms integer NOT NULL DEFAULT 1,
  max_guests integer NOT NULL DEFAULT 2,
  property_type text NOT NULL,
  images jsonb DEFAULT '[]'::jsonb,
  amenities jsonb DEFAULT '[]'::jsonb,
  rating numeric DEFAULT 0,
  review_count integer DEFAULT 0,
  host_id uuid,
  featured boolean DEFAULT false,
  available boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create bookings table
CREATE TABLE IF NOT EXISTS bookings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id uuid NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
  user_id uuid NOT NULL,
  check_in date NOT NULL,
  check_out date NOT NULL,
  guests integer NOT NULL,
  total_price numeric NOT NULL,
  status text DEFAULT 'pending',
  confirmation_code text NOT NULL UNIQUE,
  created_at timestamptz DEFAULT now()
);

-- Create reviews table
CREATE TABLE IF NOT EXISTS reviews (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id uuid NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
  user_id uuid NOT NULL,
  rating integer NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment text,
  cleanliness integer CHECK (cleanliness >= 1 AND cleanliness <= 5),
  communication integer CHECK (communication >= 1 AND communication <= 5),
  checkin integer CHECK (checkin >= 1 AND checkin <= 5),
  accuracy integer CHECK (accuracy >= 1 AND accuracy <= 5),
  location integer CHECK (location >= 1 AND location <= 5),
  value integer CHECK (value >= 1 AND value <= 5),
  created_at timestamptz DEFAULT now()
);

-- Create favorites table
CREATE TABLE IF NOT EXISTS favorites (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  property_id uuid NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, property_id)
);

-- Create user_profiles table
CREATE TABLE IF NOT EXISTS user_profiles (
  id uuid PRIMARY KEY,
  full_name text,
  avatar_url text,
  bio text,
  phone text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE properties ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- Properties policies (public read, authenticated write)
CREATE POLICY "Properties are viewable by everyone"
  ON properties FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can create properties"
  ON properties FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Users can update their own properties"
  ON properties FOR UPDATE
  TO authenticated
  USING (auth.uid() = host_id)
  WITH CHECK (auth.uid() = host_id);

-- Bookings policies
CREATE POLICY "Users can view their own bookings"
  ON bookings FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create bookings"
  ON bookings FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own bookings"
  ON bookings FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Reviews policies (public read, authenticated write)
CREATE POLICY "Reviews are viewable by everyone"
  ON reviews FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can create reviews"
  ON reviews FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own reviews"
  ON reviews FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own reviews"
  ON reviews FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Favorites policies
CREATE POLICY "Users can view their own favorites"
  ON favorites FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can add favorites"
  ON favorites FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can remove favorites"
  ON favorites FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- User profiles policies
CREATE POLICY "Users can view all profiles"
  ON user_profiles FOR SELECT
  USING (true);

CREATE POLICY "Users can create their own profile"
  ON user_profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_properties_city ON properties(city);
CREATE INDEX IF NOT EXISTS idx_properties_country ON properties(country);
CREATE INDEX IF NOT EXISTS idx_properties_price ON properties(price_per_night);
CREATE INDEX IF NOT EXISTS idx_properties_featured ON properties(featured);
CREATE INDEX IF NOT EXISTS idx_bookings_user ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_reviews_property ON reviews(property_id);
CREATE INDEX IF NOT EXISTS idx_favorites_user ON favorites(user_id);
