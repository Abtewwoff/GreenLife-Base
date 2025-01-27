

INSERT INTO `jobs` (`name`, `label`) VALUES
('jardinier', 'Jardinier'),
('chantier', 'Chantier'),
('mineur', 'Mineur');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(null,'jardinier', 0, 'recrue', 'Jardinier', 400, 'null', 'null');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(null,'chantier', 0, 'recrue', 'Chantier', 400, 'null', 'null');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(null,'mineur', 0, 'recrue', 'Mineur', 400, 'null', 'null');
