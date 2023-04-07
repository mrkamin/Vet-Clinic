/* Database schema to keep the structure of entire database. */
-- Table: public.animals

-- DROP TABLE IF EXISTS public.animals;

CREATE TABLE IF NOT EXISTS public.animals
(
    id integer NOT NULL,
    name character varying(80) COLLATE pg_catalog."default",
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg numeric,
    CONSTRAINT animals_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.animals
    OWNER to postgres;

/* Vet clinic database: query and update animals table */

    ALTER TABLE animals ADD COLUMN species VARCHAR(100);

/* Vet clinic database: query multiple tables */
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);


BEGIN;

ALTER TABLE animals 
  DROP COLUMN species;

ALTER TABLE animals
  ADD COLUMN species_id INT REFERENCES species(id),
  ADD COLUMN owner_id INT REFERENCES owners(id);

COMMIT;

/* Vet clinic database: add "join table" for visits */


CREATE TABLE vets (
    id INTEGER SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE
);


CREATE TABLE specializations (
    vet_id INT NOT NULL REFERENCES vets(id),
    species_id INT NOT NULL REFERENCES species(id),
    PRIMARY KEY(vet_id,species_id)
);


CREATE TABLE visits (
  animal_id INT NOT NULL,
  vet_id INT NOT NULL,
  visit_dates Date NOT NULL,
  CONSTRAINT primary_pk
  PRIMARY KEY (animal_id, vet_id, visit_dates),
  FOREIGN KEY (animal_id) REFERENCES animals (id),
  FOREIGN KEY (vet_id) REFERENCES vets (id)
);