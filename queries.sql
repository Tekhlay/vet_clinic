/Queries that provide answers to the questions from all projects.*/

SELECT * FROM `animals` WHERE name LIKE '%mon%';
SELECT name FROM `animals` WHERE date_of_birth BETWEEN '2016-01-01' and '2019-01-01';
SELECT name FROM `animals` WHERE neutered=1 AND escape_attempts<3;
SELECT date_of_birth FROM `animals` WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM `animals` WHERE neutered = 1;
SELECT * FROM `animals` WHERE name != 'Gabumon';
SELECT * FROM `animals` WHERE weight_kg>=10.4 OR weight_kg<=17.3 AND weight_kg BETWEEN 10.4 AND 17.3;

Update animals SET species = "unspecified";
ROLLBACK;
Update animals SET species = "digimon" where name LIKE "%mon%";
 Update animals SET species = "pokemon" where name NOT LIKE "%mon%";
 delete from animals;
 ROLLBACK;
delete from animals where date_of_birth > '2022-01-01';
SAVEPOINT del;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO del;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT count(name) from animals;
SELECT count(name) from animals where escape_attempts = 0;
SELECT avg(weight_kg) from animals;
SELECT neutered, SUM(escape_attempts) from animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;
SELECT species, AVG(escape_attempts) from animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;

SELECT name, full_name from animals JOIN owners ON animals.owner_id = owners.id WHERE animals.owner_id =4;
SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = "Pokemon";
SELECT * FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;
SELECT species.name, Count(animals.name) from animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT animals.name as animal_name, owners.full_name, species.name as speicetype from animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.species_id = animals.owner_id WHERE owners.full_name = "Jennifer Orwell" AND species.name ="Digimon";
SELECT * from animals JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts =0 AND full_name = "Dean Winchester";
SELECT full_name, count(name) from owners JOIN animals ON animals.owner_id = owners.id GROUP BY full_name;