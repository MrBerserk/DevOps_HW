CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

INSERT INTO users (name, email) VALUES ('Katy Paper', 'katy@example.com');
INSERT INTO users (name, email) VALUES ('John Smit', 'john@example.com');