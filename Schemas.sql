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