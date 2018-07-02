-- +micrate Up
CREATE TABLE users (
  id              BIGSERIAL PRIMARY KEY,
  email           VARCHAR(255),
  password_digest VARCHAR(255),
  created_at      TIMESTAMP,
  updated_at      TIMESTAMP
);

CREATE INDEX users_email_index ON users (email);

CREATE UNIQUE INDEX lower_users_email ON users(LOWER(email));

-- +micrate Down
DROP TABLE IF EXISTS users;

DROP INDEX users_email_index;

DROP INDEX lower_users_email;
