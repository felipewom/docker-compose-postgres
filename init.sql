-- create a table
CREATE TABLE test(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name TEXT NOT NULL,
  archived BOOLEAN NOT NULL DEFAULT FALSE
);

-- add test data
INSERT INTO test (name, archived)
  VALUES ('test row 1', true),
  ('test row 2', false);
