/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	NAME TEXT, DATE_OF_BIRTH DATE,
	ESCAPE_ATTEMPTS INTEGER,
	NEUTERED BOOLEAN,
	WEIGHT_KG DECIMAL
);

ALTER TABLE animals ADD COLUMN species TEXT;

CREATE TABLE owners (
	ID INTEGER SERIAL,
	FULL_NAME TEXT,
	AGE INTEGER,
	PRIMARY KEY(ID)
);

CREATE TABLE species (
	ID INTEGER SERIAL,
	NAME TEXT,
	PRIMARY KEY(ID)
);

