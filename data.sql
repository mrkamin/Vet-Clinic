/* Populate database with sample data. */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Agumon', DATE '2020-02-03', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Gabumon', DATE '2018-11-15', 2, true, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11, 'Pikachu', DATE '2021-01-07', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (12, 'Devimon', DATE '2017-05-12', 5, true, 11);


/* Vet clinic database: query and update animals table */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
 (13, 'Charmander', DATE '2020-02-08', -11, false, 0),
 (14, 'Plantomon', DATE '2021-11-15', -5.7, true, 2),
 (15, 'Squirtle', DATE '1993-04-02', -12.13, false, 3)
 (16, 'Angemon', DATE '2005-06-12', -45, true, 1)
 (17, 'Blossom', DATE '2005-06-07', 20.4, true, 7),
 (18, 'Boarmon', DATE '2005-06-07', 20.4, true, 7),
 (19, 'Ditto', DATE '2022-05-14', 22, true, 4);

/* Vet clinic database: query multiple tables */
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

INSERT INTO species (name) 
VALUES 
('Pokemon'),('Digimon');

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

/* Vet clinic database: add "join table" for visits */
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, DATE '2000-04-23'),
('Maisy Smith', 26, DATE '2019-01-17'),
('Stephanie Mendez', 64, DATE '1981-05-04'),
('Jack Harkness', 38, DATE '2008-06-08');

INSERT INTO specializations(vet_id, species_id) 
VALUES
(1,1),
(3,2),
(3,1),
(4,2);

INSERT INTO visits(animal_id, vet_id, visit_dates)
VALUES
(1,1, DATE '2020-05-24'),
(1,3, DATE '2020-07-22'),
(2,4, DATE '2021-02-02'),
(3,2, DATE '2020-01-05'),
(3,2, DATE '05-14-2020'),
(3,2, DATE '03-08-2020'),
(4,3, DATE '05-04-2021'),
(5,4, DATE '02-24-2021'),
(6,2, DATE '12-21-2019'),
(6,1, DATE '08-10-2020'),
(6,2, DATE '04-07-2021'),
(7,3, DATE '09-29-2019'),
(8,4, DATE '10-03-2020'),
(8,4, DATE '11-04-2020'),
(9,2, DATE '01-24-2019'),
(9,2, DATE '05-15-2019'),
(9,2, DATE '02-27-2020'),
(9,2, DATE '08-03-2020'),
(10,3, DATE '05-24-2020'),
(10,1, DATE '01-11-2021');
