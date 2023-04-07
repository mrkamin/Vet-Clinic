SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE date_of_birth >= DATE '2016-01-01' AND date_of_birth <= DATE '2019-12-31';
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Vet clinic database: query and update animals table */
BEGIN TRANSACTION;
UPDATE animals 
SET species = 'digimon' 
WHERE name LIKE '%mon';
UPDATE animals 
SET species = 'pokemon' 
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK TRANSACTION;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > DATE '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT TRANSACTION;
SELECT * FROM animals;


SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, COUNT(*) AS NumOfanimals, AVG(escape_attempts) AS Avgescape_attempts 
FROM animals 
GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) 
FROM animals 
GROUP BY species;

SELECT species, AVG(escape_attempts) 
FROM animals 
WHERE date_of_birth BETWEEN DATE '1990-01-01' AND DATE '2000-12-31' 
GROUP BY species;


/* Vet clinic database: query multiple tables */


SELECT name FROM animals
INNER JOIN owners on owners.id = owner_id
WHERE full_name = 'Melody Pond';


SELECT * FROM animals 
LEFT JOIN species s ON species_id = s.id
WHERE s.name = 'Pokemon';


SELECT full_name AS owner, name AS pet FROM animals a
FULL JOIN owners o ON o.id = a.owner_id;


SELECT COUNT(a.name), s.name FROM animals a
FULL JOIN species s ON species_id = s.id
GROUP BY s.name;


SELECT a.name FROM animals a 
LEFT JOIN owners o ON o.id = a.owner_id
LEFT JOIN species s ON s.id = a.species_id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';


SELECT * FROM animals a
FULL JOIN owners o ON o.id = owner_id
WHERE o.full_name = 'Dean Winchester' AND escape_attempts = 0;


SELECT owner FROM (
  SELECT COUNT(a.name) as count, full_name as owner FROM animals a
  JOIN owners o ON o.id = owner_id
  GROUP BY owner
) AS animals_per_owner
WHERE count = (SELECT MAX(count) FROM (
  SELECT COUNT(a.name) as count, full_name as owner FROM animals a
  JOIN owners o ON o.id = owner_id
  GROUP BY owner
) AS animals_per_owner);


/* Vet clinic database: add "join table" for visits */

SELECT a.name FROM animals a
WHERE a.id = ( SELECT animal_id FROM visits
  LEFT JOIN vets ON visits.vet_id = vets.id
  WHERE vets.name = 'William Tatcher' 
  GROUP BY animal_id
  ORDER BY MAX(visit_dates) DESC LIMIT 1
);

SELECT COUNT(*) FROM visits
WHERE vet_id = (
  SELECT id FROM vets WHERE name = 'Stephanie Mendez'
);


SELECT *
FROM vets v
LEFT JOIN specializations vs ON v.id = vs.vet_id;

SELECT * FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = vet_id
WHERE vets.name = 'Stephanie Mendez' AND visit_dates BETWEEN '20200401' AND '20200901';


SELECT name FROM (
  SELECT COUNT(visit_dates) AS count, animals.name as name FROM animals
  LEFT JOIN visits ON animals.id = animal_id
  GROUP BY animals.name
) as tt1
GROUP BY name
ORDER BY MAX(count) DESC LIMIT 1;

SELECT name FROM animals 
Where id = (SELECT animal_id FROM visits
LEFT JOIN vets ON vets.id = vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visit_dates LIMIT 1);


SELECT * FROM animals
LEFT JOIN visits ON animal_id = animals.id
FULL JOIN vets on vets.id = visits.vet_id
ORDER BY visit_dates DESC LIMIT 1;


SELECT vets.name AS "Vet", COUNT(*) FROM visits 
LEFT JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON vets.id = specializations.vet_id 
LEFT JOIN species ON specializations.species_id = species.id 
WHERE specializations.species_id IS NULL 
OR specializations.species_id != species.id 
GROUP BY vets.name;


SELECT vets.name AS "Vet", species.name AS "Specie", COUNT(*) FROM visits 
LEFT JOIN vets ON visits.vet_id = vets.id
LEFT JOIN animals ON visits.animal_id = animals.id 
LEFT JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith' 
GROUP BY vets.name, species.name LIMIT 1;
