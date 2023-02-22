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
-- Who was the last animal seen by William Tatcher?
SELECT animals.name as animal_name, vets.name as vets_name, visit_date from vets JOIN visits ON vets.id = visits.vets_id JOIN animals ON animals.id = visits.animal_id WHERE vets.name = "William Tatcher" ORDER BY visit_date DESC;
-- How many different animals did Stephanie Mendez see?
SELECT count(*) as Number_of_visited_animals from vets JOIN visits ON vets.id = visits.vets_id WHERE vets.name = "Stephanie Mendez";
--List all vets and their specialties, including vets with no specialties.
 SELECT vets.name, species.name as specialization_type from vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON species.id = specializations.species_id;
--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
 SELECT animals.name, vets.name as visitor_name from animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = "Stephanie Mendez" AND visit_date BETWEEN "2020-04-01" AND "2020-08-30";
 --What animal has the most visits to vets?
 SELECT animals.name, count(*) as most_visited from animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY most_visited DESC LIMIT 1;
 --Who was Maisy Smith's first visit?
 SELECT animals.name, vets.name as visitor_name, visit_date from animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = "Maisy Smith" ORDER BY visit_date ASC LIMIT 1;
--Details for most recent visit: animal information, vet information, and date of visit.
 SELECT * FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id ORDER BY visit_date LIMIT 1;
--How many visits were with a vet that did not specialize in that animal's species?
> SELECT count(*) FROM visits JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id JOIN specializations ON specializations.vets_id = visits.vets_id WHERE animals.species_id != specializations.species_id;
--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name as species, COUNT(*) from visits
join vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name;