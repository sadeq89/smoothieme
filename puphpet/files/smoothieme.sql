﻿-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 13. Jan 2015 um 02:32
-- Server Version: 5.5.40-0ubuntu0.14.04.1
-- PHP-Version: 5.6.3-1+deb.sury.org~trusty+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `dbsmoothieme`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role` enum('admin','user') NOT NULL,
  `name` varchar(45) NOT NULL,
  `password` text NOT NULL,
  `salt` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Daten für Tabelle `accounts`
--

INSERT INTO `accounts` (`ID`, `role`, `name`, `password`, `salt`, `email`) VALUES
(1, 'admin', 'admin', 'ed1c972305635e5be40aa72f6c0c1bd84cb0a8d1', 'saltsaltsalt', 'sadeq1989@gmail.com'),
(13, 'user', 'user', 'ed1c972305635e5be40aa72f6c0c1bd84cb0a8d1', 'saltsaltsalt', 'sadeq1989@gmail.com');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `addresses`
--

CREATE TABLE IF NOT EXISTS `addresses` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_ID` bigint(20) unsigned NOT NULL,
  `street` varchar(70) NOT NULL,
  `house_nr` varchar(5) NOT NULL,
  `city` varchar(70) NOT NULL,
  `zip` int(5) NOT NULL,
  `country` varchar(70) NOT NULL,
  `delivery_notes` text,
  PRIMARY KEY (`ID`),
  KEY `customer_ID` (`customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `accounts_ID` bigint(20) unsigned NOT NULL,
  `surname` varchar(70) NOT NULL,
  `lastname` varchar(70) NOT NULL,
  `gender` enum('f','m') NOT NULL,
  `tel` varchar(70) NOT NULL,
  `birthdate` date DEFAULT NULL,
  PRIMARY KEY (`ID`,`accounts_ID`),
  KEY `fk_customer_accounts1_idx` (`accounts_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Daten für Tabelle `customer`
--

INSERT INTO `customer` (`ID`, `accounts_ID`, `surname`, `lastname`, `gender`, `tel`, `birthdate`) VALUES
(4, 1, 'S', 'A', 'm', '123123', NULL),
(5, 13, 'Franz', 'Müller', 'm', '12124124', NULL),
(15, 32, 'hansi', 'wursti', '', '012392893829893', NULL),
(16, 33, 'berthold', 'ulrich', '', '012392893829893', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fruits`
--

CREATE TABLE IF NOT EXISTS `fruits` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(70) NOT NULL,
  `color` char(7) NOT NULL,
  `price` decimal(14,7) NOT NULL COMMENT 'je 100 ml',
  `description` text NOT NULL,
  `kcal` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Daten für Tabelle `fruits`
--

INSERT INTO `fruits` (`ID`, `name`, `color`, `price`, `description`, `kcal`) VALUES
(1, 'aaa', '#10ae00', '1.0000000', 'f', 11),
(2, 'dtud', '#10ae00', '1.0000000', 'h', 44),
(3, 'dcr', '#653c85', '1.0000000', 'cc', 33);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `delivery_address` bigint(20) unsigned DEFAULT NULL,
  `invoice_address` bigint(20) unsigned DEFAULT NULL,
  `delivery_method` enum('bike','post') NOT NULL,
  `payment_method` enum('rechnung','nachnahme','paypal') NOT NULL,
  `account_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `delivery_address` (`delivery_address`),
  KEY `send-bill-to_idx` (`invoice_address`),
  KEY `account_ID` (`account_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Daten für Tabelle `orders`
--

INSERT INTO `orders` (`ID`, `delivery_address`, `invoice_address`, `delivery_method`, `payment_method`, `account_ID`) VALUES
(9, NULL, NULL, '', 'rechnung', 0),
(10, NULL, NULL, '', 'rechnung', 0),
(11, NULL, NULL, '', 'rechnung', 13),
(12, NULL, NULL, '', 'rechnung', 13);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `smoothies`
--

CREATE TABLE IF NOT EXISTS `smoothies` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `size` enum('S','M','L') NOT NULL,
  `name` varchar(70) DEFAULT NULL,
  `customer_ID` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `customer_ID` (`customer_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `smoothies`
--

INSERT INTO `smoothies` (`ID`, `size`, `name`, `customer_ID`) VALUES
(1, 'S', 'lilagrünerMonster', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `smoothies_has_fruits`
--

CREATE TABLE IF NOT EXISTS `smoothies_has_fruits` (
  `smoothie_ID` bigint(20) unsigned NOT NULL,
  `fruit_ID` bigint(20) unsigned NOT NULL,
  `ml` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`smoothie_ID`,`fruit_ID`),
  KEY `fk_smoothie_has_fruits_fruits1_idx` (`fruit_ID`),
  KEY `fk_smoothie_has_fruits_smoothie1_idx` (`smoothie_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `smoothies_has_fruits`
--

INSERT INTO `smoothies_has_fruits` (`smoothie_ID`, `fruit_ID`, `ml`) VALUES
(1, 1, 16),
(1, 2, 42),
(1, 3, 42);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `smoothies_has_orders`
--

CREATE TABLE IF NOT EXISTS `smoothies_has_orders` (
  `smoothies_ID` bigint(20) unsigned NOT NULL,
  `orders_ID` bigint(20) unsigned NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`smoothies_ID`,`orders_ID`),
  KEY `fk_smoothies_has_orders_orders1_idx` (`orders_ID`),
  KEY `fk_smoothies_has_orders_smoothies1_idx` (`smoothies_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `smoothies_has_orders`
--

INSERT INTO `smoothies_has_orders` (`smoothies_ID`, `orders_ID`, `count`) VALUES
(1, 9, 4),
(1, 10, 2),
(1, 11, 2),
(1, 12, 3);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `send-bill-to` FOREIGN KEY (`invoice_address`) REFERENCES `addresses` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `send-packet-to` FOREIGN KEY (`delivery_address`) REFERENCES `addresses` (`ID`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `smoothies`
--
ALTER TABLE `smoothies`
  ADD CONSTRAINT `smoothie_ibfk_2` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `smoothies_has_fruits`
--
ALTER TABLE `smoothies_has_fruits`
  ADD CONSTRAINT `fk_smoothie_has_fruits_fruits1` FOREIGN KEY (`fruit_ID`) REFERENCES `fruits` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_smoothie_has_fruits_smoothie1` FOREIGN KEY (`smoothie_ID`) REFERENCES `smoothies` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints der Tabelle `smoothies_has_orders`
--
ALTER TABLE `smoothies_has_orders`
  ADD CONSTRAINT `fk_smoothies_has_orders_orders1` FOREIGN KEY (`orders_ID`) REFERENCES `orders` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_smoothies_has_orders_smoothies1` FOREIGN KEY (`smoothies_ID`) REFERENCES `smoothies` (`ID`) ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
