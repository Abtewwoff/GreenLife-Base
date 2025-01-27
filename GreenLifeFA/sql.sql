-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 27 jan. 2025 à 21:22
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `canadien`
--

-- --------------------------------------------------------

--
-- Structure de la table `account_info`
--

CREATE TABLE `account_info` (
  `account_id` int(11) NOT NULL,
  `license` varchar(50) NOT NULL,
  `steam` varchar(22) DEFAULT NULL,
  `xbl` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `live` varchar(50) DEFAULT NULL,
  `fivem` varchar(50) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `guid` varchar(20) DEFAULT NULL,
  `first_connection` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `baninfo`
--

CREATE TABLE `baninfo` (
  `id` int(11) NOT NULL,
  `license` varchar(50) DEFAULT NULL,
  `identifier` varchar(25) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `playername` longtext DEFAULT NULL,
  `Token` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `banlist`
--

CREATE TABLE `banlist` (
  `license` varchar(50) NOT NULL,
  `ban_id` varchar(255) DEFAULT NULL,
  `identifier` varchar(25) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `targetplayername` varchar(32) DEFAULT NULL,
  `sourceplayername` varchar(32) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` varchar(50) NOT NULL,
  `expiration` varchar(50) NOT NULL,
  `permanent` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `banlisthistory`
--

CREATE TABLE `banlisthistory` (
  `id` int(11) NOT NULL,
  `ban_id` varchar(255) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `identifier` varchar(25) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `targetplayername` varchar(32) DEFAULT NULL,
  `sourceplayername` varchar(32) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` int(11) NOT NULL,
  `added` varchar(40) NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `boutique`
--

CREATE TABLE `boutique` (
  `license` varchar(255) DEFAULT NULL,
  `fivem` varchar(255) DEFAULT NULL,
  `vip` varchar(255) DEFAULT NULL,
  `calendrier_noel` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `cardealer_vehicles`
--

CREATE TABLE `cardealer_vehicles` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT '',
  `price` int(11) NOT NULL,
  `society` varchar(50) NOT NULL DEFAULT 'carshop'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `casier`
--

CREATE TABLE `casier` (
  `identifier` varchar(255) DEFAULT '''''',
  `Prenom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `Nom` varchar(50) DEFAULT '',
  `naissance` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `raison` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `auteur` varchar(50) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `casino_cache`
--

CREATE TABLE `casino_cache` (
  `ID` int(11) NOT NULL,
  `Settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_slovak_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `casino_cache`
--

INSERT INTO `casino_cache` (`ID`, `Settings`) VALUES
(1, '{\"PodiumPriceProps\":\"\"}');

-- --------------------------------------------------------

--
-- Structure de la table `casino_players`
--

CREATE TABLE `casino_players` (
  `ID` int(11) NOT NULL,
  `identifier` varchar(128) NOT NULL,
  `properties` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `chestbuilder`
--

CREATE TABLE `chestbuilder` (
  `id` int(11) NOT NULL,
  `pos` longtext DEFAULT NULL,
  `job` varchar(50) NOT NULL DEFAULT '0',
  `items` longtext NOT NULL,
  `maxWeight` int(11) NOT NULL DEFAULT 0,
  `accesbmoney` bit(1) NOT NULL DEFAULT b'0',
  `money` int(11) NOT NULL DEFAULT 0,
  `bmoney` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `clothes_data`
--

CREATE TABLE `clothes_data` (
  `id` int(11) NOT NULL,
  `identifier` longtext NOT NULL,
  `name` longtext NOT NULL,
  `data` longtext DEFAULT NULL,
  `type` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `drugss`
--

CREATE TABLE `drugss` (
  `id` int(11) NOT NULL,
  `createdBy` text NOT NULL,
  `createdAt` text NOT NULL,
  `label` varchar(50) NOT NULL,
  `drugsInfos` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `gangbuilder`
--

CREATE TABLE `gangbuilder` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `posGarage` varchar(255) DEFAULT NULL,
  `posSpawnVeh` varchar(255) DEFAULT NULL,
  `posDeleteVeh` varchar(255) DEFAULT NULL,
  `posCoffre` varchar(255) DEFAULT NULL,
  `posBoss` varchar(255) DEFAULT NULL,
  `vehicules` longtext DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `grades` longtext DEFAULT NULL,
  `membres` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `gunfight_stats`
--

CREATE TABLE `gunfight_stats` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `kills` int(11) NOT NULL,
  `deaths` int(11) NOT NULL,
  `ratio` float NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gym_memberships`
--

CREATE TABLE `gym_memberships` (
  `owner` varchar(70) DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `hottubs`
--

CREATE TABLE `hottubs` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `coords` varchar(255) NOT NULL,
  `rotation` varchar(255) NOT NULL,
  `stairs` tinyint(1) NOT NULL DEFAULT 0,
  `type` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` float NOT NULL DEFAULT 1,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(255) DEFAULT NULL,
  `unique` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `can_remove`, `type`, `unique`) VALUES
('bandage', 'Bandage', 0.5, 1, 'item', 0),
('basic_cuff', 'Menottes Basique', 0.5, 1, 'item', 0),
('basic_key', 'Clefs de Menottes Basique', 0.5, 1, 'item', 0),
('bbqsauce', 'Bbq Sauce', 0.5, 1, 'item', 0),
('beer', 'Bière', 0.5, 1, 'item', 0),
('bitcoin', 'Bitcoin', 1.5, 1, 'item', 0),
('black_phone', 'Black Phone', 10, 1, 'item', 0),
('blowpipe', 'Chalumeaux', 1.5, 1, 'item', 0),
('blue_phone', 'Blue Phone', 10, 1, 'item', 0),
('bmx', 'Bmx', 10, 1, 'item', 0),
('bread', 'Pain', 0.4, 1, 'item', 0),
('brochet', 'Brochet', 0.4, 1, 'item', 0),
('burger', 'Burger', 0.5, 1, 'item', 0),
('burgerclassique', 'Burger Classique', 0.5, 1, 'item', 0),
('cabillaud', 'Cabillaud', 0.6, 1, 'item', 0),
('cacahuete', 'cacahuète', 0.5, 1, 'item', 0),
('cagoule', 'Cagoule', 0.5, 1, 'item', 0),
('capote', 'Capote', 0.5, 1, 'item', 0),
('car_key', 'Clé de véhicule', 0.5, 1, 'item', 0),
('carotool', 'Outils carosserie', 4, 1, 'item', 0),
('carton__ingredient_burgershot', 'Carton de ingrédient BurgerShot', 1, 1, 'item', 0),
('carton_aliment_burgershot', 'Carton alimentaire BurgerShot', 1, 1, 'item', 0),
('cash', 'Argent', 0, 1, 'accounts', 0),
('casino_beer', 'Casino Beer', 0, 1, 'item', 0),
('casino_burger', 'Burger', 0, 1, 'item', 0),
('casino_chips', 'Casino Chips', 0, 1, 'item', 0),
('casino_coffee', 'Casino Coffee', 0, 1, 'item', 0),
('casino_coke', 'Casino Kofola', 0, 1, 'item', 0),
('casino_donut', 'Donut', 0, 1, 'item', 0),
('casino_ego_chaser', 'Casino Ego Chaser', 0, 1, 'item', 0),
('casino_luckypotion', 'Casino Lucky Potion', 0, 1, 'item', 0),
('casino_psqs', 'Casino Ps & Qs', 0, 1, 'item', 0),
('casino_sandwitch', 'Sandwitch', 0.5, 1, 'item', 0),
('casino_sprite', 'Casino Sprite', 0, 1, 'item', 0),
('cb', 'Carte Bancaire', 1, 1, 'item', 0),
('cbd', 'CBD', 1, 1, 'item', 0),
('cbd_pooch', 'Pochon de CBD', 0.3, 1, 'item', 0),
('cheddar', 'Cheddar', 0.5, 1, 'item', 0),
('chiffon_clean', 'Chiffon Microfibre', 2, 1, 'item', 0),
('chip', 'Jeton', 0, 1, 'item', 0),
('chips', 'chips', 0.5, 1, 'item', 0),
('cigarette', 'Cigarette', 0.5, 1, 'item', 0),
('classic_phone', 'Classic Phone', 2, 1, 'item', 0),
('clip', 'Boite de munitions', 0.5, 1, 'item', 0),
('coca', 'Coca', 0.5, 1, 'item', 0),
('cofee', 'Café', 1, 1, 'item', 0),
('coke', 'Coke', 1, 1, 'item', 0),
('coke_pooch', 'Pochon de coke', 0.3, 1, 'item', 0),
('cola', 'Cola', 0.5, 1, 'item', 0),
('commandetacos', 'Commande Tacos', 1, 1, 'item', 0),
('composant', 'Composant', 1, 1, 'item', 0),
('composant_rtx', 'Composant RTX', 1, 1, 'item', 0),
('cornichons', 'Cornichons', 0.5, 1, 'item', 0),
('d', 'd', 1, 1, NULL, 0),
('defibrillateur', 'Défibrillateur', 2, 1, 'item', 0),
('dirtycash', 'Argent sale', 0, 1, 'accounts', 0),
('donuts', 'Donuts', 1, 1, 'item', 0),
('drive', 'Permis de conduire', 0, 1, 'item', 1),
('drop_flareV2', 'Flare', 1, 1, 'item', 0),
('fakeplate', 'Fake Plate', 1, 1, NULL, 0),
('fanta', 'fanta', 0.5, 1, 'item', 0),
('feuille_coca', 'Feuille de coca', 1, 1, 'item', 0),
('firstaidkit', 'Trousse premier secours', 1, 1, 'item', 0),
('fish', 'Poisson', 0.5, 1, 'item', 0),
('fishingrod', 'Canne à pêche', 0.5, 1, 'item', 0),
('fixkit', 'Kit réparation', 1.5, 1, 'item', 0),
('fixtool', 'Outils réparation', 2, 1, 'item', 0),
('frites', 'Frites', 0.5, 1, 'item', 0),
('gadget_parachute', 'Parachute', 1, 1, 'weapons', 1),
('garnitures', 'Garnitures', 0.5, 1, 'item', 0),
('gazbottle', 'Bouteille de gaz', 2, 1, 'item', 0),
('gitanes', 'Gitanes', 0.5, 1, 'item', 0),
('gold_phone', 'Gold Phone', 2, 1, 'item', 0),
('gphone', 'gPhone', 1, 1, 'item', 0),
('gps', 'Gps', 0.1, 1, 'item', 0),
('graine_weed', 'Graine de weed', 1, 1, NULL, 0),
('grand_cru', 'Grand cru', 0.5, 1, 'item', 0),
('grapperaisin', 'Grappe de raisin', 0.5, 1, 'item', 0),
('green_phone', 'Green Phone', 10, 1, 'item', 0),
('greenlight_phone', 'Green Light Phone', 10, 1, 'item', 0),
('handcuff', 'Serre câble ', 0.5, 1, 'item', 0),
('hottub1', 'Hottub 1', 1, 1, 'item', 0),
('hottub1stairs', 'Hottub 1 Stairs', 1, 1, 'item', 0),
('hottub2', 'Hottub 2', 1, 1, 'item', 0),
('hottub2stairs', 'Hottub 2 Stairs', 1, 1, 'item', 0),
('hottub3', 'Hottub 3', 1, 1, 'item', 0),
('hottub3stairs', 'Hottub 3 Stairs', 1, 1, 'item', 0),
('ice', 'Glaçon', 0.5, 1, 'item', 0),
('icetea', 'icetea', 0.5, 1, 'item', 0),
('id_card_f', 'Carte de sécurité', 0.5, 1, 'item', 0),
('idcard', 'Carte Identité', 0, 1, 'item', 1),
('jager', 'Jägermeister', 0.5, 1, 'item', 0),
('jagerbomb', 'Jägermeister', 0.5, 1, 'item', 0),
('jagercerbere', 'Jäger Cerbère', 0.5, 1, 'item', 0),
('jerican', 'Jerican', 4, 1, 'item', 0),
('jewels', 'Bijoux', 1, 1, 'item', 0),
('job_barilpetrole', 'Baril de petrole', 1, 1, 'item', 0),
('job_cartemere', 'Carte mere', 0.5, 1, 'item', 0),
('job_pc', 'pc', 1, 1, 'item', 0),
('job_polypropylene', 'Polypropylene', 0.5, 1, 'item', 0),
('job_tomate', 'Tomate Fraiche', 0.5, 1, 'item', 0),
('job_ttomate', 'Tomate Traiter', 1, 1, 'item', 0),
('jumelles', 'Jumelles', 0.5, 1, 'item', 0),
('jus_coca', 'Jus de coca', 0.5, 1, 'item', 0),
('jus_de_pomme', 'Jus de Pomme', 0.5, 1, 'item', 0),
('jus_raisin', 'Jus de raisin', 0.5, 1, 'item', 0),
('jusfruit', 'Jus de fruits', 0.5, 1, 'item', 0),
('ketamine', 'Ketamine', 1, 1, 'item', 0),
('kevlar', 'Kevlar Lourd', 2.5, 1, 'item', 0),
('kevlarlow', 'Kevlar Léger', 0.5, 1, 'item', 0),
('kevlarmid', 'Kevlar Medium', 1.5, 1, 'item', 0),
('kitcrochetage', 'Kit de crochetage', 1, 1, 'item', 0),
('kq_outfitbag', 'Outfit bag', 4, 1, 'item', 0),
('latex', 'Latex', 1.5, 1, 'item', 0),
('limonade', 'Limonade', 0.5, 1, 'item', 0),
('lingotor', 'Lingot d\'or', 1, 1, 'item', 0),
('lockpick', 'Pied de Biche', 1, 1, 'item', 0),
('malbora', 'Malboro', 0.5, 1, 'item', 0),
('martini', 'Martini blanc', 1, 1, 'item', 0),
('meat', 'Viande', 0.5, 1, 'item', 0),
('medikit', 'Medikit', 0.5, 1, 'item', 0),
('megaphone', 'megaphone', 0.1, 1, 'item', 0),
('menthe', 'Feuille de menthe', 1, 1, 'item', 0),
('meth', 'Meth', 1, 1, 'item', 0),
('meth_pooch', 'Pochon de meth', 0.3, 1, 'item', 0),
('metreshooter', 'Mètre de shooter', 0.5, 1, 'item', 0),
('mixapero', 'Mix Apéritif', 0.5, 1, 'item', 0),
('mojito', 'Mojito', 0.5, 1, 'item', 0),
('munitions', 'Munitions de pistolet', 0.5, 1, 'item', 0),
('nitrovehicle', 'Bouteille de nos', 0.7, 1, 'item', 0),
('oldplate', 'Original Plate', 1, 1, NULL, 0),
('olive', 'Olive', 0.5, 1, 'item', 0),
('opium', 'Opium', 1, 1, 'item', 0),
('opium_pooch', 'Pochon d\'Opium', 0.3, 1, 'item', 0),
('orange', 'Orange', 0.5, 1, 'item', 0),
('orange_juice', 'Jus d\'orange', 0.5, 1, 'item', 0),
('orangina', 'Orangina', 0.5, 1, 'item', 0),
('originalesauce', 'Originale Sauce', 0.5, 1, 'item', 0),
('oxygen_mask', 'Masque à Oxygène', 0.6, 1, 'item', 0),
('painburger', 'Pain Burger', 1, 1, 'item', 0),
('paper', 'Papier', 0.5, 1, 'item', 0),
('pepitor', 'Pépite d\'or', 1, 1, 'item', 0),
('pepperspray', 'Gazeuse', 1, -1, 'item', 0),
('phone', 'Téléphone', 0.5, 1, 'item', 0),
('phone_hack', 'Phone Hack', 10, 1, 'item', 0),
('phone_module', 'Phone Module', 10, 1, 'item', 0),
('piluleoubli', 'GHB', 1, 1, 'item', 0),
('pink_phone', 'Pink Phone', 10, 1, 'item', 0),
('pizza', 'Pizza', 1, 1, NULL, 0),
('plante', 'Plante du Jardinier', 2, 1, 'item', 0),
('police_cuff', 'Menottes LSPD', 0.5, 1, 'item', 0),
('police_key', 'Clefs de Menottes LSPD', 0.5, 1, 'item', 0),
('pomme', 'Pomme', 1, 1, 'item', 0),
('pommedeterre', 'Pomme De Terre', 0.5, 1, 'item', 0),
('pooch_ketamine', 'Pochon de ketamine', 0.3, 1, 'item', 0),
('pot', 'Pot', 0.5, 1, 'item', 0),
('poulet', 'Poulet', 0.5, 1, 'item', 0),
('powerbank', 'Power Bank', 10, 1, 'item', 0),
('pâte a pizza', 'Pate à pizza', 1, 1, NULL, 0),
('radio', 'Radio', 0.5, 1, 'item', 0),
('raisin', 'Raisin', 0.5, 1, 'item', 0),
('red_phone', 'Red Phone', 10, 1, 'item', 0),
('redbull', 'Redbull', 0.5, 1, 'item', 0),
('redmonney', 'Faux Billet', 0.5, 1, 'item', 0),
('repairkit', 'Repairkit', 2, 1, 'item', 0),
('reparkit', 'Kit de réparation', 5, 1, 'item', 0),
('rhum', 'Rhum', 0.5, 1, 'item', 0),
('rhumcoca', 'Rhum-Coca', 0.5, 1, 'item', 0),
('rhumfruit', 'Rhum-Jus de fruits', 0.5, 1, 'item', 0),
('rorge', 'orge', 1, 1, 'item', 0),
('rtissu', 'Tissu', 1, 1, 'item', 0),
('rtx_4090', 'RTX 4090', 1, 1, 'item', 0),
('salade', 'Salade', 0.5, 1, 'item', 0),
('sandwich', 'Sandwich', 0.5, 1, 'item', 0),
('sardine', 'Sardine', 1, 1, 'item', 0),
('saumon', 'Saumon', 1, 1, 'item', 0),
('scrap', 'Pieces Détachés', 1, 1, 'item', 0),
('scratch_ticket', 'Ticket a gratter', 2, 1, 'item', 0),
('steak', 'Steak Haché', 1, 1, 'item', 0),
('steakboeuf', 'Steak Boeuf', 1, 1, 'item', 0),
('steakboeufpremium', 'Steak Boeuf Premium', 1, 1, 'item', 0),
('tabac', 'Tabac', 1.5, 1, 'item', 0),
('tabacblond', 'Tabac Blond', 0.5, 1, 'item', 0),
('tabacblondsec', 'Tabac Blond Séché', 0.5, 1, 'item', 0),
('tabacbrun', 'Tabac Brun', 0.5, 1, 'item', 0),
('tabacbrunsec', 'Tabac Brun Séché', 0.5, 1, 'item', 0),
('tarte_pomme', 'Tarte aux Pommes', 0.5, 1, 'item', 0),
('teqpaf', 'Teq\'paf', 0.5, 1, 'item', 0),
('tequila', 'Tequila', 0.5, 1, 'item', 0),
('thon', 'Thon', 1, 1, 'item', 0),
('tomates', 'Tomates', 0.5, 1, 'item', 0),
('towing_rope', 'Towing rope', 1, 1, NULL, 0),
('tpoulet', 'Wings', 0.5, 1, 'item', 0),
('truite', 'Truite', 1, 1, 'item', 0),
('ttissu', 'Vetement Nike', 1, 1, 'item', 0),
('twisky', 'wisky', 1, 1, 'item', 0),
('viande_1', 'Viande Blanche', 1.5, 1, 'item', 0),
('viande_2', 'Viande Rouge', 2.5, 1, 'item', 0),
('vine', 'Bouteille de Vin', 0.5, 1, 'item', 0),
('vittvin', 'Vin Blanc', 0.5, 1, 'item', 0),
('vodka', 'Vodka', 0.5, 1, 'item', 0),
('vodkaenergy', 'Vodka-Energy', 0.5, 1, 'item', 0),
('vodkafruit', 'Vodka-Jus de fruits', 0.5, 1, 'item', 0),
('vodkaredbull', 'Vodka-Redbull', 0.5, 1, 'item', 0),
('water', 'Bouteille d\'eau', 0.5, 1, 'item', 0),
('waterpass', 'Water Pass', 0.5, 1, 'item', 0),
('waterpassunlimited', 'Water Pass Unlimited', 0.5, 1, 'item', 0),
('weapon', 'Permis port d\'armes', 0, 1, 'item', 1),
('weapon_advancedrifle', 'Fusil Avancé', 1, 1, 'weapons', 1),
('weapon_appistol', 'Pistolet Perforant', 1, 1, 'weapons', 1),
('weapon_assaultrifle', 'AK-47', 1, 1, 'weapons', 1),
('weapon_assaultrifle_mk2', 'AK-47 MK2', 1, 1, 'weapons', 1),
('weapon_assaultshotgun', 'Fusil à Pompe D\'assaut', 1, 1, 'weapons', 1),
('weapon_assaultsmg', 'Mitraillette D\'assaut', 1, 1, 'weapons', 1),
('weapon_autoshotgun', 'Fusil à Pompe Auto', 1, 1, 'weapons', 1),
('weapon_ball', 'Balle', 1, 1, 'weapons', 1),
('weapon_bat', 'Batte De Baseball', 1, 1, 'weapons', 1),
('weapon_battleaxe', 'Hache', 1, 1, 'weapons', 1),
('weapon_bayonet', 'Bayonet', 1, 1, 'weapons', 1),
('weapon_beanbag', 'Pompe Bean-Bag', 1, 1, 'weapons', 1),
('weapon_bottle', 'Bouteille Cassé', 1, 1, 'weapons', 1),
('weapon_bullpuprifle', 'Fusil Bullpup', 1, 1, 'weapons', 1),
('weapon_bullpuprifle_mk2', 'Fusil Bullpup MK2', 1, 1, 'weapons', 1),
('weapon_bullpupshotgun', 'Fusil à Pompe Bullpup', 1, 1, 'weapons', 1),
('weapon_bzgas', 'Gaz Lacrymogène', 1, 1, 'weapons', 1),
('weapon_carbinerifle', 'M4A1', 1, 1, 'weapons', 1),
('weapon_carbinerifle_mk2', 'M4A1 MK2', 1, 1, 'weapons', 1),
('weapon_ceramicpistol', 'Pistolet En Céramique', 1, 1, 'weapons', 1),
('weapon_combatmg', 'M60', 1, 1, 'weapons', 1),
('weapon_combatmg_mk2', 'M60 MK2', 1, 1, 'weapons', 1),
('weapon_combatpdw', 'Arme De Défense Personnelle', 1, 1, 'weapons', 1),
('weapon_combatpistol', 'Pistolet De Combat', 1, 1, 'weapons', 1),
('weapon_combatshotgun', 'Fusil à Pompe De Combat', 1, 1, 'weapons', 1),
('weapon_compactlauncher', 'Lance Grenades Compact', 1, 1, 'weapons', 1),
('weapon_compactrifle', 'AK Compact', 1, 1, 'weapons', 1),
('weapon_crowbar', 'Pied De Biche', 1, 1, 'weapons', 1),
('weapon_dagger', 'Poignard', 1, 1, 'weapons', 1),
('weapon_dbshotgun', 'Fusil à Double Canon', 1, 1, 'weapons', 1),
('weapon_doubleaction', 'Revolver Double Action', 1, 1, 'weapons', 1),
('weapon_emplauncher', 'Lanceur EMP Compact', 1, 1, 'weapons', 1),
('weapon_fertilizercan', 'Bidon D\'engrais', 1, 1, 'weapons', 1),
('weapon_fireextinguisher', 'Extincteur', 1, 1, 'weapons', 1),
('weapon_firework', 'Lanceur De Feu D\'artifice', 1, 1, 'weapons', 1),
('weapon_flare', 'Fumée De Détresse', 1, 1, 'weapons', 1),
('weapon_flaregun', 'Pistolet De Détresse', 1, 1, 'weapons', 1),
('weapon_flashlight', 'Lampe Torche', 1, 1, 'weapons', 1),
('weapon_gadgetpistol', 'Pistolet Cayo Périco', 1, 1, 'weapons', 1),
('weapon_golfclub', 'Club De Golf', 1, 1, 'weapons', 1),
('weapon_grenade', 'Grenade', 1, 1, 'weapons', 1),
('weapon_grenadelauncher', 'Lance Grenades', 1, 1, 'weapons', 1),
('weapon_gusenberg', 'Gusenberg', 1, 1, 'weapons', 1),
('weapon_hammer', 'Marteau', 1, 1, 'weapons', 1),
('weapon_hatchet', 'Hachette', 1, 1, 'weapons', 1),
('weapon_hazardcan', 'Jerrycan Dangereux', 1, 1, 'weapons', 1),
('weapon_heavypistol', 'Pistolet Lourd', 1, 1, 'weapons', 1),
('weapon_heavyrifle', 'Fusil Lourd', 1, 1, 'weapons', 1),
('weapon_heavyshotgun', 'Fusil à Pompe Lourd', 1, 1, 'weapons', 1),
('weapon_heavysniper', 'Sniper Lourd', 1, 1, 'weapons', 1),
('weapon_heavysniper_mk2', 'Sniper Lourd MK2', 1, 1, 'weapons', 1),
('weapon_hominglauncher', 'Homing', 1, 1, 'weapons', 1),
('weapon_karambit', 'Karambit', 1, 1, 'weapons', 1),
('weapon_katana', 'Katana', 1, 1, 'weapons', 1),
('weapon_knife', 'Couteau', 1, 1, 'weapons', 1),
('weapon_knuckle', 'Poing Américain', 1, 1, 'weapons', 1),
('weapon_lucile', 'Lucile', 1, 1, 'weapons', 1),
('weapon_machete', 'Machette', 1, 1, 'weapons', 1),
('weapon_machinepistol', 'Tec-9', 1, 1, 'weapons', 1),
('weapon_marksmanpistol', 'Pistolet De Tireur D\'élite', 1, 1, 'weapons', 1),
('weapon_marksmanrifle', 'Sniper Tireur D\'élite', 1, 1, 'weapons', 1),
('weapon_marksmanrifle_mk2', 'Sniper Tireur D\'élite MK2', 1, 1, 'weapons', 1),
('weapon_mg', 'Mitrailleuse Légère', 1, 1, 'weapons', 1),
('weapon_microsmg', 'Micro Uzi', 1, 1, 'weapons', 1),
('weapon_militaryrifle', 'Fusil Militaire', 1, 1, 'weapons', 1),
('weapon_minigun', 'Minigun', 1, 1, 'weapons', 1),
('weapon_minismg', 'Scorpion', 1, 1, 'weapons', 1),
('weapon_molotov', 'Cocktails Molotov', 1, 1, 'weapons', 1),
('weapon_musket', 'Mousquet', 1, 1, 'weapons', 1),
('weapon_navyrevolver', 'Navy Revolver', 1, 1, 'weapons', 1),
('weapon_nightstick', 'Matraque', 1, 1, 'weapons', 1),
('weapon_pan', 'Poele', 1, 1, 'weapons', 1),
('weapon_petrolcan', 'Jerrican D\'essence', 1, 1, 'weapons', 1),
('weapon_pipebomb', 'Bombe Artisanale', 1, 1, 'weapons', 1),
('weapon_pistol', 'Beretta', 1, 1, 'weapons', 1),
('weapon_pistol50', 'Calibre 50', 1, 1, 'weapons', 1),
('weapon_pistol_mk2', 'Beretta MK2', 1, 1, 'weapons', 1),
('weapon_poolcue', 'Queue De Billard', 1, 1, 'weapons', 1),
('weapon_precisionrifle', 'Sniper De Précision', 1, 1, 'weapons', 1),
('weapon_proxmine', 'Mine De Proximité', 1, 1, 'weapons', 1),
('weapon_pumpshotgun', 'Fusil à Pompe', 1, 1, 'weapons', 1),
('weapon_pumpshotgun_mk2', 'Fusil à Pompe MK2', 1, 1, 'weapons', 1),
('weapon_railgun', 'Fusil à Rail', 1, 1, 'weapons', 1),
('weapon_raycarbine', 'Carabine Laser', 1, 1, 'weapons', 1),
('weapon_rayminigun', 'Minigun Laser', 1, 1, 'weapons', 1),
('weapon_raypistol', 'Pistolet Rayon', 1, 1, 'weapons', 1),
('weapon_revolver', 'Revolver', 1, 1, 'weapons', 1),
('weapon_revolver_mk2', 'Revolver MK2', 1, 1, 'weapons', 1),
('weapon_rpg', 'RPG', 1, 1, 'weapons', 1),
('weapon_sawnoffshotgun', 'Canon Scié', 1, 1, 'weapons', 1),
('weapon_smg', 'MP5', 1, 1, 'weapons', 1),
('weapon_smg_mk2', 'MP5 MK2', 1, 1, 'weapons', 1),
('weapon_smokegrenade', 'Fumigène', 1, 1, 'weapons', 1),
('weapon_sniperrifle', 'Sniper', 1, 1, 'weapons', 1),
('weapon_snowball', 'Brique', 1, 1, 'weapons', 1),
('weapon_snspistol', 'Pétoire', 1, 1, 'weapons', 1),
('weapon_snspistol_mk2', 'Pétoire MK2', 1, 1, 'weapons', 1),
('weapon_specialcarbine', 'G36', 1, 1, 'weapons', 1),
('weapon_specialcarbine_mk2', 'G36 MK2', 1, 1, 'weapons', 1),
('weapon_stickybomb', 'Bombes Collantes', 1, 1, 'weapons', 1),
('weapon_stone_hatchet', 'Hachette En Pierre', 1, 1, 'weapons', 1),
('weapon_stungun', 'Taser', 1, 1, 'weapons', 1),
('weapon_switchblade', 'Couteau Papillon', 1, 1, 'weapons', 1),
('weapon_tacticalrifle', 'Fusil Tactique', 1, 1, 'weapons', 1),
('weapon_tridagger', 'Dagger', 1, 1, 'weapons', 1),
('weapon_vintagepistol', 'Pistolet Vintage', 1, 1, 'weapons', 1),
('weapon_wrench', 'Clé à Molette', 1, 1, 'weapons', 1),
('weed', 'Weed', 1, 1, 'item', 0),
('weed_pooch', 'Pochon de weed', 0.3, 1, 'item', 0),
('wet_black_phone', 'Wet Black Phone', 10, 1, 'item', 0),
('wet_blue_phone', 'Wet Blue Phone', 10, 1, 'item', 0),
('wet_classic_phone', 'Wet Classic Phone', 10, 1, 'item', 0),
('wet_gold_phone', 'Wet Gold Phone', 10, 1, 'item', 0),
('wet_green_phone', 'Wet Green Phone', 10, 1, 'item', 0),
('wet_greenlight_phone', 'Wet Green Light Phone', 10, 1, 'item', 0),
('wet_pink_phone', 'Wet Pink Phone', 10, 1, 'item', 0),
('wet_red_phone', 'Wet Red Phone', 10, 1, 'item', 0),
('wet_white_phone', 'Wet White Phone', 10, 1, 'item', 0),
('whisky', 'Whisky', 0.5, 1, 'item', 0),
('whiskycoca', 'Whisky-coca', 0.5, 1, 'item', 0),
('white_phone', 'White Phone', 10, 1, 'item', 0),
('wiskycoca', 'wiskycoca', 0.5, 1, 'item', 0),
('wrench', 'Wrench', 1, 1, NULL, 0),
('xylazine', 'xylazine', 0.5, 1, 'item', 0),
('xylazine_pooch', 'Pochon de xylazine', 0.3, 1, 'item', 0),
('zetony', 'Jetons', 0.5, 1, 'item', 0);

-- --------------------------------------------------------

--
-- Structure de la table `jail`
--

CREATE TABLE `jail` (
  `identifier` varchar(100) NOT NULL,
  `remainingTasks` int(11) NOT NULL,
  `motif` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `jobbuilder`
--

CREATE TABLE `jobbuilder` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `society` varchar(50) NOT NULL,
  `posboss` varchar(255) NOT NULL,
  `posveh` varchar(255) NOT NULL,
  `poscoffre` varchar(255) NOT NULL,
  `posspawncar` varchar(255) NOT NULL,
  `nameitemrecolte` varchar(50) NOT NULL,
  `labelitemrecolte` varchar(50) NOT NULL,
  `posrecolte` varchar(255) NOT NULL,
  `nameitemtraitement` varchar(50) NOT NULL,
  `labelitemtraitement` varchar(50) NOT NULL,
  `postraitement` varchar(255) NOT NULL,
  `vehingarage` varchar(255) NOT NULL,
  `posvente` varchar(255) NOT NULL,
  `prixvente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(255) NOT NULL,
  `societyType` int(11) NOT NULL DEFAULT 1,
  `canWashMoney` tinyint(1) NOT NULL DEFAULT 0,
  `canUseOffshore` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`, `societyType`, `canWashMoney`, `canUseOffshore`) VALUES
('69pelow', '69pelow', 2, 0, 0),
('RaRecords', 'rarecords', 1, 0, 0),
('ambulance', 'Ambulance', 1, 0, 0),
('appleindustrie', 'Apple Industrie', 1, 0, 0),
('avocat', 'Avocat', 1, 0, 0),
('bahamas', 'Bahamas', 1, 0, 0),
('ballas', 'ballas', 2, 0, 0),
('bcso', 'bsco', 1, 0, 0),
('bloods', 'bloods', 2, 0, 0),
('boatseller', 'Concessionnaire Bénéteau', 1, 1, 0),
('bonelli', 'Bonelli', 2, 0, 0),
('burgershot', 'BurgerShot', 1, 1, 0),
('cardealer', 'Concessionnaire', 1, 1, 0),
('cayo', 'cayo', 2, 0, 0),
('chantier', 'Chantier', 1, 0, 0),
('chickenbell', 'ChickenBell', 1, 0, 0),
('churchtown', 'ChurchTown', 1, 0, 0),
('delivery', 'Delivery', 1, 0, 0),
('families', 'families', 2, 0, 0),
('fib', 'FIB', 1, 0, 0),
('fisherman', 'Pêcheur', 1, 0, 0),
('fueler', 'Raffineur', 1, 0, 0),
('gouv', 'Gouvernement', 1, 0, 0),
('jalisco', 'jalisco', 2, 0, 0),
('jardinier', 'Jardinier', 1, 0, 0),
('journalist', 'Journaliste', 1, 1, 0),
('label', 'RA Records', 1, 1, 0),
('lost', 'lost', 2, 0, 0),
('lumberjack', 'Bûcheron', 1, 0, 0),
('marabunta', 'marabunta', 2, 0, 0),
('mecano', 'Benny\'s', 1, 1, 0),
('mecano2', 'Ls Custom', 1, 1, 0),
('miner', 'Mineur', 1, 0, 0),
('mineur', 'Mineur', 1, 0, 0),
('nolan', 'nolan', 2, 0, 0),
('planeseller', 'Concessionnaire Aéronotique', 1, 1, 0),
('police', 'Police', 1, 0, 0),
('realestateagent', 'Agent immobilier', 1, 0, 0),
('sinaloa', 'sinaloa', 2, 0, 0),
('slaughterer', 'Abateur', 1, 0, 0),
('tacos', 'Tacos', 1, 0, 0),
('tailor', 'Couturier', 1, 0, 0),
('taxi', 'Taxi', 1, 1, 0),
('tequilala', 'Tequilala', 1, 0, 0),
('unemployed', 'Citoyen', 3, 0, 0),
('unemployed2', 'Aucune', 3, 0, 0),
('unicorn', 'Unicorn', 1, 1, 0),
('vagos', 'vagos', 2, 0, 0),
('vigneron', 'Vigneron', 1, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'ambulance', 0, 'stagiaire', 'Ambulancier', 1, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":33,\"pants_1\":19,\"blush_3\":0,\"torso_2\":1,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":21,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":11,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":8,\"arms\":91,\"chain_1\":0,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":23,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":1,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":4,\"decals_1\":65,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":105,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":0,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":257,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(2, 'ambulance', 1, 'ambulance', 'Infirmier', 1, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":33,\"pants_1\":19,\"blush_3\":0,\"torso_2\":1,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":21,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":11,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":8,\"arms\":91,\"chain_1\":0,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":51,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":7,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":1,\"decals_1\":66,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":106,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":2,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":9,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(3, 'ambulance', 2, 'infirmier', 'Médecin', 1, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":33,\"pants_1\":19,\"blush_3\":0,\"torso_2\":1,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":21,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":11,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":8,\"arms\":91,\"chain_1\":0,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":50,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":2,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":4,\"decals_1\":66,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":96,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":0,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":258,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(4, 'ambulance', 3, 'chirurgien', 'Chirurgien', 1, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":33,\"pants_1\":19,\"blush_3\":0,\"torso_2\":1,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":21,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":11,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":8,\"arms\":91,\"chain_1\":0,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":51,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":2,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":81,\"decals_1\":66,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":96,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":2,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":14,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(5, 'ambulance', 4, 'chefs', 'Chef de service', 1, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":33,\"pants_1\":19,\"blush_3\":0,\"torso_2\":1,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":21,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":11,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":8,\"arms\":91,\"chain_1\":0,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":51,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":2,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":81,\"decals_1\":66,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":96,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":2,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":14,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(6, 'ambulance', 5, 'coboss', 'Co directeur', 1, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":33,\"pants_1\":19,\"blush_3\":0,\"torso_2\":1,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":21,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":11,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":8,\"arms\":91,\"chain_1\":0,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":51,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":2,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":81,\"decals_1\":66,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":96,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":2,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":14,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(7, 'avocat', 0, 'recruit', 'Recrue', 350, '{\"tshirt_1\":57,\"torso_1\":55,\"arms\":0,\"pants_1\":35,\"glasses\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":5,\"face\":19,\"glasses_2\":1,\"torso_2\":0,\"shoes\":24,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":8}', '{\"tshirt_1\":34,\"torso_1\":48,\"shoes\":24,\"pants_1\":34,\"torso_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"glasses\":0,\"helmet_2\":0,\"hair_2\":3,\"face\":21,\"decals_1\":0,\"glasses_2\":1,\"hair_1\":11,\"skin\":34,\"sex\":1,\"glasses_1\":5,\"pants_2\":0,\"arms\":14,\"hair_color_1\":10,\"tshirt_2\":0,\"helmet_1\":57}'),
(8, 'avocat', 1, 'boss', 'Patron', 400, '{\"tshirt_1\":58,\"torso_1\":55,\"shoes\":24,\"pants_1\":35,\"pants_2\":0,\"decals_2\":3,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":41,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":8,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":11}', '{\"tshirt_1\":35,\"torso_1\":48,\"arms\":44,\"pants_1\":34,\"pants_2\":0,\"decals_2\":3,\"hair_color_2\":0,\"face\":21,\"helmet_2\":0,\"hair_2\":3,\"decals_1\":7,\"torso_2\":0,\"hair_color_1\":10,\"hair_1\":11,\"skin\":34,\"sex\":1,\"glasses_1\":5,\"glasses_2\":1,\"shoes\":24,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":57}'),
(9, 'mecano', 0, 'recrue', 'Recrue', 50, '{}', '{}'),
(10, 'mecano', 1, 'novice', 'Novice', 50, '{}', '{}'),
(45, 'mecano', 2, 'experimente', 'Experimente', 50, '{}', '{}'),
(46, 'mecano', 3, 'chief', 'Chef d\'equipe', 50, '{}', '{}'),
(47, 'mecano', 4, 'boss', 'Patron', 100, '{}', '{}'),
(50, 'police', 0, 'recruit', 'Cadet', 2000, '{}', '{}'),
(51, 'police', 1, 'officer', 'Officier', 2500, '{}', '{}'),
(52, 'police', 2, 'sergeant', 'Sergent', 3000, '{}', '{}'),
(53, 'police', 3, 'lieutenant', 'Lieutenant', 3500, '{}', '{}'),
(54, 'police', 4, 'capitaine', 'Capitaine', 4500, '{}', '{}'),
(55, 'police', 5, 'commander', 'Commander ', 5500, '{}', '{}'),
(56, 'police', 6, 'deputy', 'Deputy chief', 6000, '{}', '{}'),
(57, 'police', 7, 'assistantboss', 'Assistant Chief', 6500, '{}', '{}'),
(58, 'police', 8, 'boss', 'Chief', 9999, '{}', '{}'),
(66, 'taxi', 0, 'recrue', 'Recrue', 100, '{}', '{}'),
(67, 'taxi', 1, 'novice', 'Novice', 200, '{}', '{}'),
(68, 'taxi', 2, 'experimente', 'Experimente', 1, '{}', '{}'),
(69, 'taxi', 3, 'uber', 'Uber', 1, '{}', '{}'),
(70, 'taxi', 4, 'boss', 'Patron', 1, '{}', '{}'),
(74, 'unemployed', 0, 'unemployed', 'RSA', 100, '{}', '{}'),
(75, 'unicorn', 0, 'barman', 'Barman', 1, '{}', '{}'),
(76, 'unicorn', 1, 'dancer', 'Videur', 1, '{}', '{}'),
(77, 'unicorn', 2, 'viceboss', 'Co-gérant', 1, '{}', '{}'),
(78, 'unicorn', 3, 'boss', 'Gérant', 1, '{}', '{}'),
(79, 'vigne', 0, 'recrue', 'Recrue', 250, '{\"tshirt_1\":59,\"tshirt_2\":0,\"torso_1\":12,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(80, 'vigne', 1, 'novice', 'Novice', 300, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(81, 'vigne', 2, 'cdisenior', 'Chef de Chai', 100, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(82, 'vigne', 3, 'boss', 'Patron', 400, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":14,\"torso_2\":15,\"shoes_1\":12,\"shoes_2\":0,\"pants_1\":9, \"pants_2\":5, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(90, 'burgershot', 0, 'recrue', 'Periode d\'essai', 75, '{}', '{}'),
(91, 'burgershot', 1, 'novice', 'Novice', 125, '{}', '{}'),
(92, 'burgershot', 2, 'experimente', 'Experimente', 150, '{}', '{}'),
(93, 'burgershot', 3, 'chief', 'Chef d\'équipe', 300, '{}', '{}'),
(94, 'burgershot', 4, 'boss', 'Patron', 1500, '{}', '{}'),
(148, 'realestateagent', 0, 'location', 'Vendeurs', 1, '{}', '{}'),
(149, 'realestateagent', 1, 'vendeur', 'Responsable des ventes', 1, '{}', '{}'),
(150, 'realestateagent', 2, 'gestion', 'Recruteur', 1, '{}', '{}'),
(151, 'realestateagent', 3, 'boss', 'Patron', 5000, '{}', '{}'),
(157, 'unemployed2', 0, 'unemployed2', 'Citoyen', 0, '{}', '{}'),
(182, 'journalist', 0, 'stagiaire', 'Stagiaire', 1, '{}', '{}'),
(183, 'journalist', 1, 'reporter', 'Reporter', 1, '{}', '{}'),
(184, 'journalist', 2, 'investigator', 'Investigateur', 1, '{}', '{}'),
(185, 'journalist', 3, 'boss', 'Directeur', 2000, '{}', '{}'),
(551, 'cardealer', 0, 'recruit', 'Recrue', 1000, '{}', '{}'),
(552, 'cardealer', 1, 'novice', 'Novice', 2500, '{}', '{}'),
(553, 'cardealer', 2, 'experienced', 'Experimente', 4000, '{}', '{}'),
(554, 'cardealer', 3, 'boss', 'Patron', 9999, '{}', '{}'),
(612, 'delivery', 0, 'delivery', 'Delivery', 500, '{}', '{}'),
(617, 'boatseller', 0, 'recruit', 'Recrue', 1, '{}', '{}'),
(618, 'boatseller', 1, 'novice', 'Novice', 1, '{}', '{}'),
(619, 'boatseller', 2, 'experienced', 'Experimente', 1, '{}', '{}'),
(620, 'boatseller', 3, 'boss', 'Patron', 1, '{}', '{}'),
(621, 'planeseller', 0, 'recruit', 'Recrue', 999, '{}', '{}'),
(622, 'planeseller', 1, 'novice', 'Novice', 2300, '{}', '{}'),
(623, 'planeseller', 2, 'experienced', 'Experimente', 5250, '{}', '{}'),
(624, 'planeseller', 3, 'boss', 'Patron', 9500, '{}', '{}'),
(625, 'slaughterer', 0, 'recruit', 'Recrue', 150, '{}', '{}'),
(626, 'lumberjack', 0, 'recruit', 'Recrue', 150, '{}', '{}'),
(627, 'tailor', 0, 'recruit', 'Recrue', 150, '{}', '{}'),
(628, 'miner', 0, 'recruit', 'Recrue', 150, '{}', '{}'),
(629, 'fisherman', 0, 'recruit', 'Recrue', 150, '{}', '{}'),
(630, 'fueler', 0, 'recruit', 'Recrue', 150, '{}', '{}'),
(786, 'bahamas', 1, 'dancer', 'Videur', 1, '{}', '{}'),
(789, 'bahamas', 3, 'boss', 'Gérant', 1, '{}', '{}'),
(797, 'bahamas', 2, 'viceboss', 'Co-gérant', 1, '{}', '{}'),
(801, 'tacos', 0, 'recrue', 'Recrue', 250, '{}', '{}'),
(802, 'jardinier', 0, 'recrue', 'Recrue', 250, '{}', '{}'),
(865, 'vigneron', 0, 'recrue', 'Recrue', 1, '{}', '{}'),
(866, 'vigneron', 1, 'novice', 'Novice', 1, '{}', '{}'),
(867, 'vigneron', 2, 'experimente', 'Experimente', 1, '{}', '{}'),
(868, 'vigneron', 3, 'boss', 'Patron', 1, '{}', '{}'),
(873, 'gouv', 0, 'chauffeur_prive', 'Avocat', 1, '{}', '{}'),
(874, 'gouv', 1, 'avocat', 'Juge', 5000, '{}', '{}'),
(875, 'gouv', 2, 'juge', 'Garde du corps', 3500, '{}', '{}'),
(876, 'gouv', 3, 'garde_du_corps', 'Chef de section', 5000, '{}', '{}'),
(877, 'gouv', 4, 'garde_corps_rap', 'Procureur', 5000, '{}', '{}'),
(878, 'gouv', 5, 'chef_section', 'Contrôleur', 5000, '{}', '{}'),
(879, 'gouv', 6, 'secrétaire', 'Secrétaire', 7500, '{}', '{}'),
(880, 'gouv', 7, 'vice_gouverneur', 'Vice gouverneur', 8000, '{}', '{}'),
(881, 'gouv', 8, 'boss', 'Gouverneur', 9999, '{}', '{}'),
(900, 'mecano2', 0, 'recrue', 'Recrue', 1500, '{}', '{}'),
(901, 'mecano2', 1, 'novice', 'Novice', 2000, '{}', '{}'),
(902, 'mecano2', 2, 'experimente', 'Experimente', 2500, '{}', '{}'),
(903, 'mecano2', 3, 'chief', 'Chef d\'equipe', 3000, '{}', '{}'),
(904, 'mecano2', 4, 'boss', 'Patron', 5000, '{}', '{}'),
(1151, 'fib', 0, 'recruit', 'Consultant Fédéral', 500, '{}', '{}'),
(1152, 'fib', 1, 'officer', 'Agent Aspirant', 700, '{}', '{}'),
(1153, 'fib', 2, 'sergeant', 'Agent Fédéral', 1000, '{}', '{}'),
(1154, 'fib', 3, 'sergeant_chief', 'Agent Spécial', 2000, '{}', '{}'),
(1155, 'fib', 4, 'intendent', 'Agent Spécial Superviseur', 5000, '{}', '{}'),
(1156, 'fib', 5, 'lieutenant', 'Agent Spécial en Charge', 4500, '{}', '{}'),
(1157, 'fib', 6, 'chef', 'Agent Spécial de Coordination', 4000, '{}', '{}'),
(1158, 'fib', 7, 'boss', 'Directeur d\'Agence', 5500, '{}', '{}'),
(1235, 'families', 6, 'boss', 'Patron', 1, '[]', '[]'),
(1236, 'families', 3, 'elite', 'Elite', 1, '[]', '[]'),
(1237, 'families', 2, 'soldat', 'Soldat', 1, '[]', '[]'),
(1238, 'families', 4, 'lieutenant', 'Lieutenant', 1, '[]', '[]'),
(1239, 'families', 1, 'associé', 'Associé', 1, '[]', '[]'),
(1240, 'families', 5, 'bras_droit', 'Bras Droit', 1, '[]', '[]'),
(1241, 'marabunta', 6, 'boss', 'Patron', 9999, '[]', '[]'),
(1242, 'marabunta', 5, 'bras_droit', 'Bras Droit', 1, '[]', '[]'),
(1243, 'marabunta', 4, 'lieutenant', 'Lieutenant', 1, '[]', '[]'),
(1244, 'marabunta', 3, 'elite', 'Elite', 1, '[]', '[]'),
(1245, 'marabunta', 2, 'soldat', 'Soldat', 1, '[]', '[]'),
(1246, 'marabunta', 1, 'associé', 'Associé', 1, '[]', '[]'),
(1247, 'bloods', 5, 'bras_droit', 'Bras Droit', 5000, '[]', '[]'),
(1248, 'bloods', 6, 'boss', 'Patron', 9999, '[]', '[]'),
(1249, 'bloods', 1, 'associé', 'Associé', 100, '[]', '[]'),
(1250, 'bloods', 3, 'elite', 'Elite', 300, '[]', '[]'),
(1251, 'bloods', 4, 'lieutenant', 'Lieutenant', 5000, '[]', '[]'),
(1252, 'bloods', 2, 'soldat', 'Soldat', 200, '[]', '[]'),
(1264, 'chickenbell', 0, 'recrue', 'Intérimaire', 1, '{}', '{}'),
(1265, 'chickenbell', 1, 'novice', 'Employé', 1, '{}', '{}'),
(1266, 'chickenbell', 2, 'experimente', 'Expérimente', 1, '{}', '{}'),
(1267, 'chickenbell', 3, 'boss', 'Patron', 1000, '{}', '{}'),
(1277, 'vagos', 4, 'lieutenant', 'Lieutenant', 1000, '[]', '[]'),
(1278, 'vagos', 6, 'boss', 'Patron', 9000, '[]', '[]'),
(1279, 'vagos', 5, 'bras_droit', 'Bras Droit', 1000, '[]', '[]'),
(1280, 'vagos', 3, 'elite', 'Elite', 1000, '[]', '[]'),
(1281, 'vagos', 2, 'soldat', 'Soldat', 1000, '[]', '[]'),
(1282, 'vagos', 1, 'associé', 'Associé', 1000, '[]', '[]'),
(1286, 'nikefactory', 0, 'recrue', 'Recrue', 1, '{}', '{}'),
(1287, 'nikefactory', 1, 'novice', 'Novice', 1, '{}', '{}'),
(1288, 'nikefactory', 2, 'experimente', 'Experimente', 1, '{}', '{}'),
(1289, 'nikefactory', 3, 'boss', 'Patron', 1, '{}', '{}'),
(1301, 'churchtown', 0, 'recrue', 'Recrue', 250, '{}', '{}'),
(1302, 'churchtown', 1, 'novice', 'Novice', 300, '{}', '{}'),
(1303, 'churchtown', 2, 'experimente', 'Experimente', 350, '{}', '{}'),
(1304, 'churchtown', 3, 'boss', 'Patron', 400, '{}', '{}'),
(1321, 'tequilala', 0, 'recrue', 'Recrue', 500, '{}', '{}'),
(1322, 'tequilala', 1, 'novice', 'Novice', 1, '{}', '{}'),
(1323, 'tequilala', 2, 'experimente', 'Experimente', 1, '{}', '{}'),
(1324, 'tequilala', 3, 'boss', 'Patron', 1000, '{}', '{}'),
(1340, 'ambulance', 6, 'boss', 'Directeur', 1, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":33,\"pants_1\":19,\"blush_3\":0,\"torso_2\":1,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":21,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":11,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":8,\"arms\":91,\"chain_1\":0,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":23,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":1,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":4,\"decals_1\":65,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":105,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":0,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":257,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(1349, 'ballas', 2, 'soldat', 'Soldat', 1, '[]', '[]'),
(1350, 'ballas', 1, 'associé', 'Associé', 1, '[]', '[]'),
(1351, 'ballas', 3, 'elite', 'Elite', 1, '[]', '[]'),
(1352, 'ballas', 4, 'lieutenant', 'Lieutenant', 1, '[]', '[]'),
(1353, 'ballas', 5, 'bras_droit', 'Bras Droit', 1, '[]', '[]'),
(1354, 'ballas', 6, 'boss', 'Patron', 1, '[]', '[]'),
(1437, 'appleindustrie', 0, 'recrue', 'Recrue', 1, '{}', '{}'),
(1438, 'appleindustrie', 1, 'novice', 'Novice', 1, '{}', '{}'),
(1439, 'appleindustrie', 2, 'experimente', 'Experimente', 1, '{}', '{}'),
(1440, 'appleindustrie', 3, 'boss', 'Patron', 1, '{}', '{}'),
(1701, 'bcso', 0, 'recruit', 'Junior', 10, '{}', '{}'),
(1702, 'bcso', 1, 'deputyone', 'Deputy I', 10, '{}', '{}'),
(1703, 'bcso', 2, 'deputytwo', 'Deputy II', 10, '{}', '{}'),
(1704, 'bcso', 3, 'deputytre', 'Deputy III', 10, '{}', '{}'),
(1705, 'bcso', 4, 'seniordeputy', 'Senior Deputy', 10, '{}', '{}'),
(1706, 'bcso', 5, 'masterdeputy', 'Master Deputy', 10, '{}', '{}'),
(1707, 'bcso', 6, 'caporal', 'Caporal', 10, '{}', '{}'),
(1716, 'bcso', 7, 'sergeant', 'Sergeant', 10, '{}', '{}'),
(1717, 'bcso', 8, 'mastersergeant', 'Master Sergeant', 10, '{}', '{}'),
(1718, 'bcso', 9, 'lieutenant', 'Lieutenant', 10, '{}', '{}'),
(1719, 'bcso', 10, 'captain', 'Captain', 10, '{}', '{}'),
(1720, 'bcso', 11, 'major', 'Major', 10, '{}', '{}'),
(1721, 'bcso', 12, 'chefdeputy', 'Chef Deputy', 10, '{}', '{}'),
(1722, 'bcso', 13, 'assistsheriff', 'Assistant Sheriff', 10, '{}', '{}'),
(1723, 'bcso', 14, 'undersheriff', 'Under Sheriff', 10, '{}', '{}'),
(1724, 'bcso', 15, 'boss', 'Sheriff', 10, '{}', '{}'),
(1748, 'rarecords', 0, 'rapper', 'Rappeur', 0, '[]', '[]'),
(1749, 'rarecords', 1, 'manager', 'Manageur', 0, '[]', '[]'),
(1750, 'rarecords', 2, 'boss', 'Patron', 0, '[]', '[]'),
(1763, 'label', 1, 'novice', 'Novice', 1, '[]', '[]'),
(1764, 'label', 0, 'recrue', 'Recrue', 1, '[]', '[]'),
(1765, 'label', 3, 'boss', 'Patron', 1, '[]', '[]'),
(1766, 'label', 2, 'experimente', 'Experimente', 1, '[]', '[]'),
(1767, 'ltd_sud', 1, 'novice', 'Novice', 0, '[]', '[]'),
(1768, 'ltd_sud', 0, 'recrue', 'Recrue', 0, '[]', '[]'),
(1769, 'ltd_sud', 3, 'boss', 'Patron', 0, '[]', '[]'),
(1770, 'ltd_sud', 2, 'experimente', 'Experimente', 0, '[]', '[]'),
(1994, 'fermier', 2, 'experimente', 'Experimente', 0, '[]', '[]'),
(1995, 'fermier', 1, 'novice', 'Novice', 0, '[]', '[]'),
(1996, 'fermier', 0, 'recrue', 'Recrue', 0, '[]', '[]'),
(1997, 'fermier', 3, 'boss', 'Patron', 0, '[]', '[]'),
(2004, 'Pizza', 2, 'experimente', 'Experimente', 0, '[]', '[]'),
(2005, 'Pizza', 3, 'boss', 'Patron', 0, '[]', '[]'),
(2006, 'Pizza', 0, 'recrue', 'Recrue', 0, '[]', '[]'),
(2007, 'Pizza', 1, 'novice', 'Novice', 0, '[]', '[]'),
(2253, 'bonelli', 0, 'user', 'User', 0, '[]', '[]'),
(2254, 'bonelli', 1, 'boss', 'Owner', 0, '[]', '[]'),
(2265, 'mayansmc', 0, 'user', 'User', 0, '[]', '[]'),
(2266, 'mayansmc', 1, 'boss', 'Owner', 0, '[]', '[]'),
(2287, 'cayo', 0, 'user', 'Membre', 0, '[]', '[]'),
(2288, 'cayo', 1, 'boss', 'Patron', 0, '[]', '[]'),
(2289, 'sinaloa', 0, 'user', 'Membre', 0, '[]', '[]'),
(2290, 'sinaloa', 1, 'boss', 'Patron', 0, '[]', '[]'),
(7455, 'bahamas', 0, 'barman', 'Barman', 1, '{}', '{}'),
(12849, 'lost', 1, 'boss', 'Patron', 0, '[]', '[]'),
(12904, 'lost', 0, 'user', 'Membre', 1, '[]', '[]'),
(14497, 'jalisco', 0, 'user', 'Membre', 1, '[]', '[]'),
(14945, 'jalisco', 1, 'boss', 'Patron', 1, '[]', '[]'),
(14946, 'jardinier', 0, 'recrue', 'Jardinier', 400, 'null', 'null'),
(14947, 'chantier', 0, 'recrue', 'Chantier', 400, 'null', 'null'),
(14948, 'mineur', 0, 'recrue', 'Mineur', 400, 'null', 'null'),
(14951, '69pelow', 0, 'user', 'User', 0, '[]', '[]'),
(14952, '69pelow', 1, 'boss', 'Owner', 0, '[]', '[]'),
(14953, 'nolan', 0, 'user', 'User', 0, '[]', '[]'),
(14954, 'nolan', 1, 'boss', 'Owner', 0, '[]', '[]');

-- --------------------------------------------------------

--
-- Structure de la table `labos`
--

CREATE TABLE `labos` (
  `id` int(11) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `enterCoords` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `limitedvehicleboutique`
--

CREATE TABLE `limitedvehicleboutique` (
  `id` int(11) NOT NULL,
  `carName` varchar(50) NOT NULL DEFAULT '0',
  `carLabel` varchar(50) NOT NULL DEFAULT '0',
  `description` varchar(50) NOT NULL DEFAULT '0',
  `limite` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `okokbanking_societies`
--

CREATE TABLE `okokbanking_societies` (
  `society` varchar(255) DEFAULT NULL,
  `society_name` varchar(255) DEFAULT NULL,
  `value` int(50) DEFAULT NULL,
  `iban` varchar(255) NOT NULL,
  `is_withdrawing` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `okokbanking_transactions`
--

CREATE TABLE `okokbanking_transactions` (
  `id` int(11) NOT NULL,
  `receiver_identifier` varchar(255) NOT NULL,
  `receiver_name` varchar(255) NOT NULL,
  `sender_identifier` varchar(255) NOT NULL,
  `sender_name` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `value` int(50) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `open_car`
--

CREATE TABLE `open_car` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `plate` varchar(11) DEFAULT NULL,
  `NB` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `open_car`
--

INSERT INTO `open_car` (`id`, `owner`, `plate`, `NB`) VALUES
(2, 'license:4df23be37a41be293441e40cf81022ad974f73fa', 'FHJE4821', 2),
(3, 'license:4df23be37a41be293441e40cf81022ad974f73fa', 'LPNH1389', 2);

-- --------------------------------------------------------

--
-- Structure de la table `owned_properties`
--

CREATE TABLE `owned_properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(50) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `state` tinyint(1) NOT NULL DEFAULT 0,
  `boutique` tinyint(1) DEFAULT 0,
  `selling` tinyint(1) DEFAULT 0,
  `carseller` int(11) DEFAULT 0,
  `stored` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `persist2_car`
--

CREATE TABLE `persist2_car` (
  `owner` varchar(255) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `vehicle` longtext NOT NULL,
  `classcar` varchar(30) NOT NULL DEFAULT '0',
  `position` varchar(255) NOT NULL,
  `heading` float NOT NULL DEFAULT 0,
  `idnetworkcar` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `persist_car`
--

CREATE TABLE `persist_car` (
  `owner` varchar(255) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `vehicle` longtext NOT NULL,
  `classcar` varchar(30) NOT NULL DEFAULT '0',
  `position` varchar(255) NOT NULL,
  `heading` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `piwel_territoires`
--

CREATE TABLE `piwel_territoires` (
  `zone` varchar(50) NOT NULL,
  `id_crew_owner` varchar(50) DEFAULT NULL,
  `crews_points` longtext NOT NULL DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `piwel_territoires`
--

INSERT INTO `piwel_territoires` (`zone`, `id_crew_owner`, `crews_points`) VALUES
('Chantier Paleto', NULL, '{}'),
('Fête Foraine', NULL, '{}'),
('Grand Senora Desert', NULL, '{}'),
('Mirror Park', NULL, '{}'),
('Paleto Forest', NULL, '{}'),
('Vinewood Boulevard', NULL, '{}');

-- --------------------------------------------------------

--
-- Structure de la table `plaintes`
--

CREATE TABLE `plaintes` (
  `identifier` varchar(50) NOT NULL DEFAULT '''''',
  `Prenom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `Nom` varchar(50) DEFAULT '',
  `Num` varchar(50) DEFAULT '',
  `Prenom1` varchar(50) DEFAULT '',
  `Nom1` varchar(50) DEFAULT '',
  `Num1` varchar(50) DEFAULT '',
  `raison` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `auteur` varchar(50) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `plaintes2`
--

CREATE TABLE `plaintes2` (
  `identifier` varchar(50) NOT NULL DEFAULT '''''',
  `Prenom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `Nom` varchar(50) DEFAULT '',
  `Num` varchar(50) DEFAULT '',
  `Prenom1` varchar(50) DEFAULT '',
  `Nom1` varchar(50) DEFAULT '',
  `Num1` varchar(50) DEFAULT '',
  `raison` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `auteur` varchar(50) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `playerstattoos`
--

CREATE TABLE `playerstattoos` (
  `identifier` varchar(50) NOT NULL,
  `tattoos` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `playerstattoos`
--

INSERT INTO `playerstattoos` (`identifier`, `tattoos`) VALUES
('license:4df23be37a41be293441e40cf81022ad974f73fa', '[]');

-- --------------------------------------------------------

--
-- Structure de la table `players_uid`
--

CREATE TABLE `players_uid` (
  `name` varchar(60) NOT NULL,
  `steam` varchar(60) NOT NULL,
  `uid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `playlists`
--

CREATE TABLE `playlists` (
  `id` int(11) NOT NULL,
  `label` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `playlist_songs`
--

CREATE TABLE `playlist_songs` (
  `id` int(11) NOT NULL,
  `playlist` int(11) DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `playtime`
--

CREATE TABLE `playtime` (
  `identifier` varchar(50) NOT NULL DEFAULT 'nil',
  `timeplayed` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `playtime`
--

INSERT INTO `playtime` (`identifier`, `timeplayed`) VALUES
('license:4df23be37a41be293441e40cf81022ad974f73fa', 900000);

-- --------------------------------------------------------

--
-- Structure de la table `properties`
--

CREATE TABLE `properties` (
  `propertyID` int(11) NOT NULL,
  `propertyOwner` varchar(100) DEFAULT '-',
  `ownerName` varchar(100) DEFAULT '-',
  `propertyLabel` varchar(100) DEFAULT NULL,
  `propertyInteriors` int(11) DEFAULT NULL,
  `propertyEntering` varchar(255) DEFAULT NULL,
  `propertyGarage` varchar(255) DEFAULT NULL,
  `propertyRented` varchar(255) DEFAULT NULL,
  `garageInteriors` int(11) DEFAULT NULL,
  `data` longtext DEFAULT '{}',
  `dataMoney` longtext DEFAULT '{"black_money":{"count":0},"cash":{"count":0}}',
  `maxStorage` int(11) DEFAULT NULL,
  `ownerList` longtext DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `properties_list`
--

CREATE TABLE `properties_list` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `isBuy` varchar(255) DEFAULT '0',
  `owner` text DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `properties_vehicles`
--

CREATE TABLE `properties_vehicles` (
  `propertyID` int(11) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `data_vehicle` longtext NOT NULL,
  `stored` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `rapports`
--

CREATE TABLE `rapports` (
  `Prenom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `Nom` varchar(50) DEFAULT '',
  `Type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `Montant` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `societies_storage`
--

CREATE TABLE `societies_storage` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `money` int(11) NOT NULL DEFAULT 0,
  `dirty_money` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `societies_storage`
--

INSERT INTO `societies_storage` (`id`, `name`, `label`, `inventory`, `money`, `dirty_money`) VALUES
(325, 'ambulance', 'Ambulance', '[]', 9490, 0),
(326, 'RaRecords', 'rarecords', '[]', 0, 0),
(327, 'appleindustrie', 'Apple Industrie', '[]', 0, 0),
(328, 'avocat', 'Avocat', '[]', 0, 0),
(329, 'chickenbell', 'ChickenBell', '[]', 0, 0),
(330, 'bcso', 'S.A.S.D', '[{\"label\":\"Argent sale\",\"count\":47518,\"name\":\"dirtycash\",\"type\":\"accounts\",\"slot\":1},{\"label\":\"Meth\",\"count\":2,\"name\":\"meth\",\"type\":\"item\",\"slot\":2},{\"label\":\"Bijoux\",\"count\":27,\"name\":\"jewels\",\"type\":\"item\",\"slot\":3},{\"label\":\"Pochon de meth\",\"count\":9,\"name\":\"meth_pooch\",\"type\":\"item\",\"slot\":4}]', 55549, 0),
(331, 'delivery', 'Delivery', '[]', 0, 0),
(332, 'fib', 'FIB', '[]', 0, 0),
(333, 'burgershot', 'BurgerShot', '[{\"name\":\"graine_weed\",\"count\":2,\"label\":\"Graine de weed\",\"slot\":2}]', 0, 0),
(334, 'churchtown', 'ChurchTown', '[]', 0, 0),
(335, 'fisherman', 'Pêcheur', '[]', 0, 0),
(336, 'fueler', 'Raffineur', '[]', 0, 0),
(337, 'gouv', 'Gouvernement', '[]', 0, 0),
(338, 'jardinier', 'Jardinier', '[]', 0, 0),
(339, 'boatseller', 'Concessionnaire Bénéteau', '[]', 0, 0),
(340, 'journalist', 'Journaliste', '[]', 0, 0),
(341, 'label', 'RA Records', '[]', 0, 0),
(342, 'lumberjack', 'Bûcheron', '[]', 0, 0),
(343, 'mecano', 'Benny\'s', '[]', 359530, 0),
(344, 'mecano2', 'Ls Custom', '[]', 70003, 0),
(345, 'miner', 'Mineur', '[]', 0, 0),
(346, 'planeseller', 'Concessionnaire Aéronotique', '[]', 0, 0),
(347, 'police', 'Police', '[]', 2496, 0),
(348, 'realestateagent', 'Agent immobilier', '[]', 299999, 0),
(349, 'slaughterer', 'Abateur', '[]', 0, 0),
(350, 'tacos', 'Tacos', '[]', 0, 0),
(351, 'tailor', 'Couturier', '[]', 0, 0),
(352, 'taxi', 'Taxi', '[]', 0, 0),
(353, 'tequilala', 'Tequilala', '[]', 0, 0),
(354, 'unicorn', 'Unicorn', '[]', 1998, 0),
(355, 'vigneron', 'Vigneron', '[]', 0, 0),
(356, 'cardealer', 'Concessionnaire', '[]', 1888047, 0),
(357, 'chantier', 'Chantier', '[]', 0, 0),
(358, 'mineur', 'Mineur', '[]', 0, 0),
(35487, 'bahamas', 'Bahamas', '[]', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `staff`
--

CREATE TABLE `staff` (
  `name` text NOT NULL,
  `license` varchar(50) NOT NULL,
  `evaluation` text NOT NULL,
  `report` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `staff`
--

INSERT INTO `staff` (`name`, `license`, `evaluation`, `report`) VALUES
('usse', 'license:4df23be37a41be293441e40cf81022ad974f73fa', '[]', '0');

-- --------------------------------------------------------

--
-- Structure de la table `starterpack`
--

CREATE TABLE `starterpack` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `account_info` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `starterpack`
--

INSERT INTO `starterpack` (`id`, `name`, `account_info`, `description`, `created_at`, `updated_at`) VALUES
(0, 'usse', '9860094', NULL, '2025-01-27 18:03:30', '2025-01-27 18:03:30');

-- --------------------------------------------------------

--
-- Structure de la table `tebex_accounts`
--

CREATE TABLE `tebex_accounts` (
  `steam` varchar(50) NOT NULL DEFAULT '0',
  `fivem` varchar(50) NOT NULL DEFAULT '0',
  `vip` tinyint(4) NOT NULL DEFAULT 0,
  `expiration` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `tebex_accounts`
--

INSERT INTO `tebex_accounts` (`steam`, `fivem`, `vip`, `expiration`) VALUES
('4df23be37a41be293441e40cf81022ad974f73fa', '9860094', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `tebex_commands`
--

CREATE TABLE `tebex_commands` (
  `id` int(11) NOT NULL,
  `fivem` varchar(50) NOT NULL DEFAULT '0',
  `command` varchar(50) NOT NULL DEFAULT '0',
  `argument` varchar(50) NOT NULL DEFAULT '0',
  `transaction` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `tebex_fidelite`
--

CREATE TABLE `tebex_fidelite` (
  `id` int(11) NOT NULL,
  `license` varchar(255) NOT NULL DEFAULT '0',
  `havebuy` int(11) NOT NULL DEFAULT 0,
  `totalbuy` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `tebex_fidelite`
--

INSERT INTO `tebex_fidelite` (`id`, `license`, `havebuy`, `totalbuy`) VALUES
(1, 'license:4df23be37a41be293441e40cf81022ad974f73fa', 0, 0),
(2, 'license:4df23be37a41be293441e40cf81022ad974f73fa', 0, 0),
(3, 'license:4df23be37a41be293441e40cf81022ad974f73fa', 0, 0),
(4, 'license:4df23be37a41be293441e40cf81022ad974f73fa', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `tebex_logs_commands`
--

CREATE TABLE `tebex_logs_commands` (
  `id` int(11) NOT NULL,
  `fivem` varchar(50) NOT NULL DEFAULT '0',
  `command` varchar(50) NOT NULL DEFAULT '0',
  `argument` varchar(50) NOT NULL DEFAULT '0',
  `transaction` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `tebex_players_wallet`
--

CREATE TABLE `tebex_players_wallet` (
  `identifiers` text NOT NULL,
  `transaction` text DEFAULT NULL,
  `price` text NOT NULL,
  `currency` text DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `tebex_players_wallet`
--

INSERT INTO `tebex_players_wallet` (`identifiers`, `transaction`, `price`, `currency`, `points`, `created_at`, `updated_at`) VALUES
('9860094', 'Ajout GoodCoins du StarterPack', '0', 'Points', 1500, '2025-01-27 19:03:30', '2025-01-27 19:03:30');

-- --------------------------------------------------------

--
-- Structure de la table `trunk_inventory`
--

CREATE TABLE `trunk_inventory` (
  `id` int(11) NOT NULL,
  `vehicleModel` int(11) NOT NULL DEFAULT 0,
  `vehiclePlate` varchar(50) NOT NULL,
  `items` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `character_id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `fivem` varchar(50) DEFAULT NULL,
  `permission_group` varchar(50) DEFAULT 'user',
  `permission_level` int(11) DEFAULT 0,
  `position` longtext DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `accounts` longtext DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `clothes` longtext DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `job2` varchar(50) DEFAULT 'unemployed2',
  `job2_grade` int(11) DEFAULT 0,
  `isDead` int(11) DEFAULT 0,
  `status` longtext DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dateofbirth` varchar(25) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `height` varchar(5) DEFAULT NULL,
  `statistics` longtext DEFAULT NULL,
  `iban` varchar(255) DEFAULT NULL,
  `pincode` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`character_id`, `identifier`, `discord`, `fivem`, `permission_group`, `permission_level`, `position`, `skin`, `accounts`, `inventory`, `clothes`, `job`, `job_grade`, `job2`, `job2_grade`, `isDead`, `status`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `statistics`, `iban`, `pincode`) VALUES
(1, 'license:4df23be37a41be293441e40cf81022ad974f73fa', '625327572997373953', '9860094', 'fondateur', 0, '{\"z\":43.20000076293945,\"x\":118.0,\"y\":-523.5}', '{\"lipstick_4\":0,\"watches_2\":0,\"sun_1\":0,\"beard_4\":0,\"bodyb_2\":0,\"chain_1\":0,\"eyebrows_3\":0,\"tshirt_1\":0,\"beard_1\":0,\"bproof_2\":0,\"moles_1\":0,\"age_2\":0,\"sex\":0,\"hair_1\":80,\"lipstick_2\":0,\"decals_1\":0,\"watches_1\":-1,\"torso_2\":2,\"bags_1\":0,\"sun_2\":0,\"decals_2\":0,\"age_1\":0,\"torso_1\":7,\"face\":45,\"helmet_1\":-1,\"helmet_2\":0,\"lipstick_1\":0,\"bracelets_2\":0,\"hair_color_1\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"tshirt_2\":4,\"bags_2\":0,\"arms_2\":0,\"makeup_3\":0,\"bproof_1\":0,\"shoes_2\":0,\"blush_3\":0,\"chest_2\":0,\"bracelets_1\":-1,\"blemishes_1\":0,\"beard_3\":0,\"glasses_1\":0,\"eye_color\":0,\"blush_2\":0,\"lipstick_3\":0,\"complexion_2\":0,\"ears_2\":0,\"eyebrows_4\":0,\"chest_1\":0,\"hair_2\":0,\"blemishes_2\":0,\"ears_1\":-1,\"chest_3\":0,\"beard_2\":0,\"makeup_1\":0,\"hair_color_2\":0,\"pants_2\":0,\"chain_2\":0,\"eyebrows_2\":0,\"complexion_1\":0,\"mask_2\":0,\"arms\":1,\"makeup_4\":0,\"mask_1\":0,\"skin\":41,\"shoes_1\":7,\"blush_1\":0,\"glasses_2\":0,\"moles_2\":0,\"bodyb_1\":0,\"pants_1\":5}', '[{\"name\":\"bank\",\"money\":12500},{\"name\":\"chip\",\"money\":0},{\"name\":\"crypto\",\"money\":0}]', '{\"main\":[{\"name\":\"cash\",\"count\":11900,\"label\":\"Argent\",\"slot\":8,\"type\":\"accounts\"},{\"id\":\"7479-8291\",\"name\":\"idcard\",\"slot\":13,\"count\":1,\"label\":\"Carte Identité\",\"type\":\"item\",\"args\":{\"antiActions\":\"idCard\"}}],\"weapons\":[]}', '[]', 'unemployed', 0, 'unemployed2', 0, 0, '{\"hunger\":965900,\"thirst\":974425}', 'Moussa', 'Zaza', '04/05/3000', 'm', '330', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `user_tenue`
--

CREATE TABLE `user_tenue` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `tenue` longtext NOT NULL,
  `label` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `vdaaccess`
--

CREATE TABLE `vdaaccess` (
  `license` varchar(50) NOT NULL,
  `lvl` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `vehicleclaimsell`
--

CREATE TABLE `vehicleclaimsell` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `model` varchar(60) NOT NULL,
  `name` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `vehicles`
--

INSERT INTO `vehicles` (`model`, `name`, `price`, `category`) VALUES
('Ubermatch Sentinel XS', 'Benefactor Dubsta 6x6', 250000, 'offroad'),
('adder', 'Truffade Adder', 250000, 'super'),
('akuma', 'Dinka Akuma ', 3750, 'motorcycles'),
('alpha', 'Albany Alpha', 22500, 'sports'),
('asbo', 'Maxwell Asbo', 10000, 'compacts'),
('asea', 'Declasse Asea', 6250, 'sedans'),
('asterope', 'Karin Asterope', 12500, 'sedans'),
('astron', 'Pfister Astron', 75000, 'suvs'),
('autarch', 'Overflod Autarch', 450000, 'super'),
('avarus', 'Liberty City Cycles Avarus', 12500, 'motorcycles'),
('bagger', 'Bagger', 10000, 'motorcycles'),
('baller', 'Gallivanter Baller LE LWB', 17500, 'suvs'),
('baller2', 'Gallivanter Baller LE', 25000, 'suvs'),
('baller4', 'Gallivanter Baller LE LWB Custom', 37500, 'suvs'),
('baller7', 'Gallivanter Baller ST', 65000, 'suvs'),
('banshee', 'Bravado Banshee', 25000, 'sports'),
('banshee2', 'Banshee Custom', 75000, 'super'),
('bati', 'Pegassi Bati 801', 13750, 'motorcycles'),
('bati2', 'Pegassi Bati 801', 16250, 'motorcycles'),
('bestiagts', 'Grotti Bestia GTS', 20000, 'sports'),
('bf400', 'Nagasaki BF400', 10000, 'motorcycles'),
('bfinjection', 'BF Injection', 1500, 'offroad'),
('bifta', 'BF Bifta', 10000, 'offroad'),
('bison', 'Bravado Bison', 12500, 'vans'),
('bjxl', 'BeeJay XL', 17500, 'suvs'),
('blade', 'Vapid Blade', 5500, 'muscle'),
('blazer', 'Nagasaki Blazer', 1500, 'offroad'),
('blazer3', 'Hot Rod Blazer', 8750, 'offroad'),
('blazer4', 'Blazer Street', 13750, 'offroad'),
('blista', 'Dinka Blista', 6250, 'compacts'),
('blista2', 'Blista Compact', 20000, 'sports'),
('bobcatxl', 'Vapid Bobcat XL', 9000, 'vans'),
('bodhi2', 'Bodhi', 13750, 'offroad'),
('brawler', 'Coil Brawler', 32500, 'offroad'),
('brioso', 'Grotti Brioso R/A', 17750, 'compacts'),
('brioso2', 'Brioso', 22500, 'compacts'),
('btype', 'B Type', 50000, 'sportsclassics'),
('btype2', 'Btype2 Hotrood Sedan', 55000, 'sportsclassics'),
('btype3', 'Roosevelt Valor', 62500, 'sportsclassics'),
('buccaneer', 'Albany Buccaneer', 7500, 'muscle'),
('buccaneer2', 'Buccaneer Custom', 12500, 'muscle'),
('buffalo', 'Bravado Buffalo', 12500, 'sports'),
('buffalo2', 'Bravado Buffalo S', 18750, 'sports'),
('bullet', 'Vapid Bullet', 75000, 'super'),
('burrito3', 'Burrito', 15000, 'vans'),
('calico', 'Karin Calico GTF', 23750, 'sports'),
('camper', 'Brute Camper', 30000, 'vans'),
('caracara2', 'Vapid 4x4 Caracara', 125000, 'offroad'),
('carbonizzare', 'Grotti Carbonizzare', 40000, 'sports'),
('carbonrs', 'Nagasaki Carbon RS', 12000, 'motorcycles'),
('casco', 'Lampadati Casco', 32500, 'sportsclassics'),
('cavalcade', 'Albany Cavalcade', 10000, 'suvs'),
('cavalcade2', 'Albany Cavalcade', 12500, 'suvs'),
('cheburek', 'RUNE Cheburek', 22500, 'sportsclassics'),
('cheetah', 'Grotti Cheetah', 500000, 'super'),
('cheetah2', 'Grotti Cheetah Classic', 125000, 'sportsclassics'),
('chimera', 'Nagasaki Chimera', 22500, 'motorcycles'),
('chino', 'Vapid Chino', 7500, 'muscle'),
('chino2', 'Chino Custom', 11250, 'muscle'),
('cinquemila', 'Lampadati Cinquemila', 42500, 'sports'),
('cliffhanger', 'Cliffhanger', 21250, 'motorcycles'),
('clique', 'Vapid Clique', 7500, 'muscle'),
('club', 'BF Club', 6250, 'compacts'),
('cog55', 'Enus Cognoscenti 55', 10000, 'sedans'),
('cogcabrio', 'Enus Cognoscenti Cabrio', 25000, 'coupes'),
('cognoscenti', 'Enus Cognoscenti', 32500, 'sedans'),
('comet2', 'Pfister Comet', 25000, 'sports'),
('comet3', 'Pfister Comet Rétro Custom', 37500, 'sports'),
('comet5', 'Pfister Comet SR', 25000, 'sports'),
('comet6', 'Pfister Comet S2', 57500, 'sports'),
('comet7', 'Pfister Comet S2 Cabrio', 87500, 'sports'),
('contender', 'Vapid Contender', 75000, 'suvs'),
('coquette3', 'Invetero Coquette', 30000, 'muscle'),
('coquette4', 'Invetero Coquette', 500000, 'sports'),
('cuban800', 'Cuban 800', 450000, 'avionfdp'),
('cyclone', 'oil Cyclone', 750000, 'super'),
('cypher', 'Ubermacht Cypher', 25000, 'sports'),
('daemon', 'Daemon', 10500, 'motorcycles'),
('daemon2', 'Daemon', 21250, 'motorcycles'),
('defiler', 'Shitzu Defiler', 15000, 'motorcycles'),
('deveste', 'Principe Deveste Eight', 875000, 'sports'),
('deviant', 'Schyster Deviant', 35000, 'muscle'),
('diablous', 'Diablous', 17500, 'motorcycles'),
('diablous2', 'Diablous', 22500, 'motorcycles'),
('dilettante', 'Karin Dilettante', 5000, 'compacts'),
('dinghy', 'Nagasaki Dinghy', 300000, 'superboat'),
('dloader', 'Bravado Duneloader', 12500, 'offroad'),
('dodo', 'Mammoth Dodo', 500000, 'avionfdp'),
('dominator', 'Vapid Dominator', 15000, 'muscle'),
('dominator3', 'Vapid Dominator GTX', 37500, 'muscle'),
('dominator7', 'Vapid Dominator ASP', 60000, 'muscle'),
('double', 'Dinka Double T', 11250, 'motorcycles'),
('drafter', 'Obey 8F Drafter', 75000, 'sports'),
('draugur', 'Declasse Draugur', 125000, 'offroads'),
('dubsta', 'Benefactor Dubsta', 50000, 'suvs'),
('dubsta2', 'Benefactor Dubsta', 60000, 'suvs'),
('dukes', 'Imponte Dukes', 10000, 'muscle'),
('dune', 'BF Dune Buggy', 6250, 'offroad'),
('dynasty', 'Weeny Dynasty', 17500, 'sportsclassics'),
('elegy', 'Annis Elegy RH8 Retro Custom', 100000, 'sports'),
('elegy2', 'Annis Elegy RH8', 10000, 'sports'),
('ellie', 'Vapid Ellie', 10000, 'muscle'),
('emerus', 'Progen Emerus', 425000, 'super'),
('emperor', 'Albany Emperor', 6250, 'sedans'),
('enduro', 'Dinka Enduro', 10000, 'motorcycles'),
('entity2', 'Entity XXR', 750000, 'super'),
('entityxf', 'Overflod Entity XF', 225000, 'super'),
('esskey', 'Pegassi Esskey', 12500, 'motorcycles'),
('euros', 'Annis Euros', 20000, 'sports'),
('everon', 'Karin Everon', 200000, 'offroad'),
('exemplar', 'Dewbauchee Exemplar', 33750, 'coupes'),
('f620', 'Ocelot F620', 18750, 'coupes'),
('faction', 'Willard Faction', 6250, 'muscle'),
('faction2', 'Faction Custom', 21250, 'muscle'),
('faction3', 'Faction Custom', 26250, 'muscle'),
('fagaloa', 'Vulcar Fagaloa', 16250, 'sportsclassics'),
('faggio', 'Faggio', 1000, 'motorcycles'),
('faggio2', 'Faggio', 1000, 'motorcycles'),
('faggio3', 'Faggio', 1000, 'motorcycles'),
('fcr', 'Pegassi FCR 1000', 18750, 'motorcycles'),
('fcr2', 'Pegassi FCR 1000', 21250, 'motorcycles'),
('felon', 'Lampadati Felon', 8750, 'coupes'),
('feltzer2', 'Benefactor Feltzer', 23750, 'sports'),
('feltzer3', 'Feltzer Clasique', 4000000, 'sportsclassics'),
('flashgt', 'Vapid Flash GT', 62500, 'sports'),
('fmj', 'Vapid FMJ', 30000, 'super'),
('freecrawler', 'Canis Freecrawler', 75000, 'offroad'),
('frogger', 'Maibatsu Frogger', 750000, 'avionfdp'),
('fugitive', 'Cheval Fugitive', 12500, 'sedans'),
('furia', 'Grotti Furia', 62500, 'super'),
('furoregt', 'Lampadati Furore GT', 17500, 'sports'),
('fusilade', 'Schyster Fusilade', 16250, 'sports'),
('futo', 'Karin Futo', 7500, 'sports'),
('futo2', 'Futo GTX', 23750, 'sports'),
('gargoyle', 'Gargoyle', 32500, 'motorcycles'),
('gauntlet', 'Bravado Gauntlet', 13750, 'muscle'),
('gauntlet3', 'Bravado Gauntlet Classic', 16250, 'muscle'),
('gauntlet4', 'Bravado Gauntlet Hellfire', 23750, 'muscle'),
('gb200', 'Vapid GB 200', 25000, 'sports'),
('gburrito', 'Burrito de gang', 15000, 'suvs'),
('glendale', 'Benefactor Glendale', 16250, 'sedans'),
('glendale2', 'Benefactor Glendale', 18750, 'sedans'),
('gp1', 'Progen GP1', 27500, 'super'),
('granger', 'Declasse Granger', 20000, 'suvs'),
('greenwood', 'Bravado Greenwood', 30000, 'muscle'),
('gresley', 'Bravado Gresley', 7500, 'suvs'),
('growler', 'Pfister Growler', 125000, 'sports'),
('gt500', 'Grotti GT500', 22500, 'sportsclassics'),
('guardian', 'Guardian', 62500, 'suvs'),
('habanero', 'Emperor Habanero', 6250, 'suvs'),
('hakuchou', 'Shitzu Hakuchou', 18250, 'motorcycles'),
('hakuchou2', 'Shitzu Hakuchou Drag', 68750, 'motorcycles'),
('hellion', 'Annis Hellion', 37500, 'offroad'),
('hermes', 'Albany Hermes', 22500, 'muscle'),
('hexer', 'Hexer', 16250, 'motorcycles'),
('hotknife', 'Vapid Hotknife', 10000, 'muscle'),
('hotring', 'Declasse Hotring Sabre', 31250, 'sports'),
('howard', 'Buckingham Howard NX-25', 1200000, 'avionfdp'),
('huntley', 'Enus Huntley S', 7500, 'suvs'),
('hustler', 'Vapid Hustler', 10000, 'muscle'),
('ignus', 'Pegassi Ignus', 625000, 'super'),
('imorgon', 'Overflod Imorgon', 47500, 'sports'),
('impaler', 'Declasse Impaler', 6250, 'muscle'),
('infernus', 'Pegassi Infernus', 10000, 'super'),
('infernus2', 'Pegassi Infernus classic', 125000, 'sportsclassics'),
('ingot', 'Vulcar Ingot', 5000, 'sedans'),
('innovation', 'Liberty City Cycles Hexer', 17500, 'motorcycles'),
('intruder', 'Karin Intruder', 10000, 'sedans'),
('issi2', 'Weeny Issi', 4000, 'compacts'),
('issi3', 'Weeny Issi Classic', 13000, 'compacts'),
('issi7', 'Issi Sport', 14000, 'sports'),
('italigtb', 'Progen Itali GTB', 100000, 'super'),
('italigtb2', 'Progen Itali GTB Custom', 85000, 'super'),
('italigto', 'Grotti Itali GTO', 400000, 'sports'),
('italirsx', 'Grotti Itali RSX', 500000, 'sports'),
('iwagen', 'Obey I-Wagen', 62500, 'suvs'),
('jackal', 'Ocelot Jackal', 30000, 'coupes'),
('jester', 'Dinka Jester', 25000, 'sports'),
('jester2', 'Dinka Jester', 25000, 'sports'),
('jester3', 'Dinka Jester Classic', 75000, 'sports'),
('jester4', 'Dinka Jester RR', 37500, 'sports'),
('jetmax', 'Shitzu Jetmax', 250000, 'superboat'),
('journey', 'Zirconium Journey', 6250, 'vans'),
('jugular', 'Ocelot Jugular', 450000, 'sports'),
('kalahari', 'Canis Kalahari', 4000, 'offroad'),
('kamacho', 'Canis Kamacho', 250000, 'offroad'),
('kanjo', 'Dinka Blista Kanjo', 7500, 'compacts'),
('kanjosj', 'Dinka KanjoSJ', 10000, 'coupes'),
('khamelion', 'Hijak Khamelion', 16250, 'sports'),
('komoda', 'Lampadati Komoda', 50000, 'sports'),
('krieger', 'Benefactor Krieger', 750000, 'super'),
('landstalker', 'Dundreary Landstalker', 6250, 'suvs'),
('landstalker2', 'Dundreary Landstalker', 11250, 'suvs'),
('le7b', 'RE-7B', 750000, 'super'),
('lectro', 'Principe Lectro', 50000, 'motorcycles'),
('lm87', 'Benefactor Lm87', 750000, 'super'),
('locust', 'Ocelot Locust', 37500, 'sports'),
('longfin', 'Shitzu Longfin', 350000, 'superboat'),
('lurcher', 'Albany Lurcher', 8750, 'muscle'),
('luxor', 'Buckingham Luxor', 6000000, 'avionfdp'),
('luxor2', 'Buckingham Luxor Deluxe', 7500000, 'avionfdp'),
('lynx', 'Ocelot Lynx', 21250, 'sports'),
('mammatus', 'JoBuilt Mammatus', 325000, 'avionfdp'),
('mamoa', 'Declasse Mamba', 225000, 'sportsclassics'),
('manana', 'Albany Manana', 25000, 'sportsclassics'),
('manana2', 'Albany Manana Custom', 25000, 'sportsclassics'),
('manchez', 'Maibatsu Manchez', 12500, 'motorcycles'),
('manchez2', 'MMaibatsu Manchez Black', 16250, 'motorcycles'),
('marquis', 'Dinka Marquis', 450000, 'superboat'),
('massacro', 'Dewbauchee Massacro', 23750, 'sports'),
('maverick', 'Buckingham Maverick', 500000, 'avionfdp'),
('mesa', 'Canis Mesa', 50000, 'suvs'),
('mesa3', 'Canis Mesa Custom', 67500, 'offroad'),
('michelli', 'Michelli GT', 32500, 'sportsclassics'),
('minivan', 'Vapid Minivan', 12500, 'vans'),
('monroe', 'Pegassi Monroe', 17500, 'sportsclassics'),
('moonbeam', 'Declasse Moonbeam', 15000, 'muscle'),
('moonbeam2', 'Declasse Moonbeam Custom', 21250, 'muscle'),
('nebula', 'Vulcar Nebula Turbo', 17000, 'sportsclassics'),
('nemesis', 'Principe Nemesis', 8750, 'motorcycles'),
('neo', 'Vysser Neo', 35000, 'sports'),
('neon', 'Pfister Neon', 225000, 'sports'),
('nero', 'Truffade Nero', 550000, 'super'),
('nero2', 'Truffade Nero Custom', 1250000, 'super'),
('nightblade', 'Nightblade', 27500, 'motorcycles'),
('nightshade', 'Imponte Nightshade', 25000, 'muscle'),
('nimbus', 'Buckingham Nimbus', 1400000, 'avionfdp'),
('ninef', 'Obey 9F', 16250, 'sports'),
('novak', 'Lampadati Novak', 87500, 'suvs'),
('omnis', 'Obey Omnis', 12500, 'sports'),
('oracle', 'Ubermacht Oracle XS', 11250, 'coupes'),
('oracle2', 'Ubermacht Oracle ', 18750, 'coupes'),
('osiris', 'Pegassi Osiris', 187500, 'super'),
('outlaw', 'Nagasaki Outlaw', 175000, 'offroad'),
('panto', 'Benefactor Panto', 3750, 'compacts'),
('paragon', 'nus Paragon R', 200000, 'sports'),
('pariah', 'Ocelot Pariah', 250000, 'sports'),
('patriot', 'Mammoth Patriot', 15000, 'suvs'),
('patriot2', 'Mammoth Patriot Limo', 31250, 'suvs'),
('patriot3', 'Mammoth Patriot Mil-Spec', 112500, 'suvs'),
('pcj', 'Shitzu PCJ 600', 6250, 'motorcycles'),
('penetrator', 'Ocelot Penetrator', 31000, 'super'),
('penumbra', 'Maibatsu Penumbra', 16250, 'sports'),
('penumbra2', 'Maibatsu Penumbra', 18750, 'sports'),
('peyote', 'Vapid Peyote', 18750, 'sportsclassics'),
('peyote2', 'Peyote Gasser', 22500, 'muscle'),
('peyote3', 'Vapid Peyote Custom', 18750, 'sportsclassics'),
('pfister811', 'Pfister 811', 245000, 'super'),
('phoenix', 'Imponte Phoenix', 7500, 'muscle'),
('picador', 'Cheval Picador', 5000, 'muscle'),
('pigalle', 'Lampadati Pigalle', 23500, 'sportsclassics'),
('postlude', 'Dinka Postlude', 7500, 'coupes'),
('prairie', 'Bollokan Prairie', 6750, 'compacts'),
('premier', 'Declasse Premier', 6250, 'sedans'),
('previon', 'Karin Previon', 42500, 'coupes'),
('primo', 'Albany Primo ', 11250, 'sedans'),
('primo2', 'Primo Custom', 33750, 'sedans'),
('prototipo', 'Grotti X80 Proto', 625000, 'super'),
('radi', 'Vapid Radius', 9000, 'suvs'),
('raiden', 'Coil Raiden', 52500, 'sports'),
('rancherxl', 'Declasse Rancher XL', 5500, 'offroad'),
('rapidgt', 'Dewbauchee Rapid GT', 47500, 'sports'),
('rapidgt3', 'Rapid GT Classic', 23500, 'sportsclassics'),
('raptor', 'BF Raptor', 25000, 'sports'),
('ratbike', 'Ratbike', 7500, 'motorcycles'),
('ratloader2', 'Bravado Rat-Loader', 3750, 'muscle'),
('reaper', 'Pegassi Reaper', 90000, 'super'),
('rebel', 'Karin Rebel', 7500, 'offroad'),
('rebla', 'Ubermacht Rebla GTS', 125000, 'suvs'),
('reever', 'Western Reever', 13750, 'motorcycles'),
('regina', 'Dundreary Regina', 5000, 'sedans'),
('remus', 'Annis Remus', 22500, 'sports'),
('retinue', 'Vapid Retinue', 18750, 'sportsclassics'),
('retinue2', 'Vapid Retinue Mk II', 18750, 'sportsclassics'),
('rhapsody', 'Declasse Rhapsody', 6250, 'compacts'),
('rhinehart', 'Rhinehart', 200000, 'sedans'),
('riata', 'Vapid Riata', 11250, 'offroad'),
('rocoto', 'Obey Rocoto', 7500, 'suvs'),
('rrocket', 'Rampant Rocket', 60000, 'motorcycles'),
('rt3000', 'Dinka RT3000', 30000, 'sports'),
('ruffian', 'Pegassi Ruffian', 10000, 'motorcycles'),
('ruiner', 'Imponte Ruiner', 3750, 'muscle'),
('ruiner4', 'Imponte Ruiner ZZ-8', 20000, 'muscle'),
('rumpo', 'Bravado Rumpo', 18750, 'vans'),
('rumpo3', 'Bravado Rumpo Custom', 31250, 'vans'),
('ruston', 'Hijak Ruston', 18750, 'sports'),
('s80', 'Annis S80RR', 300000, 'super'),
('sabregt', 'Declasse Sabre Turbo', 11250, 'muscle'),
('sabregt2', 'Sabre Turbo Custom', 13750, 'muscle'),
('sanchez', 'Maibatsu Sanchez', 3750, 'motorcycles'),
('sanctus', 'Liberty City Cycles Sanctus', 21250, 'motorcycles'),
('sandking', 'Vapid Sandking XL', 20000, 'offroad'),
('sandking2', 'Sandking XL', 25000, 'offroad'),
('sc1', 'Ubermacht SC1', 25000, 'super'),
('schafter2', 'Schafter V12', 18750, 'sports'),
('schafter3', 'Schafter V12', 75000, 'sports'),
('schafter4', 'Schafter V12 LWB', 81250, 'sports'),
('schlagen', 'Benefactor Schlagen GT', 181250, 'sports'),
('schwarzer', 'Benefactor Schwartzer', 25000, 'sports'),
('seabreeze', 'Seabreeze', 1300000, 'avionfdp'),
('seashark', 'Speedophile Seashark', 75000, 'superboat'),
('seminole', 'Canis Seminole', 6750, 'suvs'),
('seminole2', 'Canis Seminole', 17500, 'suvs'),
('sentinel', 'Ubermacht Sentinel XS', 16250, 'coupes'),
('sentinel2', 'Ubermacht Sentinel', 18750, 'coupes'),
('sentinel3', 'Ubermacht Sentinel Classic', 5000, 'sports'),
('serrano', 'Benefactor Serrano', 6250, 'suvs'),
('seven70', 'Dewbauchee Seven-70', 16250, 'sports'),
('sheava', 'Emperor ETR1', 91500, 'super'),
('shinobi', 'Nagasaki Shinobi', 18750, 'motorcycles'),
('slamvan', 'Vapid Slamvan', 18750, 'muscle'),
('slamvan2', 'Vapid Slamvan', 26250, 'muscle'),
('slamvan3', 'Vapid Slamvan Custom', 38750, 'muscle'),
('specter', 'Dewbauchee Specter', 16250, 'sports'),
('specter2', 'Specter Custom', 16250, 'sports'),
('speeder', 'Pegassi Speeder', 275000, 'superboat'),
('speedo', 'Vapid Speedo', 12500, 'vans'),
('squaddie', 'Squaddie', 15000, 'suvs'),
('squalo', 'Squalo', 175000, 'superboat'),
('stafford', 'Enus Stafford', 62500, 'sedans'),
('stalion', 'Declasse Stallion', 18750, 'muscle'),
('stanier', 'Vapid Stanier', 8250, 'sedans'),
('stinger', 'Grotti Stinger', 28000, 'sportsclassics'),
('stingergt', 'Grotti Stinger GT', 60000, 'sportsclassics'),
('stratum', 'Zirconium Stratum', 6250, 'sedans'),
('streiter', 'Benefactor Streiter', 31250, 'sports'),
('stretch', 'Dundreary Stretch', 75000, 'sedans'),
('stryder', 'Nagasaki Stryder', 38750, 'motorcycles'),
('sugoi', 'Dinka Sugoi', 62500, 'sports'),
('sultan', 'Karin Sultan 1', 21250, 'sports'),
('sultan2', 'Karin Sultan 2', 21250, 'sports'),
('sultan3', 'Karin Sultan 3', 21250, 'sports'),
('sultanrs', 'Karin Sultan RS', 57500, 'super'),
('suntrap', 'Shitzu Squalo', 200000, 'superboat'),
('superd', 'Enus Super Diamond', 75000, 'sedans'),
('supervolito', 'Buckingham SuperVolito', 1500000, 'avionfdp'),
('supervolito2', 'Buckingham SuperVolito Carbon', 1800000, 'avionfdp'),
('surano', 'Benefactor Surano', 11750, 'sports'),
('surfer', 'BF Surfer', 12500, 'vans'),
('surge', 'Cheval Surge', 7500, 'sedans'),
('swift', 'Buckingham Swift', 4000000, 'avionfdp'),
('swift2', 'Buckingham Swift Deluxe', 4250000, 'avionfdp'),
('swinger', 'Ocelot Swinger', 169500, 'sportsclassics'),
('t20', 'Progen T20', 312500, 'super'),
('tailgater', 'Obey Tailgater', 21250, 'sedans'),
('tailgater2', 'Obey Tailgater S', 42250, 'sedans'),
('taipan', 'Cheval Taipan', 202500, 'super'),
('tampa', 'Declasse Tampa', 42500, 'muscle'),
('tampa2', 'Declasse Tampa drift', 71250, 'sports'),
('tempesta', 'Pegassi Tempesta', 335000, 'super'),
('tezeract', 'Pegassi Tezeract', 775000, 'super'),
('thrax', 'Truffade Thrax', 635000, 'super'),
('thrust', 'Dinka Thrust', 18750, 'motorcycles'),
('tigon', 'Lampadati Tigon', 87500, 'super'),
('torero', 'Pegassi Torero', 62500, 'sportsclassics'),
('tornado', 'Declasse Tornado', 10500, 'sportsclassics'),
('toro', 'Lampadati Toro', 300000, 'superboat'),
('toros', 'Pegassi Toros', 125000, 'suvs'),
('trophytruck', 'Vapid Trophy Truck', 33250, 'offroad'),
('trophytruck2', 'Vapid Trophy Truck', 33750, 'offroad'),
('tropic', 'Tropic', 125000, 'superboat'),
('tropos', 'Lampadati Tropos rallye', 31250, 'sports'),
('tulip', 'Declasse Tulip', 34000, 'muscle'),
('turismo2', 'Grotti Turismo Classic', 131000, 'sportsclassics'),
('turismor', 'Grotti Turismo R', 62500, 'super'),
('tyrant', 'Overflod Tyrant', 280000, 'super'),
('tyrus', 'Progen Tyrus', 327500, 'super'),
('vacca', 'Pegassi Vacca', 30500, 'super'),
('vader', 'Shitzu Vader', 6250, 'motorcycles'),
('vagner', 'Dewbauchee Vagner', 500000, 'super'),
('vagrant', 'Maxwell Vagrant', 33750, 'offroad'),
('vamos', 'Declasse Vamos', 8750, 'muscle'),
('vectre', 'Emperor Vectre', 13750, 'sports'),
('velum', 'JoBuilt Velum', 300000, 'avionfdp'),
('verlierer2', 'Bravado Verlierer', 33750, 'sports'),
('verus', 'Dinka Verus', 31250, 'offroad'),
('vestra', 'Buckingham Vestra', 380000, 'avionfdp'),
('vigero', 'Declasse Vigero', 12500, 'muscle'),
('vindicator', 'Dinka Vindicator', 40000, 'motorcycles'),
('virgo', 'Albany Virgo', 16000, 'muscle'),
('virgo2', 'Albany Virgo Custom', 21000, 'muscle'),
('virgo3', 'Albany Virgo Custom', 22500, 'muscle'),
('visione', 'Grotti Visione', 775000, 'super'),
('volatus', 'Buckingham Volatus', 3000000, 'avionfdp'),
('voltic', 'Coil Voltic', 57750, 'super'),
('voodoo', 'Declasse Voodoo custom', 12500, 'muscle'),
('vortex', 'Pegassi Vortex', 45000, 'motorcycles'),
('vstr', 'Albany V-STR', 225000, 'sports'),
('warrener', 'Vulcar Warrener', 5500, 'sedans'),
('washington', 'Albany Washington', 11250, 'sedans'),
('weevil', 'BF Weevil', 21250, 'compacts'),
('windsor', 'Enus Windsor', 125000, 'coupes'),
('windsor2', 'Windsor Drop', 100000, 'coupes'),
('winky', 'Vapid Winky', 62500, 'offroad'),
('wolfsbane', 'Wolfsbane', 23750, 'motorcycles'),
('xa21', 'Ocelot XA-21', 475000, 'super'),
('xls', 'Benefactor XLS', 17500, 'suvs'),
('yosemite', 'Declasse Yosemite', 11250, 'muscle'),
('yosemite2', 'Declasse Drift Yosemite', 22500, 'muscle'),
('yosemite3', 'Yosemite', 8750, 'muscle'),
('youga', 'Bravado Youga', 18750, 'vans'),
('youga2', 'Bravado Youga Classic', 21250, 'vans'),
('youga3', 'Bravado Youga Classic 4x4', 25000, 'vans'),
('youga4', 'Youga Custom', 17500, 'vans'),
('z190', 'Karin 190z', 67500, 'sportsclassics'),
('zeno', 'Overflod Zeno', 575000, 'super'),
('zentorno', 'Pegassi Zentorno', 200000, 'super'),
('zion', 'Ubermacht Zion', 15000, 'coupes'),
('zion2', 'Ubermacht Zion', 15000, 'coupes'),
('zion3', 'Ubermacht Zion Classic', 67500, 'sportsclassics'),
('zombiea', 'Zombie', 25000, 'motorcycles'),
('zombieb', 'Zombie Custom', 25000, 'motorcycles'),
('zorrusso', 'Pegassi Zorrusso', 125000, 'super'),
('zr350', 'Annis ZR350', 18750, 'sports'),
('ztype', 'Truffade Z-Type ', 225000, 'sportsclassics');

-- --------------------------------------------------------

--
-- Structure de la table `vehicletosell`
--

CREATE TABLE `vehicletosell` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `props` longtext DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  `society` varchar(50) NOT NULL DEFAULT 'carshop'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`, `society`) VALUES
('avionfdp', 'Avion - Hélico', 'planeshop'),
('compacts', 'Compacts', 'carshop'),
('coupes', 'Coupes', 'carshop'),
('imports', 'Imports', 'carshop'),
('motorcycles', 'Motos', 'carshop'),
('muscle', 'Muscle', 'carshop'),
('offroad', 'Off Road', 'carshop'),
('sedans', 'Sedans', 'carshop'),
('sports', 'Sports', 'carshop'),
('sportsclassics', 'Sports Classics', 'carshop'),
('super', 'Super', 'carshop'),
('superboat', 'Bateau', 'boatshop'),
('suvs', 'SUVs', 'carshop'),
('vans', 'Vans', 'carshop');

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_keys`
--

CREATE TABLE `vehicle_keys` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `plate` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `account_info`
--
ALTER TABLE `account_info`
  ADD PRIMARY KEY (`account_id`) USING BTREE,
  ADD UNIQUE KEY `license` (`license`) USING BTREE;

--
-- Index pour la table `baninfo`
--
ALTER TABLE `baninfo`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `banlist`
--
ALTER TABLE `banlist`
  ADD PRIMARY KEY (`license`) USING BTREE;

--
-- Index pour la table `banlisthistory`
--
ALTER TABLE `banlisthistory`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `index_billing_identifier` (`identifier`) USING BTREE;

--
-- Index pour la table `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `casino_cache`
--
ALTER TABLE `casino_cache`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Index pour la table `casino_players`
--
ALTER TABLE `casino_players`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Index pour la table `chestbuilder`
--
ALTER TABLE `chestbuilder`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `clothes_data`
--
ALTER TABLE `clothes_data`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `drugss`
--
ALTER TABLE `drugss`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gangbuilder`
--
ALTER TABLE `gangbuilder`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gunfight_stats`
--
ALTER TABLE `gunfight_stats`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hottubs`
--
ALTER TABLE `hottubs`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `identifier` (`identifier`(191)) USING BTREE;

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `jail`
--
ALTER TABLE `jail`
  ADD PRIMARY KEY (`identifier`) USING BTREE;

--
-- Index pour la table `jobbuilder`
--
ALTER TABLE `jobbuilder`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `labos`
--
ALTER TABLE `labos`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`) USING BTREE;

--
-- Index pour la table `limitedvehicleboutique`
--
ALTER TABLE `limitedvehicleboutique`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `okokbanking_transactions`
--
ALTER TABLE `okokbanking_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `open_car`
--
ALTER TABLE `open_car`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `index_open_car_owner` (`owner`) USING BTREE,
  ADD KEY `index_open_car_owner_plate` (`owner`,`plate`) USING BTREE;

--
-- Index pour la table `owned_properties`
--
ALTER TABLE `owned_properties`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`) USING BTREE;

--
-- Index pour la table `persist2_car`
--
ALTER TABLE `persist2_car`
  ADD PRIMARY KEY (`plate`) USING BTREE;

--
-- Index pour la table `persist_car`
--
ALTER TABLE `persist_car`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `piwel_territoires`
--
ALTER TABLE `piwel_territoires`
  ADD PRIMARY KEY (`zone`) USING BTREE;

--
-- Index pour la table `plaintes`
--
ALTER TABLE `plaintes`
  ADD PRIMARY KEY (`identifier`) USING BTREE;

--
-- Index pour la table `plaintes2`
--
ALTER TABLE `plaintes2`
  ADD PRIMARY KEY (`identifier`) USING BTREE;

--
-- Index pour la table `players_uid`
--
ALTER TABLE `players_uid`
  ADD PRIMARY KEY (`uid`);

--
-- Index pour la table `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `playlist_songs`
--
ALTER TABLE `playlist_songs`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `playtime`
--
ALTER TABLE `playtime`
  ADD PRIMARY KEY (`identifier`) USING BTREE;

--
-- Index pour la table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`propertyID`) USING BTREE;

--
-- Index pour la table `properties_list`
--
ALTER TABLE `properties_list`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id` (`id`) USING BTREE;

--
-- Index pour la table `societies_storage`
--
ALTER TABLE `societies_storage`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`license`) USING BTREE;

--
-- Index pour la table `tebex_accounts`
--
ALTER TABLE `tebex_accounts`
  ADD PRIMARY KEY (`steam`) USING BTREE;

--
-- Index pour la table `tebex_commands`
--
ALTER TABLE `tebex_commands`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `tebex_fidelite`
--
ALTER TABLE `tebex_fidelite`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `tebex_logs_commands`
--
ALTER TABLE `tebex_logs_commands`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `vehiclePlate` (`vehiclePlate`) USING BTREE;

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`character_id`) USING BTREE,
  ADD UNIQUE KEY `identifier` (`identifier`) USING BTREE;

--
-- Index pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `vdaaccess`
--
ALTER TABLE `vdaaccess`
  ADD PRIMARY KEY (`license`) USING BTREE;

--
-- Index pour la table `vehicleclaimsell`
--
ALTER TABLE `vehicleclaimsell`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`model`) USING BTREE;

--
-- Index pour la table `vehicletosell`
--
ALTER TABLE `vehicletosell`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `vehicle_keys`
--
ALTER TABLE `vehicle_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `owner` (`owner`,`plate`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `account_info`
--
ALTER TABLE `account_info`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `baninfo`
--
ALTER TABLE `baninfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `banlisthistory`
--
ALTER TABLE `banlisthistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `casino_cache`
--
ALTER TABLE `casino_cache`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `casino_players`
--
ALTER TABLE `casino_players`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=926;

--
-- AUTO_INCREMENT pour la table `chestbuilder`
--
ALTER TABLE `chestbuilder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT pour la table `clothes_data`
--
ALTER TABLE `clothes_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `drugss`
--
ALTER TABLE `drugss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gangbuilder`
--
ALTER TABLE `gangbuilder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gunfight_stats`
--
ALTER TABLE `gunfight_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `hottubs`
--
ALTER TABLE `hottubs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `jobbuilder`
--
ALTER TABLE `jobbuilder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14955;

--
-- AUTO_INCREMENT pour la table `labos`
--
ALTER TABLE `labos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `limitedvehicleboutique`
--
ALTER TABLE `limitedvehicleboutique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `okokbanking_transactions`
--
ALTER TABLE `okokbanking_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `open_car`
--
ALTER TABLE `open_car`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `owned_properties`
--
ALTER TABLE `owned_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_uid`
--
ALTER TABLE `players_uid`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `playlist_songs`
--
ALTER TABLE `playlist_songs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=912;

--
-- AUTO_INCREMENT pour la table `properties`
--
ALTER TABLE `properties`
  MODIFY `propertyID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `properties_list`
--
ALTER TABLE `properties_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `societies_storage`
--
ALTER TABLE `societies_storage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35488;

--
-- AUTO_INCREMENT pour la table `tebex_commands`
--
ALTER TABLE `tebex_commands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tebex_fidelite`
--
ALTER TABLE `tebex_fidelite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `tebex_logs_commands`
--
ALTER TABLE `tebex_logs_commands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `character_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `vehicleclaimsell`
--
ALTER TABLE `vehicleclaimsell`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT pour la table `vehicletosell`
--
ALTER TABLE `vehicletosell`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=224;

--
-- AUTO_INCREMENT pour la table `vehicle_keys`
--
ALTER TABLE `vehicle_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
