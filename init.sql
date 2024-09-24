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

-- db2rest test
CREATE TABLE employee (
    id serial4 NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email varchar(255) NOT NULL,
    created_on timestamp NOT NULL,
    CONSTRAINT employee_email_key UNIQUE (email),
    CONSTRAINT employee_pkey PRIMARY KEY (id)
);