/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*Queries that set all the species row to 'unspecified' and then rollback */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*Queries that set all the species with name ending with 'mon' to 'digimon' and the unassigned to 'pokemon' */

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET species = 'pokemon' WHERE NOT name LIKE '%mon';
SELECT * FROM animals;
COMMIT;

/*Queries that delete the entire record in a transition and then rollback */

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*Queries that inverts all weight by -1, rollback to savepoint then inverts by -1 only weights inferior to zero */

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SP1;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*Queries that answer analytical questions */

SELECT COUNT(*) FROM animals;
SELECT COUNT(ESCAPE_ATTEMPTS) FROM animals GROUP BY ESCAPE_ATTEMPTS HAVING ESCAPE_ATTEMPTS = 0;
SELECT AVG(WEIGHT_KG) FROM animals;
SELECT NEUTERED, AVG(ESCAPE_ATTEMPTS) FROM animals GROUP BY NEUTERED;
SELECT SPECIES, MIN(WEIGHT_KG), MAX(WEIGHT_KG) FROM animals GROUP BY SPECIES;
SELECT DATE_OF_BIRTH, AVG(ESCAPE_ATTEMPTS) FROM animals GROUP BY DATE_OF_BIRTH HAVING DATE_OF_BIRTH BETWEEN '1990-01-01' AND '2000-01-01';

/*Queries that answer analytical questions  using the join operation*/
SELECT owners.full_name, animals.name 
FROM animals 
JOIN owners 
	ON animals.owner_id = owners.id 
	WHERE owners.full_name = 'Melody Pond';
SELECT animals.name 
FROM animals 
JOIN species 
	ON animals.species_id = species.id 
	WHERE species.name = 'Pokemon';
SELECT owners.full_name as owner, animals.name as animal 
FROM owners 
FULL JOIN animals 
	ON owners.id = animals.owner_id;
SELECT species.name as species, count(animals) as number 
FROM species 
JOIN animals 
	ON species.id = animals.species_id 
GROUP BY (species.name);
SELECT owners.full_name as owner, animals.name as animals
FROM animals 
JOIN owners 
	ON animals.owner_id = owners.id 
	WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = 2;
SELECT owners.full_name as owner, animals.name as animals 
FROM animals 
JOIN owners 
	ON animals.owner_id = owners.id 
	WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name 
FROM animals 
JOIN owners 
	ON animals.owner_id = owners.id 
GROUP BY (owners.full_name) 
ORDER BY COUNT(*) DESC 
LIMIT 1;





