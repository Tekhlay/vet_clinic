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
