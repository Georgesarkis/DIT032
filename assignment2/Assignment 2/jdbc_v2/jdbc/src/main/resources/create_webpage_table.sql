CREATE TABLE webpage (url VARCHAR PRIMARY KEY, author VARCHAR , content VARCHAR , popularity integer, FOREIGN KEY (author) REFERENCES "user" (Ssn));