-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 27, 2016 at 10:54 PM
-- Server version: 5.7.15-0ubuntu0.16.04.1
-- PHP Version: 7.0.8-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apna_bank`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cus_id` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `f_name` varchar(15) NOT NULL,
  `m_name` varchar(15) NOT NULL,
  `l_name` varchar(15) NOT NULL,
  `dob` date NOT NULL,
  `password` varchar(20) NOT NULL,
  `address` varchar(200) NOT NULL,
  `pincode` mediumint(6) NOT NULL,
  `phone` int(10) NOT NULL,
  `gender` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `f_name` int(15) NOT NULL,
  `m_name` int(15) NOT NULL,
  `l_name` int(15) NOT NULL,
  `email` int(30) NOT NULL,
  `phone` int(10) NOT NULL,
  `password` varchar(30) NOT NULL,
  `department` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `home_insurance`
--

CREATE TABLE `home_insurance` (
  `policy_id` int(15) NOT NULL,
  `building_cost` double NOT NULL,
  `appliance_cost` double NOT NULL,
  `premium_pay_term` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `life_insurance`
--

CREATE TABLE `life_insurance` (
  `policy_id` int(15) NOT NULL,
  `life_cover` int(15) NOT NULL,
  `premium_pay_term` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `motor_insurance`
--

CREATE TABLE `motor_insurance` (
  `policy_id` int(15) NOT NULL,
  `engine_no` int(15) NOT NULL,
  `vehicle_reg_no` varchar(20) NOT NULL,
  `premium_pay_term` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nominee`
--

CREATE TABLE `nominee` (
  `nominee_id` int(15) NOT NULL,
  `f_name` varchar(15) NOT NULL,
  `m_name` varchar(15) NOT NULL,
  `l_name` varchar(15) NOT NULL,
  `dob` date NOT NULL,
  `gender` char(1) NOT NULL,
  `address` varchar(200) NOT NULL,
  `relation_with_customer` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pincode`
--

CREATE TABLE `pincode` (
  `pincode` mediumint(6) NOT NULL,
  `city` varchar(15) NOT NULL,
  `state` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `policy`
--

CREATE TABLE `policy` (
  `policy_id` int(15) NOT NULL,
  `policy_type` varchar(20) NOT NULL,
  `date_issued` date NOT NULL,
  `date_expiry` date NOT NULL,
  `net_amount` double NOT NULL,
  `cus_id` datetime NOT NULL,
  `nominee_id` int(15) NOT NULL,
  `next_premium_date` date NOT NULL,
  `approval_status` char(1) NOT NULL,
  `approved_by` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cus_id`),
  ADD KEY `pincode` (`pincode`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `home_insurance`
--
ALTER TABLE `home_insurance`
  ADD KEY `policy_id` (`policy_id`);

--
-- Indexes for table `life_insurance`
--
ALTER TABLE `life_insurance`
  ADD KEY `policy_id` (`policy_id`);

--
-- Indexes for table `motor_insurance`
--
ALTER TABLE `motor_insurance`
  ADD PRIMARY KEY (`engine_no`),
  ADD KEY `policy_id` (`policy_id`);

--
-- Indexes for table `nominee`
--
ALTER TABLE `nominee`
  ADD PRIMARY KEY (`nominee_id`);

--
-- Indexes for table `pincode`
--
ALTER TABLE `pincode`
  ADD PRIMARY KEY (`pincode`);

--
-- Indexes for table `policy`
--
ALTER TABLE `policy`
  ADD PRIMARY KEY (`policy_id`,`policy_type`),
  ADD KEY `nominee_id` (`nominee_id`),
  ADD KEY `cus_id` (`cus_id`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `emp_id` (`approved_by`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `pincode_pk` FOREIGN KEY (`pincode`) REFERENCES `pincode` (`pincode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `home_insurance`
--
ALTER TABLE `home_insurance`
  ADD CONSTRAINT `home_insurance_fk` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `life_insurance`
--
ALTER TABLE `life_insurance`
  ADD CONSTRAINT `life_insurance_fk` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `motor_insurance`
--
ALTER TABLE `motor_insurance`
  ADD CONSTRAINT `motor_insurance_fk` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `policy`
--
ALTER TABLE `policy`
  ADD CONSTRAINT `approved_fk` FOREIGN KEY (`approved_by`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customer_fk` FOREIGN KEY (`cus_id`) REFERENCES `customer` (`cus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nominee_fk` FOREIGN KEY (`nominee_id`) REFERENCES `nominee` (`nominee_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
