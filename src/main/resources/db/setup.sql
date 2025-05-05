-- Drop tables if they exist (be careful with this in production!)
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create categories table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Create items table
CREATE TABLE items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category_id INT NOT NULL,
    image_url VARCHAR(255),
    location VARCHAR(255) NOT NULL,
    post_type VARCHAR(10) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    rejection_reason TEXT,
    user_id INT NOT NULL,
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert a test user
INSERT INTO users (username, password, email, full_name, phone_number) 
VALUES ('testuser', 'password123', 'test@example.com', 'Test User', '1234567890');

-- Insert default categories
INSERT INTO categories (name, description) VALUES
('Electronics', 'Electronic devices and gadgets'),
('Documents', 'Important papers and documents'),
('Jewelry', 'Precious metals and stones'),
('Clothing', 'Apparel and accessories'),
('Books', 'Books and reading materials'),
('Other', 'Other miscellaneous items'); 