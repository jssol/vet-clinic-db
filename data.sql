/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth,escape_attempts, neutered) VALUES ('Agumon', '2020-02-03', 0, TRUE);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, TRUE, 11);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, FALSE, -11);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-07-12', 1, TRUE, -45);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals (name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, TRUE, 22);

/* Insert owners into the owners table */
INSERT INTO owners (full_name, age) 
VALUES ('Sam Smith', 34),
	   ('Jennifer Orwell', 19),
	   ('Bob', 45),
	   ('Melody Pond', 77),
	   ('Dean Winchester', 14),
	   ('Jodie Whittaker', 38);
	   
/* Insert owners into the owners table */
INSERT INTO species (name) 
VALUES ('Pokemon'),
			 ('Digimon');
	   
/* Modify inserted animals so it includes the species_id value */
UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Digimon') 
WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') 
WHERE NOT name LIKE '%mon';

/* Modify inserted animals so it includes the owner_id value */
UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') 
WHERE name = 'Agumon';
SELECT * FROM animals;
UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') 
WHERE name IN ('Gabumon', 'Pikachu');
SELECT * FROM animals;
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
SELECT * FROM animals;
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
SELECT * FROM animals;
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
SELECT * FROM animals;

/* Insert vets into the vets table */
INSERT INTO vets (name, age,  date_of_graduation) 
VALUES ('William Tatcher', 45, '2000-04-23'),
			 ('Maisy Smith', 26, '2019-01-17'),
			 ('Stephanie Mendez', 64, '1981-05-04'),
			 ('Jack Harkness', 38, '2008-06-08');
	   

