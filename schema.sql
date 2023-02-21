/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

USE vet_clinic;

CREATE TABLE animals (
    id int(10),
    name varchar(255),
    date_of_birth date,
    escape_attempts int(20),
    neutered boolean,
    weight_kg decimal(10,2)  
);

ALTER TABLE animals ADD species varchar(255) AFTER weight_kg; 

CREATE TABLE owners (id int PRIMARY KEY AUTO_INCREMENT, full_name varchar(255), age int);
CREATE TABLE species (id int PRIMARY KEY AUTO_INCREMENT, name varchar(255));
ALTER TABLE animals MODIFY id int PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id int, ADD CONSTRAINT FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD owner_id int, ADD FOREIGN KEY(owner_id) REFERENCES owners(id);
