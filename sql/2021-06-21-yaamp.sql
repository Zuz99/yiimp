-- phpMyAdmin SQL Dump
-- version 4.6.0
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Dim 03 Avril 2016 à 14:29
-- Version du serveur :  10.1.13-MariaDB
-- Version de PHP :  7.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `yaamp`
--

-- --------------------------------------------------------

--
-- Structure de la table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(255) NOT NULL,
  `coinid` int(11) DEFAULT NULL,
  `last_earning` int(10) DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT '0',
  `no_fees` tinyint(1) DEFAULT NULL,
  `donation` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `logtraffic` tinyint(1) DEFAULT NULL,
  `balance` double DEFAULT '0',
  `username` varchar(40) NOT NULL,
  `coinsymbol` varchar(16) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `hostaddr` varchar(39) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `algos`
--

CREATE TABLE `algos` (
  `id` int(11) NOT NULL,
  `name` varchar(16) DEFAULT NULL,
  `profit` double DEFAULT NULL,
  `rent` double DEFAULT NULL,
  `factor` double DEFAULT NULL,
  `overflow` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `algos`
--

INSERT INTO `algos` (`id`, `name`, `profit`, `rent`, `factor`, `overflow`) VALUES
(1, 'scrypt', 0, 0, 1, 1),
(2, 'scryptn', 0, 0, 1, 1),
(3, 'neoscrypt', 0, 0, 1, 1),
(4, 'quark', 0, 0, 1, 1),
(5, 'lyra2', 0, 0, 1, 1),
(6, 'x11', 0, 0, 1, 1),
(7, 'x13', 0, 0, 1, 1),
(8, 'x14', 0, 0, 1, 0),
(9, 'x15', 0, 0, 1, 1),
(10, 'fresh', 0.0026231955438411, 0.0027018914101563, 5, 0),
(11, 'sha256', 0, 0, 1, 1),
(12, 'qubit', 0, 0, 1, 1),
(13, 'skein', 0, 0, 1, 1),
(14, 'groestl', 0, 0, 1, 0),
(15, 'blake', 0, 0, 1, 0),
(16, 'keccak', 0, 0, 1, 0),
(17, 'nist5', 0, 0, 1, 1),
(18, 'zr5', 0, 0, 1, 1),
(19, 'c11', 0, 0, 1, 0),
(20, 'drop', 2.5713261892185e-21, 32.540632674103, 1.5, 0),
(21, 'skein2', 0, 0, 1, 0),
(22, 'bmw', 0.00000000000009119158510914, 0.000072523406145041, 100, 1),
(23, 'argon2', 0, 0, 1, NULL),
(24, 'blake2s', 0, 0, 1, NULL),
(25, 'decred', 0, 0, 1, NULL),
(26, 'luffa', 0, 0, 1, NULL),
(27, 'lyra2v2', 0, 0, 1, NULL),
(28, 'penta', 0, 0, 1, NULL),
(29, 'dmd-gr', 0, 0, 1, NULL),
(30, 'myr-gr', 0, 0, 1, NULL),
(31, 'm7m', 0, 0, 1, NULL),
(32, 'sib', 0, 0, 1, NULL),
(33, 'vanilla', 0, 0, 1, NULL),
(34, 'velvet', 0, 0, 1, NULL),
(35, 'yescrypt', 0, 0, 1, NULL),
(36, 'whirlpool', 0, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `balances`
--

CREATE TABLE `balances` (
  `id` int(11) NOT NULL,
  `name` varchar(16) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `onsell` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `balances`
--

INSERT INTO `balances` (`id`, `name`, `balance`, `onsell`) VALUES
(1, 'bittrex', 0, NULL),
(2, 'poloniex', 0, NULL),
(3, 'safecex', 0, NULL),
(4, 'bleutrade', 0, NULL),
(5, 'yobit', 0, NULL),
(6, 'c-cex', 0, NULL),
(7, 'alcurex', 0, NULL),
(8, 'cryptopia', 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `balanceuser`
--

CREATE TABLE `balanceuser` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `pending` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `blocks`
--

CREATE TABLE `blocks` (
  `id` int(11) UNSIGNED NOT NULL,
  `coin_id` int(11) DEFAULT NULL,
  `height` int(11) UNSIGNED DEFAULT NULL,
  `confirmations` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `workerid` int(11) DEFAULT NULL,
  `difficulty_user` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `difficulty` double DEFAULT NULL,
  `category` varchar(16) DEFAULT NULL,
  `algo` varchar(16) DEFAULT 'scrypt',
  `blockhash` varchar(128) DEFAULT NULL,
  `txhash` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Discovered blocks persisted from Litecoin Service';

-- --------------------------------------------------------

--
-- Structure de la table `coins`
--

CREATE TABLE `coins` (
  `id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `symbol` varchar(16) DEFAULT NULL,
  `symbol2` varchar(16) DEFAULT NULL,
  `algo` varchar(16) DEFAULT NULL,
  `version` varchar(32) DEFAULT NULL,
  `image` varchar(1024) DEFAULT NULL,
  `market` varchar(64) DEFAULT NULL,
  `marketid` int(11) DEFAULT NULL,
  `master_wallet` varchar(1024) DEFAULT NULL,
  `charity_address` varchar(1024) DEFAULT NULL,
  `charity_amount` double DEFAULT NULL,
  `charity_percent` double DEFAULT NULL,
  `deposit_address` varchar(1024) DEFAULT NULL,
  `deposit_minimum` double DEFAULT '1',
  `sellonbid` tinyint(1) DEFAULT NULL,
  `dontsell` tinyint(1) DEFAULT '1',
  `block_explorer` varchar(1024) DEFAULT NULL,
  `index_avg` double DEFAULT NULL,
  `connections` int(11) DEFAULT NULL,
  `errors` varchar(1024) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `mint` double DEFAULT NULL,
  `txfee` double DEFAULT NULL,
  `payout_min` double DEFAULT NULL,
  `payout_max` double DEFAULT NULL,
  `difficulty` double DEFAULT '1',
  `difficulty_pos` double DEFAULT NULL,
  `block_height` int(11) DEFAULT NULL,
  `target_height` int(11) DEFAULT NULL,
  `network_hash` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `price2` double DEFAULT NULL,
  `reward` double DEFAULT '1',
  `reward_mul` double DEFAULT '1',
  `enable` tinyint(1) DEFAULT '0',
  `auto_ready` tinyint(1) DEFAULT '0',
  `visible` tinyint(1) DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  `action` int(11) DEFAULT NULL,
  `conf_folder` varchar(128) DEFAULT NULL,
  `program` varchar(128) DEFAULT NULL,
  `rpcuser` varchar(128) DEFAULT NULL,
  `rpcpasswd` varchar(128) DEFAULT NULL,
  `serveruser` varchar(45) DEFAULT NULL,
  `rpchost` varchar(128) DEFAULT NULL,
  `rpcport` int(11) DEFAULT NULL,
  `dedicatedport` int(11) DEFAULT NULL,
  `rpccurl` tinyint(1) NOT NULL DEFAULT '0',
  `rpcssl` tinyint(1) NOT NULL DEFAULT '0',
  `rpccert` varchar(255) DEFAULT NULL,
  `rpcencoding` varchar(16) DEFAULT NULL,
  `account` varchar(64) NOT NULL DEFAULT '',
  `hassubmitblock` tinyint(1) DEFAULT NULL,
  `hasmasternodes` tinyint(1) NOT NULL DEFAULT '0',
  `usememorypool` tinyint(1) DEFAULT NULL,
  `txmessage` tinyint(1) DEFAULT NULL,
  `auxpow` tinyint(1) DEFAULT NULL,
  `lastblock` varchar(128) DEFAULT NULL,
  `network_ttf` int(11) DEFAULT NULL,
  `actual_ttf` int(11) DEFAULT NULL,
  `pool_ttf` int(11) DEFAULT NULL,
  `last_network_found` int(11) DEFAULT NULL,
  `installed` tinyint(1) DEFAULT NULL,
  `link_site` varchar(1024) DEFAULT NULL,
  `link_exchange` varchar(1024) DEFAULT NULL,
  `link_bitcointalk` varchar(1024) DEFAULT NULL,
  `link_github` varchar(1024) DEFAULT NULL,
  `link_explorer` varchar(1024) DEFAULT NULL,
  `specifications` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Structure de la table `connections`
--

CREATE TABLE `connections` (
  `id` int(11) NOT NULL,
  `user` varchar(64) DEFAULT NULL,
  `host` varchar(64) DEFAULT NULL,
  `db` varchar(64) DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  `idle` int(11) DEFAULT NULL,
  `last` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `connections`
--

INSERT INTO `connections` (`id`, `user`, `host`, `db`, `created`, `idle`, `last`) VALUES
(24634, 'root', 'localhost', 'yaamp', 1459693738, 239, 1459693758),
(25098, 'root', 'localhost', 'yaamp', 1459693738, 308, 1459693758),
(25099, 'root', 'localhost', 'yaamp', 1459693738, 301, 1459693758),
(25100, 'root', 'localhost', 'yaamp', 1459693738, 308, 1459693758),
(25101, 'root', 'localhost', 'yaamp', 1459693738, 240, 1459693758),
(25102, 'root', 'localhost', 'yaamp', 1459693738, 300, 1459693758),
(25103, 'root', 'localhost', 'yaamp', 1459693738, 242, 1459693758),
(25104, 'root', 'localhost', 'yaamp', 1459693738, 303, 1459693758),
(25186, 'root', 'localhost', 'yaamp', 1459693738, 10, 1459693738),
(25187, 'root', 'localhost', 'yaamp', 1459693738, 0, 1459693738),
(25189, 'root', 'localhost', 'yaamp', 1459693758, 0, 1459693758);

-- --------------------------------------------------------

--
-- Structure de la table `earnings`
--

CREATE TABLE `earnings` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `coinid` int(11) DEFAULT NULL,
  `blockid` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `mature_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `exchange`
--

CREATE TABLE `exchange` (
  `id` int(11) NOT NULL,
  `coinid` int(11) DEFAULT NULL,
  `send_time` int(11) DEFAULT NULL,
  `receive_time` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `price_estimate` double DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `fee` double DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `market` varchar(16) DEFAULT NULL,
  `tx` varchar(65) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `hashrate`
--

CREATE TABLE `hashrate` (
  `id` int(11) NOT NULL,
  `time` int(11) DEFAULT NULL,
  `hashrate` bigint(11) DEFAULT NULL,
  `hashrate_bad` bigint(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `rent` double DEFAULT NULL,
  `earnings` double DEFAULT NULL,
  `difficulty` double DEFAULT NULL,
  `algo` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `hashrate`
--

INSERT INTO `hashrate` (`id`, `time`, `hashrate`, `hashrate_bad`, `price`, `rent`, `earnings`, `difficulty`, `algo`) VALUES
(12574, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'sha256'),
(12575, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'scrypt'),
(12576, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'scryptn'),
(12577, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'argon2'),
(12578, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'blake'),
(12579, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'blake2s'),
(12580, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'decred'),
(12581, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'keccak'),
(12582, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'luffa'),
(12583, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'lyra2'),
(12584, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'lyra2v2'),
(12585, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'neoscrypt'),
(12586, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'nist5'),
(12587, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'penta'),
(12588, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'quark'),
(12589, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'qubit'),
(12590, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'c11'),
(12591, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'x11'),
(12592, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'x13'),
(12593, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'x14'),
(12594, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'x15'),
(12595, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'groestl'),
(12596, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'dmd-gr'),
(12597, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'myr-gr'),
(12598, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'm7m'),
(12599, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'sib'),
(12600, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'skein'),
(12601, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'skein2'),
(12602, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'vanilla'),
(12603, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'velvet'),
(12604, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'yescrypt'),
(12605, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'whirlpool'),
(12606, 1459692900, 0, NULL, 0, 0, NULL, NULL, 'zr5');

-- --------------------------------------------------------

--
-- Structure de la table `hashrenter`
--

CREATE TABLE `hashrenter` (
  `id` int(11) NOT NULL,
  `renterid` int(11) DEFAULT NULL,
  `jobid` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `hashrate` double DEFAULT NULL,
  `hashrate_bad` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `hashstats`
--

CREATE TABLE `hashstats` (
  `id` int(11) NOT NULL,
  `time` int(11) DEFAULT NULL,
  `hashrate` bigint(11) DEFAULT NULL,
  `earnings` double DEFAULT NULL,
  `algo` varchar(16) DEFAULT 'scrypt'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `hashuser`
--

CREATE TABLE `hashuser` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `hashrate` bigint(11) DEFAULT NULL,
  `hashrate_bad` bigint(11) DEFAULT NULL,
  `algo` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `renterid` int(11) DEFAULT NULL,
  `ready` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `speed` double DEFAULT NULL,
  `difficulty` double DEFAULT NULL,
  `algo` varchar(16) DEFAULT NULL,
  `host` varchar(1024) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `username` varchar(1024) DEFAULT NULL,
  `password` varchar(1024) DEFAULT NULL,
  `percent` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jobsubmits`
--

CREATE TABLE `jobsubmits` (
  `id` int(11) NOT NULL,
  `jobid` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `difficulty` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `algo` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `markets`
--

CREATE TABLE `markets` (
  `id` int(11) NOT NULL,
  `coinid` int(11) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `marketid` int(11) DEFAULT NULL,
  `priority` tinyint(1) NOT NULL DEFAULT '0',
  `lastsent` int(11) DEFAULT NULL,
  `lasttraded` int(11) DEFAULT '0',
  `balancetime` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `txfee` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `ontrade` double NOT NULL DEFAULT '0',
  `price` double DEFAULT NULL,
  `price2` double DEFAULT NULL,
  `pricetime` int(11) DEFAULT NULL,
  `deposit_address` varchar(1024) DEFAULT NULL,
  `message` varchar(2048) DEFAULT NULL,
  `name` varchar(16) DEFAULT NULL,
  `base_coin` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `markets`
--

INSERT INTO `markets` (`id`, `coinid`, `disabled`, `marketid`, `priority`, `lastsent`, `lasttraded`, `balancetime`, `deleted`, `txfee`, `balance`, `ontrade`, `price`, `price2`, `pricetime`, `deposit_address`, `message`, `name`, `base_coin`) VALUES
(1, 155, 0, NULL, 0, NULL, 0, NULL, 0, 0.002, NULL, 0, 0.020691404922548, 0.020814137099131, NULL, NULL, NULL, 'bittrex', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `mining`
--

CREATE TABLE `mining` (
  `id` int(11) NOT NULL,
  `usdbtc` double DEFAULT NULL,
  `last_monitor_exchange` int(11) DEFAULT NULL,
  `last_update_price` int(11) DEFAULT NULL,
  `last_payout` int(11) DEFAULT NULL,
  `stratumids` varchar(1024) DEFAULT NULL,
  `best_algo` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `mining`
--

INSERT INTO `mining` (`id`, `usdbtc`, `last_monitor_exchange`, `last_update_price`, `last_payout`, `stratumids`, `best_algo`) VALUES
(1, 418.82, 1422830048, 1422829644, 1459683363, '', 'lyra2');

-- --------------------------------------------------------

--
-- Structure de la table `nicehash`
--

CREATE TABLE `nicehash` (
  `id` int(11) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `orderid` int(11) DEFAULT NULL,
  `last_decrease` int(11) DEFAULT NULL,
  `algo` varchar(32) DEFAULT NULL,
  `btc` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `speed` double DEFAULT NULL,
  `workers` int(11) DEFAULT NULL,
  `accepted` double DEFAULT NULL,
  `rejected` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `nicehash`
--

INSERT INTO `nicehash` (`id`, `active`, `orderid`, `last_decrease`, `algo`, `btc`, `price`, `speed`, `workers`, `accepted`, `rejected`) VALUES
(1, 0, NULL, NULL, 'x11', NULL, NULL, NULL, 0, 0, 0),
(2, 0, NULL, NULL, 'scrypt', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 0, NULL, NULL, 'sha256', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 0, NULL, NULL, 'scryptn', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 0, NULL, NULL, 'x13', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 0, NULL, NULL, 'x15', NULL, NULL, NULL, 0, 0, 0),
(7, 0, NULL, NULL, 'nist5', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 0, NULL, NULL, 'neoscrypt', NULL, NULL, NULL, 0, 0, 0),
(9, 0, NULL, NULL, 'lyra2', NULL, NULL, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `coinid` int(11) DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `ask` double DEFAULT NULL,
  `bid` double DEFAULT NULL,
  `market` varchar(16) DEFAULT NULL,
  `uuid` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `payouts`
--

CREATE TABLE `payouts` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `account_ids` varchar(1024) DEFAULT NULL,
  `time` int(11) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `amount` double DEFAULT NULL,
  `fee` double DEFAULT NULL,
  `tx` varchar(128) DEFAULT NULL,
  `errmsg` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rawcoins`
--

CREATE TABLE `rawcoins` (
  `id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `symbol` varchar(32) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `rawcoins`
--

INSERT INTO `rawcoins` (`id`, `name`, `symbol`, `active`) VALUES
(1, 'Bitcoin', 'BTC', 1);

-- --------------------------------------------------------

--
-- Structure de la table `renters`
--

CREATE TABLE `renters` (
  `id` int(11) NOT NULL,
  `created` int(11) DEFAULT NULL,
  `updated` int(11) DEFAULT NULL,
  `address` varchar(1024) DEFAULT NULL,
  `email` varchar(1024) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `apikey` varbinary(1024) DEFAULT NULL,
  `received` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `unconfirmed` double DEFAULT NULL,
  `spent` double DEFAULT NULL,
  `custom_start` double DEFAULT NULL,
  `custom_balance` double DEFAULT NULL,
  `custom_accept` double DEFAULT NULL,
  `custom_reject` double DEFAULT NULL,
  `custom_address` varchar(1024) DEFAULT NULL,
  `custom_server` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rentertxs`
--

CREATE TABLE `rentertxs` (
  `id` int(11) NOT NULL,
  `renterid` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `address` varchar(1024) DEFAULT NULL,
  `tx` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `servers`
--

CREATE TABLE `servers` (
  `id` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `maxcoins` int(11) DEFAULT NULL,
  `uptime` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `algo` varchar(64) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `speed` bigint(20) DEFAULT NULL,
  `custom_balance` double DEFAULT NULL,
  `custom_accept` double DEFAULT NULL,
  `custom_reject` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `services`
--

INSERT INTO `services` (`id`, `name`, `algo`, `price`, `speed`, `custom_balance`, `custom_accept`, `custom_reject`) VALUES
(1, 'Nicehash', 'scrypt', 0.0003646, 20628000000, 0, 0, 0),
(2, 'Nicehash', 'x11', 0.0004524, 15616000000, 0, 0, 0),
(3, 'Nicehash', 'x13', 0.0003273, 185100000, 0, 0, 0),
(4, 'Nicehash', 'x15', 0.0004079, 7200000, 0, 0, 0),
(5, 'Nicehash', 'nist5', 0.001, 21900000, 0, 0, 0),
(6, 'Nicehash', 'sha256', 0.0000098, 2310347791200000, 0, 0, 0),
(7, 'Nicehash', 'scryptn', 0.0005521, 1200000, 0, 0, 0),
(8, 'Nicehash', 'neoscrypt', 0.0073366, 13600000, 0, 0, 0),
(9, 'Nicehash', 'lyra2', 0.0006123, 181400000, 0, 0, 0),
(16, 'Nicehash', 'qubit', 0.0001968, 72200000, 0, 0, 0),
(17, 'Nicehash', 'quark', 0.0004536, 65978400000, 0, 0, 0),
(18, 'Nicehash', 'zr5', 0.0001, 61865000000, 0, 0, 0),
(19, 'Nicehash', 'c11', 0.0003403, 11823800000, 0, 0, 0),
(20, 'Nicehash', 'keccak', 0.0000027, 153200000, 0, 0, 0),
(21, 'Nicehash', 'whirlx', 0.0000091, 1100700000, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `shares`
--

CREATE TABLE `shares` (
  `id` bigint(30) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `workerid` int(11) DEFAULT NULL,
  `coinid` int(11) DEFAULT NULL,
  `jobid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `error` int(11) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `extranonce1` tinyint(1) DEFAULT NULL,
  `difficulty` double NOT NULL DEFAULT '0',
  `share_diff` double NOT NULL DEFAULT '0',
  `algo` varchar(16) DEFAULT 'x11'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `stats`
--

CREATE TABLE `stats` (
  `id` int(11) NOT NULL,
  `time` int(11) DEFAULT NULL,
  `profit` double DEFAULT NULL,
  `wallet` double DEFAULT NULL,
  `wallets` double DEFAULT NULL,
  `immature` double DEFAULT NULL,
  `margin` double DEFAULT NULL,
  `waiting` double DEFAULT NULL,
  `balances` double DEFAULT NULL,
  `onsell` double DEFAULT NULL,
  `renters` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `stats`
--

INSERT INTO `stats` (`id`, `time`, `profit`, `wallet`, `wallets`, `immature`, `margin`, `waiting`, `balances`, `onsell`, `renters`) VALUES
(382, 1459692900, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `stratums`
--

CREATE TABLE `stratums` (
  `pid` int(11) NOT NULL,
  `time` int(11) DEFAULT NULL,
  `algo` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `withdraws`
--

CREATE TABLE `withdraws` (
  `id` int(11) NOT NULL,
  `market` varchar(1024) DEFAULT NULL,
  `address` varchar(1024) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `uuid` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `workers`
--

CREATE TABLE `workers` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `subscribe` tinyint(1) DEFAULT NULL,
  `difficulty` double DEFAULT NULL,
  `ip` varchar(32) DEFAULT NULL,
  `dns` varchar(1024) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `nonce1` varchar(64) DEFAULT NULL,
  `version` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `worker` varchar(64) DEFAULT NULL,
  `algo` varchar(16) DEFAULT 'scrypt'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `coin` (`coinid`),
  ADD KEY `balance` (`balance`),
  ADD KEY `earning` (`last_earning`);

--
-- Index pour la table `algos`
--
ALTER TABLE `algos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Index pour la table `balances`
--
ALTER TABLE `balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Index pour la table `balanceuser`
--
ALTER TABLE `balanceuser`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `time` (`time`);

--
-- Index pour la table `blocks`
--
ALTER TABLE `blocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time` (`time`),
  ADD KEY `algo1` (`algo`),
  ADD KEY `coin` (`coin_id`),
  ADD KEY `category` (`category`),
  ADD KEY `user1` (`userid`),
  ADD KEY `height1` (`height`);

--
-- Index pour la table `coins`
--
ALTER TABLE `coins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auto_ready` (`auto_ready`),
  ADD KEY `enable` (`enable`),
  ADD KEY `algo` (`algo`),
  ADD KEY `symbol` (`symbol`),
  ADD KEY `index_avg` (`index_avg`),
  ADD KEY `created` (`created`);

--
-- Index pour la table `connections`
--
ALTER TABLE `connections`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `earnings`
--
ALTER TABLE `earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`userid`),
  ADD KEY `coin` (`coinid`),
  ADD KEY `block` (`blockid`),
  ADD KEY `create1` (`create_time`),
  ADD KEY `status` (`status`);

--
-- Index pour la table `exchange`
--
ALTER TABLE `exchange`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coinid` (`coinid`),
  ADD KEY `status` (`status`),
  ADD KEY `market` (`market`),
  ADD KEY `send_time` (`send_time`);

--
-- Index pour la table `hashrate`
--
ALTER TABLE `hashrate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t1` (`time`),
  ADD KEY `a1` (`algo`);

--
-- Index pour la table `hashrenter`
--
ALTER TABLE `hashrenter`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hashstats`
--
ALTER TABLE `hashstats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `algo1` (`algo`),
  ADD KEY `time1` (`time`);

--
-- Index pour la table `hashuser`
--
ALTER TABLE `hashuser`
  ADD PRIMARY KEY (`id`),
  ADD KEY `u1` (`userid`),
  ADD KEY `t1` (`time`),
  ADD KEY `a1` (`algo`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `renterid` (`renterid`),
  ADD KEY `ready` (`ready`),
  ADD KEY `active` (`active`),
  ADD KEY `algo` (`algo`),
  ADD KEY `price` (`price`);

--
-- Index pour la table `jobsubmits`
--
ALTER TABLE `jobsubmits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `markets`
--
ALTER TABLE `markets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coinid` (`coinid`),
  ADD KEY `name` (`name`),
  ADD KEY `lastsent` (`lastsent`),
  ADD KEY `lasttraded` (`lasttraded`);

--
-- Index pour la table `mining`
--
ALTER TABLE `mining`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `nicehash`
--
ALTER TABLE `nicehash`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coinid` (`coinid`),
  ADD KEY `created` (`created`),
  ADD KEY `market` (`market`);

--
-- Index pour la table `payouts`
--
ALTER TABLE `payouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`,`completed`);

--
-- Index pour la table `rawcoins`
--
ALTER TABLE `rawcoins`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `renters`
--
ALTER TABLE `renters`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rentertxs`
--
ALTER TABLE `rentertxs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `renterid` (`renterid`),
  ADD KEY `time` (`time`);

--
-- Index pour la table `servers`
--
ALTER TABLE `servers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name1` (`name`);

--
-- Index pour la table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `shares`
--
ALTER TABLE `shares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time` (`time`),
  ADD KEY `algo1` (`algo`),
  ADD KEY `valid1` (`valid`),
  ADD KEY `user1` (`userid`),
  ADD KEY `worker1` (`workerid`),
  ADD KEY `coin1` (`coinid`),
  ADD KEY `jobid` (`jobid`);

--
-- Index pour la table `stats`
--
ALTER TABLE `stats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time` (`time`);

--
-- Index pour la table `stratums`
--
ALTER TABLE `stratums`
  ADD PRIMARY KEY (`pid`);

--
-- Index pour la table `withdraws`
--
ALTER TABLE `withdraws`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `algo1` (`algo`),
  ADD KEY `name1` (`name`),
  ADD KEY `userid` (`userid`),
  ADD KEY `pid` (`pid`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `algos`
--
ALTER TABLE `algos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `balances`
--
ALTER TABLE `balances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `balanceuser`
--
ALTER TABLE `balanceuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `blocks`
--
ALTER TABLE `blocks`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `coins`
--
ALTER TABLE `coins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `earnings`
--
ALTER TABLE `earnings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `exchange`
--
ALTER TABLE `exchange`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `hashrate`
--
ALTER TABLE `hashrate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `hashrenter`
--
ALTER TABLE `hashrenter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `hashstats`
--
ALTER TABLE `hashstats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `hashuser`
--
ALTER TABLE `hashuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `jobsubmits`
--
ALTER TABLE `jobsubmits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `markets`
--
ALTER TABLE `markets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `mining`
--
ALTER TABLE `mining`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `nicehash`
--
ALTER TABLE `nicehash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `payouts`
--
ALTER TABLE `payouts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `rawcoins`
--
ALTER TABLE `rawcoins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `renters`
--
ALTER TABLE `renters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `rentertxs`
--
ALTER TABLE `rentertxs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `servers`
--
ALTER TABLE `servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `shares`
--
ALTER TABLE `shares`
  MODIFY `id` bigint(30) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `stats`
--
ALTER TABLE `stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `withdraws`
--
ALTER TABLE `withdraws`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `workers`
--
ALTER TABLE `workers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
