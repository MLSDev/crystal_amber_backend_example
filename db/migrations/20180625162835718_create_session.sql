-- +micrate Up
CREATE TABLE sessions (
  id         BIGSERIAL PRIMARY KEY,
  token      VARCHAR(255),
  user_id    BIGSERIAL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX sessions_user_id ON sessions(user_id);

ALTER TABLE sessions ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id);

-- +micrate Down
DROP TABLE IF EXISTS sessions;
