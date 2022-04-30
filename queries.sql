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

/* Queries for many to many relationships */
SELECT animals.name
FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visitation_date DESC
LIMIT 1;

SELECT COUNT(animals.name)
FROM visits
JOIN animals ON visits.animals_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT ve.name AS vet_name, species.name AS Speciality
FROM vets ve
LEFT JOIN specializations spec
ON ve.id = spec.vet_id
LEFT JOIN species
ON spec.species_id = species.id;

SELECT a.name, vi.visitation_date, ve.name
FROM animals a
JOIN visits vi ON vi.animals_id = a.id
JOIN vets ve ON vi.vet_id = ve.id
WHERE
	ve.name = 'Stephanie Mendez'
  AND
  vi.visitation_date
  BETWEEN '2020-04-01' AND '2020-08-30';
  
SELECT a.name AS name, COUNT(a.name) AS most_viewed
FROM animals a
JOIN visits vi ON vi.animals_id = a.id 
JOIN vets ve ON vi.vet_id = ve.id
GROUP BY a.name
ORDER BY most_viewed DESC
LIMIT 1;

SELECT ve.name AS vet_name, a.name AS animal_name, visitation_date
FROM visits vi
JOIN vets ve ON vi.vet_id = ve.id
JOIN animals a ON vi.animals_id = a.id
WHERE ve.name = 'Maisy Smith'
ORDER BY visitation_date
LIMIT 1;

SELECT
  a.name AS animal_name,
  a.date_of_birth,
  a.escape_attempts,
  a.neutered,
  a.weight_kg,
  s.name AS species_name,
  ve.name AS vet_name,
  ve.age AS vet_age,
  ve.date_of_graduation,
  visitation_date
FROM visits vi
JOIN animals a ON vi.animals_id = a.id
JOIN species s ON a.species_id = s.id
JOIN vets ve ON vi.vet_id = ve.id
ORDER BY visitation_date DESC
LIMIT 1;

SELECT species.name AS animal_name, COUNT(species.name)
FROM visits vi
JOIN animals a ON vi.animals_id = a.id
JOIN species ON a.species_id = species.id
JOIN vets ON vi.vet_id = vets.id
WHERE vet_id = 2
GROUP BY(species.name)
LIMIT 1;

SELECT species.name AS species_name
FROM species
JOIN visits ON visits.vet_id = species.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY(species.name);

