/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	NAME TEXT, DATE_OF_BIRTH DATE,
	ESCAPE_ATTEMPTS INTEGER,
	NEUTERED BOOLEAN,
	WEIGHT_KG DECIMAL
);

ALTER TABLE animals ADD COLUMN species TEXT;

/* Add two tables: owners and species */

CREATE TABLE owners (
	ID INTEGER SERIAL,
	FULL_NAME TEXT,
	AGE INTEGER,
	PRIMARY KEY(ID)
);

CREATE TABLE species (
	ID SERIAL,
	NAME TEXT,
	PRIMARY KEY(ID)
);

/* Alter animals table by deleting the species column, adding the species_id and owner_id foreign keys */

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INTEGER;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(ID);
ALTER TABLE animals ADD COLUMN owner_id INTEGER;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(ID);

/* Add vets table */

CREATE TABLE vets (
	ID SERIAL,
	NAME TEXT,
	AGE INTEGER,
	DATE_OF_GRADUATION DATE,
	PRIMARY KEY(ID)
);

CREATE TABLE specializations (
	VET_ID INTEGER,
	SPECIES_ID INTEGER,
);

