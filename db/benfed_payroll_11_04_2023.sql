-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 11, 2023 at 08:28 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `benfed_payroll`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`wbsmconfed`@`localhost` FUNCTION `f_getclosing` (`adt_dt` DATE, `ad_acc_cd` INT(10)) RETURNS DECIMAL(10,2) NO SQL
BEGIN
    DECLARE	ld_cls_bal  	decimal(10,2);
    DECLARE	ls_acc_flag		varchar(5);
    DECLARE ldt_max_dt		date;
  
    SET ld_cls_bal = 0;
   
           Select max(balance_dt)
           into   ldt_max_dt
           From   tm_account_balance
           where  acc_code  = ad_acc_cd
           and    balance_dt <= adt_dt;
           
           Select IFNULL(balance_amt,0)
           Into   ld_cls_bal
           From   tm_account_balance
           Where  balance_dt = ldt_max_dt
           And    acc_code   = ad_acc_cd;
       
     
    return ld_cls_bal;
    
END$$

CREATE DEFINER=`wbsmconfed`@`localhost` FUNCTION `f_getopening` (`adt_dt` DATE, `ad_acc_cd` INT(10)) RETURNS DECIMAL(10,2) NO SQL
BEGIN
    DECLARE	ld_opn_bal  	decimal(10,2);
    
    DECLARE ldt_max_dt		date;
     
    
    SET ld_opn_bal = 0;
      
           Select max(balance_dt)
           into   ldt_max_dt
           From   tm_account_balance
           where  acc_code  = ad_acc_cd
           and    balance_dt < adt_dt;
           
           Select IFNULL(balance_amt,0)
           Into   ld_opn_bal
           From   tm_account_balance
           Where  balance_dt = ldt_max_dt
           And    acc_code   = ad_acc_cd;
        	
        
            
            
  
     
    return ld_opn_bal;
    
END$$

CREATE DEFINER=`wbsmconfed`@`localhost` FUNCTION `f_getparamval` (`ad_sl_no` INT) RETURNS VARCHAR(100) CHARSET latin1 NO SQL
BEGIN

	DECLARE ls_param_val varchar(100);

	select param_value
    into   ls_param_val
    from   md_parameters
    where  sl_no = ad_sl_no;
 
 RETURN (ls_param_val);
END$$

CREATE DEFINER=`wbsmconfed`@`localhost` FUNCTION `f_get_first_day` (`adt_dt` DATE) RETURNS DATE NO SQL
BEGIN
DECLARE ldt_dt   date;
DECLARE ld_month decimal(10);
DECLARE ld_year  decimal(10);

select month(adt_dt)
into   ld_month
from   dual;

select year(adt_dt)
into   ld_year
from   dual;

if ld_month >= 4 and ld_month <= 12 THEN
	
    SET ldt_dt = concat(ld_year,'-04-01');
ELSE
	SET ld_year = (ld_year - 1); 
    SET ldt_dt = concat(ld_year,'-04-01');
    
end if;
   
 
return ldt_dt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `md_basic_pay`
--

CREATE TABLE `md_basic_pay` (
  `effective_dt` date NOT NULL,
  `emp_cd` int(11) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `band_pay` decimal(10,2) NOT NULL,
  `grade_pay` decimal(10,2) NOT NULL,
  `ir_amt` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `md_basic_pay`
--
DELIMITER $$
CREATE TRIGGER `ai_salary_increment` AFTER INSERT ON `md_basic_pay` FOR EACH ROW BEGIN

		UPDATE md_employee SET
                band_pay	=	NEW.band_pay,
                grade_pay	=	NEW.grade_pay,
                ir_pay		=	NEW.ir_amt
            
                WHERE emp_code	=	NEW.emp_cd;
     
     
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `md_branch`
--

CREATE TABLE `md_branch` (
  `id` int(10) NOT NULL COMMENT 'Here id is Disctrict Code',
  `branch_name` varchar(100) NOT NULL,
  `districts_catered` varchar(255) NOT NULL,
  `ho_flag` enum('N','Y') NOT NULL,
  `br_manager` varchar(50) NOT NULL,
  `contact_no` varchar(15) NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_dt` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` varchar(50) NOT NULL,
  `modified_dt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_branch`
--

INSERT INTO `md_branch` (`id`, `branch_name`, `districts_catered`, `ho_flag`, `br_manager`, `contact_no`, `created_by`, `created_dt`, `modified_by`, `modified_dt`) VALUES
(327, 'Siliguri', '327', 'N', 'MRIDUL MONDAL', '9674746945', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(328, 'Jalpaiguri', '328', 'N', 'MRIDUL MONDAL', '9674746945', '', '2019-10-21 14:24:24', '', '2019-10-21 14:24:24'),
(329, 'Cooch Behar', '329', 'N', 'KOUSHIK CHAKRABORTY', '9674746942', '', '2019-10-21 14:24:24', '', '2019-10-21 14:24:24'),
(330, 'Uttar Dinajpur', '330', 'N', 'PRASAD MONDAL	', '9674746941', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(331, 'Dakhin Dinajpur', '331', 'N', 'MARSHAL SENGEL BASKEY	', '9674746940', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(332, 'Maldah', '332', 'N', 'ISHAN BANIK	', '9674746939', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(333, 'Murshidabad', '333', 'N', 'SUBHRA DAS	', '9674746936', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(334, 'Birbhum', '334', 'N', 'MONTU KUMAR MAJI', '9674746932', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(335, 'Purba Burdwan', '335', 'N', 'SUBRATA SEN	', '9674746928', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(336, 'Nadia', '336', 'N', 'SUBHASISH BISWAS', '9674746934', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(337, 'North 24 paragnas', '337', 'N', 'SABITA BISWAS', '9674746929', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(338, 'Hooghly', '338', 'N', 'SOMNATH KOTAL', '9674746931', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(339, 'Bankura', '339', 'N', 'KALYAN BISWAS', '9674746933', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(340, 'Purulia', '340', 'N', 'SUMAN CHAKRABORTY', '9674746938', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(341, 'Howrah', '341', 'N', 'SUBRATA CHATTOPADHYAY', '9674746944', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(342, 'Head Office', '342', 'Y', '', '', '', '2019-10-24 11:02:00', '', '2019-10-24 11:02:00'),
(343, 'South 24 Parganas', '343', 'N', 'SUSMITA NATH', '9674746930', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(344, 'Paschim Medinipur', '344', 'N', 'DEBANIK HORE', '9674746937', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(345, 'Purba Medinipur', '345', 'N', 'SUBHANU GHOSH', '9674749635', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(346, 'Alipurduar', '346', 'N', 'KOUSHIK CHAKRABORTY', '9674746942', '', '2019-10-21 14:24:24', '', '2019-10-21 14:24:24'),
(347, 'Paschim Burdwan', '347', 'N', '', '', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40'),
(348, 'Jhargram', '348', 'N', 'DEBANIK HORE', '9674746937', '', '2019-10-24 11:00:40', '', '2019-10-24 11:00:40');

-- --------------------------------------------------------

--
-- Table structure for table `md_category`
--

CREATE TABLE `md_category` (
  `id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `da` float(10,2) NOT NULL,
  `sa` float(10,2) NOT NULL,
  `hra` float(10,2) NOT NULL,
  `hra_max` float(10,2) NOT NULL,
  `pf` float(10,2) NOT NULL,
  `pf_max` float(10,2) NOT NULL,
  `pf_min` float(10,2) NOT NULL,
  `ta` float(10,2) NOT NULL,
  `ma` float(10,2) NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `md_category`
--

INSERT INTO `md_category` (`id`, `category`, `da`, `sa`, `hra`, `hra_max`, `pf`, `pf_max`, `pf_min`, `ta`, `ma`, `created_by`, `created_at`, `modified_by`, `modified_at`) VALUES
(1, 'Permanent', 36.82, 16.40, 10.25, 4000.00, 12.00, 2000.00, 0.00, 600.00, 196.00, 'sss', '2022-09-15 02:23:52', 'sss', '2022-10-18 07:01:32'),
(2, 'Temporary', 0.00, 0.00, 0.00, 0.00, 5.00, 600.00, 300.00, 0.00, 0.00, 'sss', '2022-09-15 02:28:31', 'sss', '2022-10-15 07:26:57');

-- --------------------------------------------------------

--
-- Table structure for table `md_department`
--

CREATE TABLE `md_department` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(55) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_department`
--

INSERT INTO `md_department` (`id`, `name`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'Manager', '2022-08-25 00:00:00', 'demo', '2022-09-23 11:09:27', 'sss'),
(2, 'Accountant', '2022-08-25 05:24:53', 'sss', '2022-09-23 11:09:38', 'sss'),
(3, 'D.A.C.Cashier', '2022-09-23 11:15:30', 'sss', NULL, ''),
(4, 'Peon', '2022-09-23 11:15:42', 'sss', NULL, ''),
(5, 'Gold Appraiser', '2022-09-23 11:16:04', 'sss', NULL, ''),
(6, 'Guard', '2022-09-23 11:16:11', 'sss', NULL, ''),
(7, 'Computer Operator', '2022-09-23 11:16:19', 'sss', NULL, ''),
(8, 'Temporary Peon', '2022-09-23 11:16:27', 'sss', NULL, ''),
(9, 'Grade IIB', '2022-09-23 11:21:03', 'sss', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `md_district`
--

CREATE TABLE `md_district` (
  `district_code` int(5) NOT NULL,
  `district_name` varchar(50) NOT NULL,
  `dist_sort_code` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_district`
--

INSERT INTO `md_district` (`district_code`, `district_name`, `dist_sort_code`) VALUES
(327, 'DARJEELING', 'DAR'),
(328, 'JALPAIGURI', 'JPG'),
(329, 'COOCH BEHAR', 'COOH'),
(330, 'UTTAR DINAJPUR', 'NDNJ'),
(331, 'DAKSHIN DINAJPUR', 'SDNJ'),
(332, 'MALDAH', 'MLD'),
(333, 'MURSHIDABAD', 'MUR'),
(334, 'BIRBHUM', 'BRH'),
(335, 'PURBA BARDHAMAN', 'EBDN'),
(336, 'NADIA', 'NDA'),
(337, 'NORTH TWENTY FOUR PARGANAs', 'N24'),
(338, 'HOOGHLY', 'HOG'),
(339, 'BANKURA', 'BNK'),
(340, 'PURULIA', 'PUR'),
(341, 'HOWRAH', 'HWH'),
(342, 'KOLKATA', 'KOL'),
(343, 'SOUTH TWENTY FOUR PARGANAs', 'S24'),
(344, 'PASCHIM MIDNAPORE', 'WMDN'),
(345, 'PURBA MIDNAPORE', 'EMDN'),
(346, 'ALIPURDUAR', 'ALPD'),
(347, 'PASCHIM BARDHAMAN', 'WBDN'),
(348, 'JHARGRAM', 'JHG');

-- --------------------------------------------------------

--
-- Table structure for table `md_employee`
--

CREATE TABLE `md_employee` (
  `emp_code` int(11) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `emp_catg` int(10) NOT NULL,
  `emp_dist` int(10) NOT NULL,
  `dob` date DEFAULT NULL,
  `join_dt` date DEFAULT NULL,
  `ret_dt` date DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `phn_no` varchar(14) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `pan_no` varchar(50) DEFAULT NULL,
  `aadhar_no` varchar(50) DEFAULT NULL,
  `emp_addr` text DEFAULT NULL,
  `bank_name` varchar(50) DEFAULT NULL,
  `bank_ac_no` varchar(50) DEFAULT NULL,
  `pf_ac_no` varchar(50) DEFAULT NULL,
  `UAN` varchar(25) DEFAULT NULL,
  `basic_pay` decimal(10,2) DEFAULT 0.00,
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `emp_status` char(1) DEFAULT 'A' COMMENT 'R=>Retired,A=>Active,S=>Suspended,RG=>Resigned',
  `remarks` varchar(255) DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_employee`
--

INSERT INTO `md_employee` (`emp_code`, `emp_name`, `emp_catg`, `emp_dist`, `dob`, `join_dt`, `ret_dt`, `designation`, `department`, `phn_no`, `email`, `pan_no`, `aadhar_no`, `emp_addr`, `bank_name`, `bank_ac_no`, `pf_ac_no`, `UAN`, `basic_pay`, `created_by`, `created_dt`, `emp_status`, `remarks`, `modified_by`, `modified_dt`) VALUES
(1, 'Hitangshu Roy', 1, 339, '1988-03-31', '2018-01-03', '2048-03-31', 'Manager', '1', '7908834818', '', '', '', 'Milanshree Cinema Road, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20122081', '', '', '57870.00', 'sss', '2022-09-23 11:18:59', 'A', '', 'sss', '2022-10-14 06:56:47'),
(2, 'Prasun Dey', 1, 339, '1980-03-05', '2008-12-04', '2040-03-31', 'Accountant', '2', '9679102892', '', '', '', 'Nutanmahal, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20104765', '', '', '55880.00', 'sss', '2022-09-23 11:19:55', 'A', '', 'sss', '2022-10-14 06:56:59'),
(3, 'Janardan Sebait', 1, 339, '1963-11-01', '1992-12-01', '2023-11-30', 'Gr-II B - Deposit Officer', '9', '9474186501', '', '', '', 'Gopalganja, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10106016', '', '', '59860.00', 'sss', '2022-10-12 01:49:24', 'A', '', 'sss', '2022-10-14 06:57:09'),
(4, 'Sanatan Ghosh', 1, 339, '1969-11-29', '1992-12-01', '2029-11-30', 'Gr-II B - Loan Officer', '9', '9126369072', '', '', '', 'Shyamrayer Bazar, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10108744', '', '', '59860.00', 'sss', '2022-10-12 01:57:53', 'A', '', 'sss', '2022-10-14 06:57:22'),
(5, 'Lalmohan Dhak', 1, 339, '1967-05-15', '1992-12-01', '2027-05-31', 'Grade IIB - Head Cashier', '9', '9475337172', '', '', '', 'Pokabandh North, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10105782', '', '', '59860.00', 'sss', '2022-09-23 11:24:19', 'A', '', 'sss', '2022-10-14 06:57:32'),
(6, 'Tapas Kumar Dey', 1, 339, '1973-03-23', '2008-09-25', '2033-03-31', 'D.A.C.Cashier', '3', '9474564872', '', '', '', 'Basantitala, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10114226', '', '', '32280.00', 'sss', '2022-09-23 11:25:23', 'A', '', 'sss', '2022-10-14 06:57:47'),
(7, 'Gopi Krishna Kar', 1, 339, '1968-01-08', '2008-09-25', '2028-01-31', 'D.A.C.Cashier', '3', '7863967121', '', '', '', 'Krishnaganja, Kailashtala, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10108872', '', '', '30550.00', 'sss', '2022-09-23 11:26:40', 'A', '', 'sss', '2022-10-18 07:05:03'),
(8, 'Jahar Bhattacharyya', 1, 339, '1963-08-21', '2008-08-25', '2023-08-31', 'D.A.C. Cashier', '3', '9732210358', '', '', '', 'Station Road, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20104280', '', '', '30550.00', 'sss', '2022-10-12 02:07:51', 'A', '', 'sss', '2022-10-18 07:04:09'),
(9, 'Arun Kshetrapal', 1, 339, '1965-08-03', '1985-09-01', '2025-08-31', 'Peon', '4', '9002893990', '', '', '', 'Matukganja, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10108796', '', '', '33145.00', 'sss', '2022-10-12 02:11:50', 'A', '', 'sss', '2022-10-14 06:59:22'),
(10, 'Partha Mukherjee', 1, 339, '1993-10-03', '2014-07-01', '2053-10-31', 'D.A.C. Cashier', '3', '7001538066', '', 'BVOPM9325A', '691090393828', 'Goswami Para, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20114909', '', '', '23360.00', 'sss', '2022-10-12 02:14:28', 'A', '', 'sss', '2022-10-26 09:38:16'),
(11, 'Goutam Mukherjee', 1, 339, '1977-01-08', '2015-11-17', '2037-01-31', 'D.A.C. Cashier', '3', '8001995685', '', '', '', 'Kadakuli, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20118521', '', '', '23360.00', 'sss', '2022-10-12 02:16:52', 'A', '', 'sss', '2022-10-18 07:04:35'),
(12, 'Sekh Imran', 1, 339, '1994-04-22', '2020-01-01', '2054-04-30', 'Peon', '4', '9749866486', '', '', '', 'Katandhar, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20123493', '', '', '15500.00', 'sss', '2022-10-12 02:23:08', 'A', '', 'sss', '2022-10-14 06:59:58'),
(13, 'Chandi Chatterjee', 1, 339, '1985-01-01', '2022-01-01', '2045-01-31', 'Peon', '4', '7407359045', '', '', '', 'Shyamrayer Bazar, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20109621', '', '', '14500.00', 'sss', '2022-10-12 02:44:29', 'A', NULL, NULL, NULL),
(14, 'Uttam Kumar Dey', 1, 339, '1972-10-27', '2022-01-01', '2032-10-31', 'Peon', '4', '8348353430', '', '', '', 'Tilbari, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20102437', '', '', '14500.00', 'sss', '2022-10-12 02:47:13', 'A', NULL, NULL, NULL),
(15, 'Tufan Banerjee', 1, 339, '1992-01-27', '2022-01-01', '2052-01-31', 'Peon', '4', '9851211244', '', '', '', 'Goswami Para, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20111876', '', '', '14500.00', 'sss', '2022-10-12 02:49:20', 'A', NULL, NULL, NULL),
(16, 'Sajal Mukherjee', 1, 339, '1967-10-02', '2022-01-01', '2027-10-31', 'Peon', '4', '9606642156', '', '', '', 'Kadakuli, Biswaspara, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10110886', '', '', '14500.00', 'sss', '2022-10-12 02:51:27', 'A', NULL, NULL, NULL),
(17, 'Bhairab Dutta', 1, 339, '1978-06-17', '2022-01-01', '2038-06-30', 'Peon', '4', '7797683218', '', '', '', 'Krishnaganja, Kusumtala, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20111826', '', '', '14500.00', 'sss', '2022-10-12 02:53:26', 'A', NULL, NULL, NULL),
(18, 'Prasenjit Kumar Dey', 1, 339, '1976-01-13', '2022-01-01', '2036-01-31', 'Peon', '4', '9732172152', 'pkdey2008@gmail.com', 'APOPD1284L', '888921305192', 'Dalmadal Road, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10113013', '', '', '14500.00', 'sss', '2022-10-12 02:20:13', 'A', '', 'sss', '2022-10-14 07:00:26'),
(19, 'Biswanath Dey', 2, 339, '1963-11-01', '2014-01-22', '2023-11-30', 'Gold Appraiser', '5', '9434930658', '', '', '', 'Boletala, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10109891', '', '', '21000.00', 'sss', '2022-10-13 07:23:35', 'A', NULL, NULL, NULL),
(20, 'Sourav Guin', 1, 339, '1989-03-27', '2022-09-01', '2049-03-31', 'Peon', '4', '6295051852', '', '', '', 'Krishnaganja, Kailashtala, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20120730', '', '', '14500.00', 'sss', '2022-10-12 02:55:52', 'A', '', 'sss', '2022-10-18 10:00:16'),
(21, 'Sankar Chandra Kar', 2, 339, '1978-10-01', '2022-10-01', '2038-10-31', 'Temporary Peon', '8', '8759763170', '', '', '', 'Dheladuar, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '10113275', '', '', '11000.00', 'sss', '2022-10-13 07:26:45', 'A', NULL, NULL, NULL),
(22, 'Arjun Kauri', 2, 339, '1985-03-12', '2020-12-02', '2045-03-31', 'Computer Operator', '7', '9933526070', '', 'BIHPK5075P', '369825220792', 'Turki, Sitarampur, P.O. Bishnupur, Dist. Bankura, Pin. 722122', 'The Bishnupur Town Co-operative Bank Limited', '20104071', '', '', '13000.00', 'sss', '2022-10-13 07:58:54', 'A', '', 'sss', '2022-10-26 09:32:02'),
(23, 'Gopal Mukherjee', 2, 339, '1968-11-14', '2013-11-01', '2028-11-30', 'Arms Guard', '6', '9635581042', '', '', '', 'Sharma Para, P.O. Bon Radhanagar, Dist. Bankura, Pin. 722157', 'The Bishnupur Town Co-operative Bank Limited', '20105798', '', '', '20000.00', 'sss', '2022-10-13 08:02:27', 'A', NULL, NULL, NULL),
(24, 'Nimai Chandra Nandi', 2, 339, '1967-10-19', '2013-10-03', '2027-10-31', 'Arms Guard', '6', '9475864608', '', '', '', 'Chatra, P.O. Darapur, Dist. Bankura, Pin. 722141', 'The Bishnupur Town Co-operative Bank Limited', '20105799', '', '', '20000.00', 'sss', '2022-10-13 08:26:14', 'A', NULL, NULL, NULL),
(25, 'Sahid Afridi Khan', 2, 339, '2001-05-12', '2022-01-01', '2061-05-31', 'Temporary Peon', '8', '7076225022', '', '', '', 'Aguribandh, P.O. Punisole, Dist. Bankura, Pin. 722152', 'The Bishnupur Town Co-operative Bank Limited', '20124646', '', '', '10000.00', 'sss', '2022-10-13 08:28:58', 'A', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `md_fin_year`
--

CREATE TABLE `md_fin_year` (
  `sl_no` int(11) NOT NULL,
  `fin_yr` varchar(30) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` varchar(50) DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_fin_year`
--

INSERT INTO `md_fin_year` (`sl_no`, `fin_yr`, `created_by`, `created_dt`, `modified_by`, `modified_dt`) VALUES
(1, '2020-21', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `md_leave_allocation`
--

CREATE TABLE `md_leave_allocation` (
  `sl_no` int(10) NOT NULL,
  `type` varchar(25) NOT NULL,
  `start_month` int(2) NOT NULL,
  `end_month` int(2) NOT NULL,
  `amount` int(10) NOT NULL,
  `credit_on` date NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `md_month`
--

CREATE TABLE `md_month` (
  `id` int(11) NOT NULL,
  `month_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_month`
--

INSERT INTO `md_month` (`id`, `month_name`) VALUES
(1, 'January'),
(2, 'February'),
(3, 'March'),
(4, 'April'),
(5, 'May'),
(6, 'June'),
(7, 'July'),
(8, 'August'),
(9, 'September'),
(10, 'October'),
(11, 'November'),
(12, 'December');

-- --------------------------------------------------------

--
-- Table structure for table `md_parameters`
--

CREATE TABLE `md_parameters` (
  `sl_no` int(11) NOT NULL,
  `param_desc` varchar(100) CHARACTER SET latin1 NOT NULL,
  `param_value` varchar(100) CHARACTER SET latin1 NOT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `md_parameters`
--

INSERT INTO `md_parameters` (`sl_no`, `param_desc`, `param_value`, `modified_by`, `modified_dt`) VALUES
(1, 'DA Percentage', '3', 'sss', '2022-08-25 03:50:14'),
(2, 'HRA Percentage', '12', 'sss', '2021-02-08 07:11:09'),
(3, 'Medical Allowance', '500', 'sss', '2021-02-08 07:24:55'),
(4, 'PF Percentage', '12', 'anirbanc', '2021-04-02 06:46:28'),
(5, 'Yearly increment ', '0', 'sss', '2021-02-18 03:56:53');

-- --------------------------------------------------------

--
-- Table structure for table `md_ptax`
--

CREATE TABLE `md_ptax` (
  `id` int(10) NOT NULL,
  `st` decimal(10,2) NOT NULL DEFAULT 0.00,
  `end` decimal(10,2) NOT NULL,
  `ptax` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_ptax`
--

INSERT INTO `md_ptax` (`id`, `st`, `end`, `ptax`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, '0.00', '10000.00', '0.00', NULL, NULL, '2022-09-01 12:32:53', 'sss'),
(2, '10001.00', '15000.00', '110.00', NULL, NULL, NULL, NULL),
(3, '15001.00', '25000.00', '130.00', NULL, NULL, NULL, NULL),
(4, '25001.00', '40000.00', '150.00', NULL, NULL, NULL, NULL),
(5, '40001.00', '99999999.00', '200.00', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `md_ptax_slab`
--

CREATE TABLE `md_ptax_slab` (
  `effective_dt` date NOT NULL,
  `sl_no` int(11) NOT NULL,
  `from_amt` decimal(10,2) NOT NULL,
  `to_amt` decimal(10,2) NOT NULL,
  `tax_amt` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_ptax_slab`
--

INSERT INTO `md_ptax_slab` (`effective_dt`, `sl_no`, `from_amt`, `to_amt`, `tax_amt`) VALUES
('2017-01-01', 1, '10000.00', '15000.00', '110.00'),
('2017-01-01', 2, '15001.00', '25000.00', '130.00'),
('2017-01-01', 3, '25001.00', '40000.00', '150.00'),
('2017-01-01', 4, '40000.00', '4000000.00', '200.00');

-- --------------------------------------------------------

--
-- Table structure for table `md_users`
--

CREATE TABLE `md_users` (
  `user_id` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_type` enum('U','M','A','B') NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_status` char(1) NOT NULL,
  `branch_id` varchar(20) NOT NULL,
  `st` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `md_users`
--

INSERT INTO `md_users` (`user_id`, `password`, `user_type`, `user_name`, `user_status`, `branch_id`, `st`, `created_by`, `created_dt`, `modified_by`, `modified_dt`) VALUES
('abdulk', '$2y$10$sLq.fPRfb/an4eW1xRRXm.AOLhPG7Y6FlG8vkrHWE3LMqDSulztyW', 'U', 'Abdul Kalam', 'A', '334', 0, 'synergic', '2019-12-10 11:30:21', 'synergic', '2019-12-11 07:36:45'),
('abirlalb', '$2y$10$WJou1qmKBbExsO2eMi1GmucDoAprttcLrBqkJS1uvbtX3umbi2gtW', 'M', 'Abirlal Bhuiya', 'A', '337', 0, 'synergic', '2019-12-10 12:24:03', NULL, NULL),
('ajayp', '$2y$10$2v.wHWlgr52Zl.tRAw7v0uP4Olrqh9JgqQrHjdhVmsDe0qgbvHS/i', 'M', 'Ajay Kr Paul', 'A', '337', 0, 'synergic', '2019-12-10 11:48:12', NULL, NULL),
('aksamm', '$2y$10$.bQ6XMbnyNiowyQ/.9Hp7.Cam.d4P86DSEVbSBL33wrUlhwP4eTp2', 'U', 'Md. Aksam Ali Mondal', 'A', '335', 0, 'synergic', '2019-12-10 12:11:30', NULL, NULL),
('alokek', '$2y$10$B04pBdohpn1n0ooXaH9dSOWQ.KadlZ0y6qV4lmkHCiNiVh.cIbBi6', 'M', 'Aloke Kr. Koley', 'A', '343', 0, 'synergic', '2019-12-10 11:46:34', NULL, NULL),
('anilc', '$2y$10$Zv1OSNnBsi7lxedzEgFXaeMkEdRkp21CxxMT5RoTKoFyPQSq0Glby', 'M', 'Anil Ch. Halder', 'A', '327', 0, 'synergic', '2019-12-10 11:55:16', NULL, NULL),
('anilh', '$2y$10$sLq.fPRfb/an4eW1xRRXm.AOLhPG7Y6FlG8vkrHWE3LMqDSulztyW', 'M', 'Anil Ch. Halder', 'A', '328', 0, 'synergic', '2019-12-10 12:05:46', NULL, NULL),
('aninditak', '$2y$10$AJ/NeLcMHKy60aP1YtDCEezzjNqtuIHn9t.xkIfexQ002Npc1fsgS', 'U', 'Anindita Karmakar', 'A', '335', 0, 'synergic', '2019-12-10 12:11:06', NULL, NULL),
('anirbanc', '$2y$10$VJSRo7yWYD95LbPNYXBqkO27FZKCx0WyO8IBLekbFXEuoWi5QZPjm', 'A', 'Anirban Chakraborty', 'A', '342', 0, 'synergic', '2020-01-10 10:10:38', NULL, NULL),
('anupamm', '$2y$10$178RwZd8Lljb4Re0bXgADu3QIRbNqgfDb1mQ10ANo80m9Jqn7UiZy', 'A', 'Anupam Mukherjee', 'A', '342', 0, 'synergic', '2019-12-11 07:32:46', NULL, NULL),
('aparajitas', '$2y$10$HZPhfrdYv2lgK7SHobUw2ujhrA6HXwwlA4z1Q0WVow7UGF9aQryrS', 'M', 'Aparajita Samanta', 'A', '344', 0, 'synergic', '2019-12-10 12:29:22', NULL, NULL),
('aparajitas1', '$2y$10$y7zcWEzNWjQ.xOyEQ6ZYf.ww/Eu1bKuCGVotfyQSYeNbTUEx9jKk.', 'M', 'Aparajita Samanta', 'A', '348', 0, 'synergic', '2019-12-16 06:46:38', NULL, NULL),
('ashokeb', '$2y$10$2jkKrmRi/MkfWiR597Fau.7QELml2GP305Ty4DWR6/h64Bi50yggS', 'U', 'Ashoke Kumar Banerjee', 'A', '335', 0, 'synergic', '2019-12-10 12:11:41', NULL, NULL),
('bank', '$2y$10$UQ56rdoPRpa.K/JLqi6CQOOS5gJdRdEygcRzYuKr3nIUgr8iuWxtm', 'B', 'bank(ICICI)', 'A', '342', 0, 'synergic', '2020-06-05 09:48:01', NULL, NULL),
('barund', '$2y$10$a1KjSnASk.PH/BE53wD84etLQEoEO8irXqdPpa/c9Xv25Yq8pCVSS', 'A', 'Barun Das', 'A', '342', 0, 'synergic', '2019-12-11 07:33:36', NULL, NULL),
('bholanathm', '$2y$10$Z48qnPc8Fq5O8CVK.NVIUuQz.C1.hqrSuswi0s2wcIhvBynQtQhVy', 'A', 'Bholanath Mondal', 'A', '342', 0, 'synergic', '2019-12-11 07:33:12', NULL, NULL),
('bidyuts', '$2y$10$9651nga3/lIpZK.H/s9GT.LLAazY3yi2Ay3d481IuqHezWvh6f2ky', 'U', 'Bidyut Bhushan Sadhu', 'A', '338', 0, 'synergic', '2019-12-10 12:24:47', NULL, NULL),
('biswajitm', '$2y$10$GXfTbtD5y5FkziIg9Li8Fujh3SLB5DU1c9/fR.Ro62G3JXRdgItHO', 'U', 'Biswajit Mukherjee', 'A', '335', 0, 'synergic', '2019-12-10 12:10:55', NULL, NULL),
('debanikh', '$2y$10$O3sLgr0z4.5BnpbRzWrnWuZf9OtkS5r/YBMmaWU0GyFhLMUy14L8O', 'M', 'Debanik Hore', 'A', '344', 0, 'synergic', '2019-12-10 12:29:08', NULL, NULL),
('debashisr', '$2y$10$6eAYP7mSothSPE99fdZyq.zvgEOhDhldyy4t4.31svkhDqWkFGRjC', 'U', 'Debashis Roy ', 'A', '335', 0, 'synergic', '2019-12-10 12:10:07', NULL, NULL),
('debasisc', '$2y$10$WGIYwFYyAEfdAYSK0Q0qTOPobSZpfUafqc4OlewbEW9SL7sPEYKA.', 'U', 'Debasis Chatterjee', 'A', '332', 0, 'synergic', '2019-12-10 11:59:07', NULL, NULL),
('debasisd', '$2y$10$j7DQtHyE8gXWCfPWbi/IteVJztvz9ZrKtYebsi8zFIn12/cuMzT22', 'M', 'Debasis Dutta', 'A', '339', 0, 'synergic', '2019-12-10 12:12:33', NULL, NULL),
('debasisd1', '$2y$10$JLo5YSBlvtXXu.CTx4lQXOlKw0BF3oq6juNCaaefkgMfZyhW4bFTq', 'M', 'Debasis Dutta', 'A', '340', 0, 'synergic', '2019-12-10 12:30:42', NULL, NULL),
('dipakb', '$2y$10$PlpbHVXflKE6oeLQG1k0rez6cjBZDU0oso4w5bp1z8.1P8p.RBG5u', 'M', 'Dipak Barua', 'A', '331', 0, 'synergic', '2019-12-10 12:02:13', NULL, NULL),
('dipakp', '$2y$10$NguRaq86gsJW/bRUO4otdOMnOQkW3TxvsYHsW4zh05PoF6S0Y8afC', 'U', 'Dipak Kumar Pal', 'A', '333', 0, 'synergic', '2019-12-10 11:35:07', NULL, NULL),
('eshanm', '$2y$10$3fHNK1jjueH/0uqXbiBl2OWse4YYIr9tDnIxk00tbD25ueStpPmeO', 'A', 'Eshan Mondal', 'A', '342', 0, 'synergic', '2020-06-15 10:29:09', NULL, NULL),
('hiralalp', '$2y$10$zYC5dkoDl4PvRXjxqLJoVursc1wcPNKlHuwctiLU.tExyeOa2fQyu', 'M', 'Hiralal Piri', 'A', '335', 0, 'synergic', '2019-12-10 12:10:35', NULL, NULL),
('ishanb', '$2y$10$IWEhKsTaX5myF9hQ3.Ti2.1nvABEGLzm2DTJpzzeLGIuQrdIqzA9.', 'M', 'Ishan Banik', 'A', '332', 0, 'synergic', '2019-12-10 11:58:27', NULL, NULL),
('jamira', '$2y$10$gPQWK8WBtfHU6uljf4.YzOSTs2LaNtc4hFEzs/0vpPZyW00WwELya', 'U', 'Jamir Ahmed Khan', 'A', '344', 0, 'synergic', '2019-12-10 12:29:34', NULL, NULL),
('jayantab', '$2y$10$ulsAfjujWFzWcbm5/8ibTuAKlwqeMQKQDn8gzOpbtB5Gvw7t2UK0e', 'U', 'Jayanta Basu', 'A', '328', 0, 'synergic', '2019-12-10 12:06:20', NULL, NULL),
('jayantah', '$2y$10$aKg7yyb9bfzn6s34MtY5Lek9D5Dq0gf0rufh3DM6y/nH.dVKRxmSS', 'U', 'Jayanta Kumar Halder', 'A', '340', 0, 'synergic', '2019-12-10 12:31:24', NULL, NULL),
('jayantas', '$2y$10$bL3Op2HGmsZCgTi962.8NOSkEZuMleN/ryRkuogRZhLjY3Iao4LvS', 'U', 'Jayanta Kr. Saha', 'A', '334', 0, 'synergic', '2019-12-10 11:28:26', NULL, NULL),
('joydeepc', '$2y$10$jnREX5pjjFVOTwqRrEj6PeqOn9SMuPXobJ/yMwTHoPFaDl1znFtdW', 'U', 'Joydeep Chakraborty', 'A', '333', 0, 'synergic', '2019-12-10 11:35:22', NULL, NULL),
('kalyanb', '$2y$10$d.BLC80wFbnFw7aW8c9eheJYh877U75Mc18Sq0Z0o..6Vu1ou526e', 'M', 'Kalyan Biswas', 'A', '339', 0, 'synergic', '2019-12-10 12:12:17', NULL, NULL),
('kalyann', '$2y$10$Xtn7b4QCMsi/RbxpuMcK0u4c84L0.a/HYEAt8/qzW/TDICDHp2sbS', 'M', 'Kalyan Naskar', 'A', '330', 0, 'synergic', '2019-12-10 12:00:45', NULL, NULL),
('kanchans', '$2y$10$r3Dm9c.Yirniwlxjkx8PhOIa84xUcSAfDjBOkm7jf8f3C2Y2ILZdS', 'U', 'Kanchan Sengupta', 'A', '343', 0, 'synergic', '2019-12-10 11:47:19', NULL, NULL),
('kashinathm', '$2y$10$5kfp3id/xY3wvrqlUucXtuyVQaH1iLBmla38Maki6zccI9JTG7bdm', 'U', 'Kashinath Mukherjee', 'A', '330', 0, 'synergic', '2019-12-10 12:01:01', NULL, NULL),
('koushikc', '$2y$10$nJTWEADJC6HDhRxi03UiAOnsRyudnzP4FxfNLTY2FVtDLb.0ChnXK', 'M', 'Koushik Chakraborty', 'A', '329', 0, 'synergic', '2019-12-10 11:51:22', NULL, NULL),
('koushikc1', '$2y$10$7AG1F.vlZ3KMggliGEtUa.uL5PkGW0/T7iIe9oCJi8xuL9KzB5IbK', 'M', 'Koushik Chakraborty', 'A', '346', 0, 'synergic', '2019-12-18 05:07:24', NULL, NULL),
('kurmanuddins', '$2y$10$9.7DFohkt4K3Os9urghY3u.o8Wa3C9iBRZc6pnH57vwD2zi67Y4NW', 'U', 'Sk. Kurmanuddin', 'A', '343', 0, 'synergic', '2019-12-10 11:47:03', NULL, NULL),
('manab', '$2y$10$4lh8owRjV9NClHfR6nA11O67Btw/HrMsU0L01QAg4DTcQRubInxdW', 'A', 'Manab Babu', 'A', '342', 0, 'synergic', '2020-07-27 06:20:29', NULL, NULL),
('manasap', '$2y$10$F4n57IJiQNLcWzXxCS/A.uHKU/B9xI0haoncA1KmXk6PRQq15iCt.', 'U', 'Manasa Ram pal', 'A', '331', 0, 'synergic', '2019-12-10 12:02:35', NULL, NULL),
('Mantum', '$2y$10$Ke9/gMW0L28QKINHq0eC0OUMc.fVljOMjiezJM0K6jO94EwjpINJ2', 'M', 'Mantu Kumar Maji', 'A', '334', 0, 'synergic', '2019-12-10 11:27:41', NULL, NULL),
('mehabuba', '$2y$10$dRckFKKvsUq4JZVd2Pu6IOsBbDsgC43u7.9KIPKvwmVRHt21VEQqG', 'U', 'Mehabub Alam', 'A', '334', 0, 'synergic', '2019-12-10 11:30:35', NULL, NULL),
('mihirs', '$2y$10$3lRg3BVL1Ep4ERm9JsmNDevGbzabnR3Qa2ZcH1iEOjFq0lizrxd0e', 'U', 'Mihir Kr. Saha', 'A', '334', 0, 'synergic', '2019-12-10 11:29:45', NULL, NULL),
('mridulm', '$2y$10$0ZWmzYk6mpVNO0qC4ZERd.I2M3NZ1pHUswZT8/3y/L6WbnuvuwwFm', 'M', 'Mridul Mandal', 'A', '327', 0, 'synergic', '2019-12-10 11:54:52', NULL, NULL),
('mridulman', '$2y$10$LM84yELBw/3ZceD04joM9uXFNIl2dZ23XJ8LxQ3ASKK51LI0YmUri', 'M', 'Mridul Mandal', 'A', '328', 0, 'synergic', '2019-12-10 12:05:17', NULL, NULL),
('narayang', '$2y$10$f2RCS3wmms3RrukZHThXbe50hDjoOoiGeWQJUgtqrNGsUwmFSGr6i', 'U', 'Narayan Ch. Ghosh', 'I', '338', 0, 'synergic', '2019-12-10 12:24:33', 'Somnath Kotal', '2020-12-25 04:46:44'),
('natarajm', '$2y$10$dN1wv5kR9KZWf6F5KdjqAuThNdS0FQFJzo9romlPEYLFb8tkw71da', 'U', 'Nataraj Mukherjee', 'A', '335', 0, 'synergic', '2019-12-10 12:11:18', NULL, NULL),
('parthar', '$2y$10$nxp6CcuIoS22ZQprQbaYCugDqjUtz/ZacNWzRbyFPITs2mCb9LEdy', 'U', 'Partha Roy', 'A', '332', 0, 'synergic', '2019-12-10 11:59:29', NULL, NULL),
('pijushp', '$2y$10$3xd96MMBUfQs6cRxXKgRcuLwMMjzV/Dt15O4vDkJy.Pd5b4M1RTd2', 'M', 'Pijush Kanti  Patra', 'A', '345', 0, 'synergic', '2019-12-10 12:28:15', NULL, NULL),
('prabird', '$2y$10$Iz6Y69c/5DyBgohAqkpCMOmp1tjskEU4aDPDAeGWLJmymiHvaWBTa', 'M', 'Prabir Dutta', 'A', '334', 0, 'synergic', '2019-12-10 11:28:03', NULL, NULL),
('prabird2', '$2y$10$LZYRNFEyPaGSxrK4u.1aReMfs8eaAxcag0CIUSkDEkc/OUmVMG5Ta', 'U', 'Prabir Kumar Dutta', 'A', '339', 0, 'synergic', '2019-12-10 12:13:29', 'Kalyan Biswas', '2019-12-31 08:01:58'),
('prabirs', '$2y$10$ruOv0sygcNMf2032fCSJqeShD2jegAiCs8NEeJYibfryU52d8K9pu', 'U', 'Prabir Kr. Seth', 'A', '339', 0, 'synergic', '2019-12-10 12:13:52', NULL, NULL),
('prosadm', '$2y$10$GR4yHGrbZqAXfdiv0Aw3H.hITZDaSdyuJhTzGMGqODUYzt.HocuL6', 'M', 'Prosad Mandal', 'A', '330', 0, 'synergic', '2019-12-10 12:00:33', NULL, NULL),
('ram', '$2y$10$1PH.NgfJMQ5Ax1Z/0JDo3OiwcvmBTgQsTRQRqT3XQzCXQ6raosQiS', 'U', 'ram dey', 'A', '341', 0, 'synergic', '2019-12-23 12:44:12', NULL, NULL),
('rupakd', '$2y$10$1Ur1.Z5SaX1dTEHq4zr6suMzBUSrFb23zOH0PLhzDOs9md7NmarIS', 'M', 'Rupak Das', 'A', '341', 0, 'synergic', '2019-12-10 11:50:26', NULL, NULL),
('sabitab', '$2y$10$GMu7kpoVNISfYD.sqMnIbOP7wsA4rPhxa5xfHAYUwYwFpqIrszux6', 'M', 'Sabita Biswas', 'A', '337', 0, 'synergic', '2019-12-10 11:47:52', NULL, NULL),
('saiefi', '$2y$10$tDHGl5Z54jLBKGM1BqiTN.IzZ6xoEfN/JWzQilsh6D4HsRSs7JtFu', 'U', 'Saief Iqbal', 'A', '328', 0, 'synergic', '2019-12-10 12:06:08', NULL, NULL),
('salamath', '$2y$10$G.QIF.u68R2Kte5EycZVv.OL465b/B9RxwReJM82EJhtGq2eyQ0rC', 'U', 'Md. Salamat Hossain', 'A', '332', 0, 'synergic', '2019-12-10 11:59:46', NULL, NULL),
('samik', '$2y$10$soiEAUxRMkIrCBBLdlF.A.bxSuD0v00ytj3EeMFG2uWIGuPvawMvy', 'M', 'samik', 'A', '342', 0, 'synergic', '2020-09-09 08:13:17', NULL, NULL),
('samird', '$2y$10$dwxOf.qo7.ezrtpSQME41euwCirc.DhYCqHsV.mL4juTr8DdFHSoa', 'U', 'Samir Kumar Das', 'A', '341', 0, 'synergic', '2019-12-10 11:50:40', NULL, NULL),
('samirp', '$2y$10$Qz99S8yF.dmrsOqgOWJJlerw7P5mrE/JRwRX/NFyVuCcBXwFCxN3G', 'U', 'Samir Pandit', 'A', '329', 0, 'synergic', '2019-12-10 11:51:54', NULL, NULL),
('samirp1', '$2y$10$slVBqJtlmUc6Lne706t3RebNu0oA0uJjyFQogIGoDqyMmqGIOnrOC', 'U', 'Samir Pandit', 'A', '346', 0, 'synergic', '2019-12-19 06:30:56', 'Koushik Chakraborty', '2020-02-10 09:56:06'),
('samsuddinm', '$2y$10$EuTSe4HwhoTNJducOSmQJ.1mQPPhI//DyHDv1YvN0tazGNL5StxDK', 'U', 'Samsuddin Mondal', 'A', '334', 0, 'synergic', '2019-12-10 11:30:50', NULL, NULL),
('sarajitg', '$2y$10$78gWsx2/nHpMnejUR2quw.ehMppwYS3cJ.1Rux3h//emmWuY6YM1S', 'U', 'Sarajit Ghosal', 'A', '333', 0, 'synergic', '2019-12-10 11:34:51', NULL, NULL),
('satyendrag', '$2y$10$fhCVFjz8utipH1KgJ/rMdO.xxQQDCXHw9j7A3hwsFwRx6MbQ.shN.', 'U', 'Satyendra Nath Ghosh', 'A', '339', 0, 'synergic', '2019-12-10 12:14:02', NULL, NULL),
('saumenk', '$2y$10$w7W4WVg0zVeg/7vaqFPdHeuQQiYSpS.o8vAMZWp9cDK5GGo.0X5eO', 'M', 'Saumen Kundu', 'A', '333', 0, 'synergic', '2019-12-10 11:34:30', NULL, NULL),
('saumenk1', '$2y$10$4Ae7nfJxj57oKMIrj9zG8OFkdQIozXHpK24viZLzJWT3vnedD0RjS', 'M', 'Saumen Kundu ', 'A', '336', 0, 'synergic', '2019-12-10 11:37:09', 'Subhashish Biswas', '2020-12-16 02:18:36'),
('sengelb', '$2y$10$6qAMl0aSrzo95XBvgoQ4jeYEvxpfRskfaE.s14iIwfXNcpeQyEKru', 'M', 'Marshal Sengel Baskey', 'A', '331', 0, 'synergic', '2019-12-10 12:02:00', NULL, NULL),
('shantih', '$2y$10$s4yDWUJex51Cm5Gh9lvYz.qacv3JdPrtEVReitIIUa2EHF.2bwVtK', 'U', 'Shanti Nath Hazra', 'A', '345', 0, 'synergic', '2019-12-10 12:28:30', NULL, NULL),
('shyamc', '$2y$10$jpWNkZxR8gs2yZwoVdTcS.s.jCBVaJg/csMsZjcpYOBngWeeT4o5K', 'U', 'Shyam Kumar Chhetri', 'A', '332', 0, 'synergic', '2019-12-10 11:59:18', NULL, NULL),
('somnathk', '$2y$10$HLNRxcJFgBeLruAsTLEIPultOTFTefebkXEFmVO10oXst3g2M0gCO', 'M', 'Somnath Kotal', 'A', '338', 0, 'synergic', '2019-12-10 12:23:50', NULL, NULL),
('sss', '$2y$10$.hGN2NZbdZxhvY6t4f7Xp.izntLjFMXhKAY1rIBaShZUbMdmH1KvG', 'A', 'Synergic', 'A', '341', 0, 'Synergic Softek', NULL, 'sss', '2022-11-09 07:34:52'),
('SubhamayA', '$2y$10$rFrK.KdvL6wtGDl8VViPGu1qzXD5m6F1mHyfTovz4njGjs.H8xLlu', 'U', 'Subhamay Datta', 'A', '346', 0, 'Koushik Chakraborty', '2020-11-05 07:13:51', NULL, NULL),
('SubhamayC', '$2y$10$A9zNwry4Pm04sGlcXXwEO.NfdT65PMfhqTFm8cZbQJBNAciXSjgCu', 'U', 'Subhamay Datta', 'I', '346', 0, 'Koushik Chakraborty', '2020-11-05 07:12:11', 'Koushik Chakraborty', '2020-11-05 07:13:23'),
('SubhamayCob', '$2y$10$vVT.7Btc9jsP9g0/75mPOua9JskLfq9CkZhsRBxXJP1TrTCQ90i7O', 'U', 'Subhamay Datta', 'A', '329', 0, 'Koushik Chakraborty', '2020-11-05 07:14:54', NULL, NULL),
('subhanug', '$2y$10$BUszNXQ396kM5gd91vLQseZVTBNNVH27uxCtWl8fPA7W09RMiNI0C', 'M', 'Subhanu Ghosh', 'A', '345', 0, 'synergic', '2019-12-10 12:28:02', NULL, NULL),
('subhashishb', '$2y$10$Db3yo2wI/4XTlubVvEoswePPmSk6epG4QZ8tEpNEMpx5mXyqtNUKa', 'M', 'Subhashish Biswas', 'A', '336', 0, 'synergic', '2019-12-10 11:35:58', NULL, NULL),
('subhasishr', '$2y$10$k4DyfETO00QxPgVcgaHhC.6Fwn.odKoGtjCpEjxWFYwZQJXoEhl/W', 'U', 'Subhasish Roy', 'A', '343', 0, 'synergic', '2019-12-10 11:46:15', NULL, NULL),
('subhasj', '$2y$10$QS4Qc0CysbcfWJPA1qXu9ukMddvgcaMijrn/guy5MrW9bK3Eu1y3e', 'U', 'Subhas  Chandra Jalal', 'A', '339', 0, 'synergic', '2019-12-10 12:12:45', NULL, NULL),
('subhayum', '$2y$10$F8FcXrQoRL3pj/vChT0X9ueEgGtKGL7nf4y0a4sOAtsMdYITFXVOm', 'U', 'Subhayu Mazumder', 'A', '338', 0, 'synergic', '2019-12-10 12:25:40', NULL, NULL),
('subhrod', '$2y$10$h7.WFAAoRCP3N2qxPUM4SewzrePifiyyQBfFAwQvECm3QcQnxJbd2', 'M', 'Subhro Das', 'A', '333', 0, 'synergic', '2019-12-10 11:33:55', NULL, NULL),
('subratabb', '$2y$10$GsYuWVeoyzCzxFcNbv4Uy.D9VEejwxPT6fvF6nmA4sgsBtBpMYkmO', 'U', 'Subrata Kumar Bose', 'A', '337', 0, 'synergic', '2019-12-10 11:48:38', 'Sabita Biswas', '2020-03-07 08:09:50'),
('subratac', '$2y$10$fv0CFIwQY/7PWLG0SZz/TOIFrGjEuUVIzofSESAYTbokMN3xaTUvu', 'M', 'Subrata Chattopadhya', 'A', '341', 0, 'synergic', '2019-12-10 11:49:25', NULL, NULL),
('subratad', '$2y$10$GvG/c8lIHOenmbXdHndqBOEslvk4MPbRg0XEavx/QHVzFYzHoKsgO', 'U', 'Subrata Kr. Dutta', 'A', '330', 0, 'synergic', '2019-12-10 12:01:13', NULL, NULL),
('subratal', '$2y$10$93MyKO7kiSfjhHSZP2Jz.uVzv00y2dm1roIFo4qu6.jVumtxLIK5S', 'U', 'Subrata Kumar Laha', 'A', '345', 0, 'synergic', '2019-12-10 12:28:43', NULL, NULL),
('subratas', '$2y$10$Ewq7ao2ztPLoJLT9HM1H3e8.iyNn2dYJtbCu5uqgvozuAnUrNa4Um', 'M', 'Subrata Sen', 'A', '335', 0, 'synergic', '2019-12-10 12:10:20', NULL, NULL),
('sudipd', '$2y$10$0NBos9bNPL0uLO1/XY/mOO0C1zJYPgqlSGkW/5VhiQ03TBeKib3YS', 'U', 'Sudip Kumar Das', 'A', '336', 0, 'synergic', '2019-12-10 11:36:13', NULL, NULL),
('suhasranjans', '$2y$10$3gDojg.eRSoCUy6v4LCiE.n/iJovJmXLdabO8XxeHvUto7Dj.4kKK', 'U', 'Suhasranjan Sen', 'A', '339', 0, 'synergic', '2019-12-10 12:13:42', NULL, NULL),
('sujits', '$2y$10$rm/7A0UVOLZTmpmPfEwDA.E/kEjfwk0Ch31VwpKhzxziblp6QvZF.', 'U', 'Sujit Kumar Saha', 'A', '344', 0, 'synergic', '2019-12-10 12:29:51', NULL, NULL),
('sumanc', '$2y$10$UZUbgx062k4bBDw94/JMrO1q2Yd2h9WBM0IbfkYQh71CXAtTkO4Ku', 'M', 'Suman Chakraborty', 'A', '340', 0, 'synergic', '2019-12-10 12:31:12', NULL, NULL),
('sunilc', '$2y$10$.neADX3hhNA4T30LHJVyXOzqk7cSubvm1S6f3dByvGULtZn4yivL.', 'M', 'Sunil Chandra Sarker', 'A', '329', 0, 'synergic', '2019-12-10 11:51:42', 'Koushik Chakraborty', '2019-12-19 06:21:37'),
('sunilc1', '$2y$10$bMR8V1UfvUj3R9To6dDJIeoGR0L0sQxTHTSUgmstY6mxFHMcWJKNS', 'U', 'Sunil Chandra Sarker', 'A', '346', 0, 'synergic', '2019-12-19 06:31:16', NULL, NULL),
('sunils', '$2y$10$4.t4jkLJ/Lu0lruVXdN25eiOV9LIJ6eZyowaK/w.NIprL0HPMJkJK', 'U', 'Sunil Kumar Samanta', 'A', '341', 0, 'synergic', '2019-12-10 11:50:52', NULL, NULL),
('surojg', '$2y$10$5URK9tModGGSvtzGc9HHEepRSyKcRVzdIqqpsayj0e.3QW0Hx/.1i', 'U', 'Suroj Gejmir', 'A', '327', 0, 'synergic', '2019-12-10 11:55:46', NULL, NULL),
('surojitn', '$2y$10$Cb13VZMUFxgBbvhTscOEAOcAC2IwDDmCeyE.0jvZa4JqAXkowl7sa', 'M', 'Surojit Naskar', 'A', '332', 0, 'synergic', '2019-12-10 11:58:52', NULL, NULL),
('susantam', '$2y$10$zReLrXDi40abjg7qvq9gIOhVN0Cc8qqXJnN4Bj3dcYYD1WvXjloKG', 'U', 'Susanta Kr. Mondal', 'A', '327', 0, 'synergic', '2019-12-10 11:55:30', NULL, NULL),
('susmitan', '$2y$10$GV2FOf/mnxfRA/Ilnfc9W.qKGGkeWTuPl9i62kq4Km090elPIRY7O', 'M', 'Susmita Nath', 'A', '343', 0, 'synergic', '2019-12-10 11:45:56', NULL, NULL),
('tapank', '$2y$10$4HX4ZJn0AXN1eHMrA6Rj/OnZnIeiB8uLbA23Ey2fKF0jKQdYjokm2', 'U', 'Tapan Kr. Karfa', 'A', '334', 0, 'synergic', '2019-12-10 11:31:31', NULL, NULL),
('tapass', '$2y$10$DRpwiNcA/zlXj0696PMFUuRMp3Y9M6ksIMowvWu509KCQTqt1.uHK', 'U', 'Tapas Singha Roy', 'A', '331', 0, 'synergic', '2019-12-10 12:02:23', NULL, NULL),
('tapast', '$2y$10$LxzXOwjx6nbZ7tRY2dXQC.OVFoNJF9RzCWKRgIbAV3FXHTM8muQXS', 'U', 'Tapas Kumar Thakur', 'A', '337', 0, 'synergic', '2019-12-10 11:48:25', NULL, NULL),
('tusharm', '$2y$10$0J.9Hk12C7gkX99aKgiOZOaUU.vjFprBwNBCS6j871XdOefxQYTCe', 'U', 'Tushar Kanti Mondal', 'A', '344', 0, 'synergic', '2019-12-10 12:30:02', NULL, NULL),
('ujjalp', '$2y$10$3L/0AIEFHXkyG8haRgxsdOznyvXfck0/ahZ/KJvpLq5ocsg4pW7.y', 'U', 'Ujjal Baran Pal', 'A', '339', 0, 'synergic', '2019-12-10 12:12:58', NULL, NULL),
('yudhistir', '$2y$10$KAM5o7OnT/Ms7lr7hEjR4ORPpds1jHXu0hj8OD3Gmaj4HycALlYS2', 'U', 'Yudhistir Dey', 'A', '338', 0, 'synergic', '2019-12-10 12:25:26', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `td_attendance`
--

CREATE TABLE `td_attendance` (
  `trans_dt` date NOT NULL,
  `sal_year` int(11) NOT NULL,
  `sal_month` varchar(50) NOT NULL,
  `emp_cd` int(11) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `emp_catg` varchar(30) DEFAULT NULL,
  `no_of_days` int(11) NOT NULL DEFAULT 0,
  `created_by` varchar(50) NOT NULL,
  `created_dt` datetime NOT NULL,
  `modified_by` varchar(50) NOT NULL,
  `modified_dt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `td_audit_trail`
--

CREATE TABLE `td_audit_trail` (
  `sl_no` int(5) UNSIGNED NOT NULL,
  `login_dt` datetime DEFAULT NULL,
  `user_id` varchar(30) DEFAULT NULL,
  `terminal_name` varchar(50) DEFAULT NULL,
  `logout` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `td_audit_trail`
--

INSERT INTO `td_audit_trail` (`sl_no`, `login_dt`, `user_id`, `terminal_name`, `logout`) VALUES
(1, '2021-02-24 05:52:07', 'sss', '122.176.27.53', NULL),
(2, '2021-02-24 05:53:04', 'sss', '122.176.27.53', NULL),
(3, '2021-02-24 06:00:18', 'sss', '122.176.27.53', NULL),
(4, '2021-02-24 06:52:57', 'anirbanc', '182.76.175.10', NULL),
(5, '2021-02-24 10:47:49', 'anirbanc', '182.76.175.10', NULL),
(6, '2021-02-24 11:04:27', 'sss', '122.176.27.53', NULL),
(7, '2021-02-24 02:52:10', 'anirbanc', '202.142.65.118', NULL),
(8, '2021-02-25 03:11:53', 'anirbanc', '182.76.175.10', NULL),
(9, '2021-02-25 05:08:09', 'sss', '122.176.27.53', NULL),
(10, '2021-02-25 07:06:34', 'anirbanc', '182.76.175.10', NULL),
(11, '2021-02-25 10:06:49', 'sss', '122.176.27.53', NULL),
(12, '2021-02-25 02:47:13', 'anirbanc', '202.142.65.79', NULL),
(13, '2021-02-26 05:06:10', 'anirbanc', '182.76.175.10', NULL),
(14, '2021-02-27 09:57:20', 'anirbanc', '202.142.104.143', NULL),
(15, '2021-03-01 05:08:28', 'anirbanc', '182.76.175.10', NULL),
(16, '2021-03-01 05:56:45', 'anirbanc', '182.76.175.10', NULL),
(17, '2021-03-01 09:20:12', 'sss', '122.176.27.53', NULL),
(18, '2021-03-02 06:27:07', 'anirbanc', '182.76.175.10', NULL),
(19, '2021-03-03 05:52:24', 'sss', '122.176.27.53', NULL),
(20, '2021-03-03 10:58:50', 'sss', '122.176.27.53', NULL),
(21, '2021-03-03 12:41:43', 'sss', '122.176.27.53', NULL),
(22, '2021-03-03 01:09:22', 'sss', '122.176.27.53', NULL),
(23, '2021-03-05 05:13:34', 'sss', '122.176.27.53', NULL),
(24, '2021-03-05 06:44:26', 'sss', '122.176.27.53', NULL),
(25, '2021-03-08 06:16:14', 'sss', '136.232.64.10', NULL),
(26, '2021-03-09 07:17:07', 'anirbanc', '182.76.175.10', NULL),
(27, '2021-03-09 09:01:51', 'sss', '122.176.27.53', NULL),
(28, '2021-03-09 10:38:06', 'sss', '122.176.27.53', NULL),
(29, '2021-03-10 05:10:43', 'sss', '122.176.27.53', NULL),
(30, '2021-03-10 01:13:13', 'sss', '122.176.27.53', NULL),
(31, '2021-03-25 10:07:22', 'sss', '122.176.27.53', NULL),
(32, '2021-04-02 06:03:52', 'anirbanc', '223.191.48.89', NULL),
(33, '2021-04-05 06:40:28', 'sss', '122.176.27.53', NULL),
(34, '2022-02-18 11:12:14', 'sss', '122.163.123.68', NULL),
(35, '2022-03-22 11:02:44', 'anirbanc', '103.242.190.231', NULL),
(36, '2022-08-17 11:51:17', 'sss', '::1', NULL),
(37, '2022-08-18 10:20:56', 'sss', '::1', NULL),
(38, '2022-08-18 02:27:42', 'sss', '::1', NULL),
(39, '2022-08-18 02:30:54', 'sss', '::1', NULL),
(40, '2022-08-18 02:31:03', 'sss', '::1', NULL),
(41, '2022-08-18 02:51:39', 'sss', '::1', NULL),
(42, '2022-08-18 02:51:52', 'sss', '::1', NULL),
(43, '2022-08-18 03:20:44', 'sss', '::1', NULL),
(44, '2022-08-19 11:11:53', 'sss', '::1', NULL),
(45, '2022-08-22 10:53:58', 'sss', '::1', NULL),
(46, '2022-08-22 02:42:17', 'sss', '::1', NULL),
(47, '2022-08-23 03:31:51', 'sss', '::1', NULL),
(48, '2022-08-25 11:18:45', 'sss', '::1', NULL),
(49, '2022-08-25 01:11:22', 'sss', '::1', NULL),
(50, '2022-08-25 03:49:17', 'sss', '::1', NULL),
(51, '2022-08-25 04:33:06', 'sss', '::1', NULL),
(52, '2022-08-26 10:30:55', 'sss', '::1', NULL),
(53, '2022-08-26 10:45:59', 'sss', '::1', NULL),
(54, '2022-08-30 02:24:07', 'sss', '::1', NULL),
(55, '2022-08-31 10:53:26', 'sss', '::1', NULL),
(56, '2022-08-31 03:02:43', 'sss', '::1', NULL),
(57, '2022-09-01 10:31:46', 'sss', '::1', NULL),
(58, '2022-09-02 10:32:06', 'sss', '::1', NULL),
(59, '2022-09-02 11:02:16', 'sss', '::1', NULL),
(60, '2022-09-15 07:34:26', 'sss', '127.0.0.1', NULL),
(61, '2022-09-15 08:39:55', 'sss', '127.0.0.1', NULL),
(62, '2022-09-15 08:39:59', 'sss', '127.0.0.1', NULL),
(63, '2022-09-15 08:53:21', 'sss', '127.0.0.1', NULL),
(64, '2022-09-15 11:57:35', 'sss', '127.0.0.1', NULL),
(65, '2022-09-16 07:34:17', 'sss', '127.0.0.1', NULL),
(66, '2022-09-16 12:15:36', 'sss', '127.0.0.1', NULL),
(67, '2022-09-19 07:23:05', 'sss', '127.0.0.1', NULL),
(68, '2022-09-19 11:36:35', 'sss', '127.0.0.1', NULL),
(69, '2022-09-20 07:19:35', 'sss', '127.0.0.1', NULL),
(70, '2022-09-20 11:30:51', 'sss', '127.0.0.1', '2022-09-20 01:28:11'),
(71, '2022-09-20 01:41:15', 'sss', '127.0.0.1', NULL),
(72, '2022-09-21 07:41:06', 'sss', '127.0.0.1', NULL),
(73, '2022-09-21 12:46:58', 'sss', '127.0.0.1', '2022-09-21 12:49:52'),
(74, '2022-09-22 07:39:25', 'sss', '127.0.0.1', '2022-09-22 07:59:35'),
(75, '2022-09-22 10:00:42', 'sss', '127.0.0.1', NULL),
(76, '2022-09-22 12:32:49', 'sss', '127.0.0.1', NULL),
(77, '2022-09-23 07:16:29', 'sss', '127.0.0.1', NULL),
(78, '2022-09-23 09:30:02', 'sss', '127.0.0.1', NULL),
(79, '2022-09-29 07:24:48', 'sss', '127.0.0.1', NULL),
(80, '2022-10-11 08:49:34', 'sss', '127.0.0.1', NULL),
(81, '2022-10-14 01:20:47', 'sss', '127.0.0.1', NULL),
(82, '2022-10-18 11:37:04', 'sss', '127.0.0.1', NULL),
(83, '2022-10-28 10:10:50', 'sss', '127.0.0.1', NULL),
(84, '2022-11-04 08:02:27', 'sss', '127.0.0.1', NULL),
(85, '2022-11-04 12:02:25', 'sss', '127.0.0.1', NULL),
(86, '2022-11-09 07:32:09', 'sss', '127.0.0.1', NULL),
(87, '2023-01-03 06:41:01', 'sss', '127.0.0.1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `td_deductions`
--

CREATE TABLE `td_deductions` (
  `emp_code` int(11) NOT NULL,
  `effective_date` date NOT NULL,
  `catg_id` int(11) NOT NULL,
  `gross` float(10,2) NOT NULL,
  `pf` float(10,2) NOT NULL,
  `adv_agst_hb_prin` float(10,2) NOT NULL,
  `adv_agst_hb_int` float(10,2) NOT NULL,
  `adv_agst_hb_const_prin` float(10,2) NOT NULL,
  `adv_agst_hb_const_int` float(10,2) NOT NULL,
  `adv_agst_hb_staff_prin` float(10,2) NOT NULL,
  `adv_agst_hb_staff_int` float(10,2) NOT NULL,
  `gross_hb_int` float(10,2) NOT NULL,
  `adv_agst_of_staff_prin` float(10,2) NOT NULL,
  `adv_agst_of_staff_int` float(10,2) NOT NULL,
  `staff_adv_ext_prin` float(10,2) NOT NULL,
  `staff_adv_ext_int` float(10,2) NOT NULL,
  `motor_cycle_prin` float(10,2) NOT NULL,
  `motor_cycle_int` float(10,2) NOT NULL,
  `p_tax` float(10,2) NOT NULL,
  `gici` float(10,2) NOT NULL,
  `puja_adv` float(10,2) NOT NULL,
  `income_tax_tds` float(10,2) NOT NULL,
  `union_subs` float(10,2) NOT NULL,
  `tot_diduction` float(10,2) NOT NULL,
  `net_sal` float(10,2) NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_dt` datetime NOT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `td_deductions`
--

INSERT INTO `td_deductions` (`emp_code`, `effective_date`, `catg_id`, `gross`, `pf`, `adv_agst_hb_prin`, `adv_agst_hb_int`, `adv_agst_hb_const_prin`, `adv_agst_hb_const_int`, `adv_agst_hb_staff_prin`, `adv_agst_hb_staff_int`, `gross_hb_int`, `adv_agst_of_staff_prin`, `adv_agst_of_staff_int`, `staff_adv_ext_prin`, `staff_adv_ext_int`, `motor_cycle_prin`, `motor_cycle_int`, `p_tax`, `gici`, `puja_adv`, `income_tax_tds`, `union_subs`, `tot_diduction`, `net_sal`, `created_by`, `created_dt`, `modified_by`, `modified_dt`) VALUES
(1, '2022-04-25', 1, 94564.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2778.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 15367.00, 79197.00, '', '2022-10-14 12:25:08', NULL, NULL),
(1, '2022-05-25', 1, 94611.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2676.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 15265.00, 79346.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(1, '2022-06-24', 1, 94611.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2660.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 15249.00, 79362.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(1, '2022-07-25', 1, 94611.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2053.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 14642.00, 79969.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(1, '2022-08-25', 1, 97181.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2529.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 15118.00, 82063.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(1, '2022-09-23', 1, 97181.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2346.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 3000.00, 0.00, 11435.00, 85746.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(1, '2022-10-18', 1, 97181.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2570.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 3000.00, 0.00, 11659.00, 85522.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(2, '2022-04-25', 1, 91483.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 53751.00, '', '2022-10-14 12:25:08', NULL, NULL),
(2, '2022-05-25', 1, 91529.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 53797.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(2, '2022-06-24', 1, 91529.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 53797.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(2, '2022-07-25', 1, 91529.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 53797.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(2, '2022-08-25', 1, 94010.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 56278.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(2, '2022-09-23', 1, 94010.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 0.00, 1000.00, 20.00, 34232.00, 59778.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(2, '2022-10-18', 1, 94010.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 0.00, 1000.00, 20.00, 34232.00, 59778.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(3, '2022-04-25', 1, 97644.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 71606.00, '', '2022-10-14 12:25:09', NULL, NULL),
(3, '2022-05-25', 1, 97693.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 71655.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(3, '2022-06-24', 1, 97693.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 71655.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(3, '2022-07-25', 1, 97693.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 71655.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(3, '2022-08-25', 1, 100349.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 74311.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(3, '2022-09-23', 1, 100349.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 3000.00, 20.00, 22538.00, 77811.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(3, '2022-10-18', 1, 100349.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 3000.00, 20.00, 22538.00, 77811.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(4, '2022-04-25', 1, 97644.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 54719.00, '', '2022-10-14 12:25:09', NULL, NULL),
(4, '2022-05-25', 1, 97693.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 54768.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(4, '2022-06-24', 1, 97693.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 54768.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(4, '2022-07-25', 1, 97693.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 54768.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(4, '2022-08-25', 1, 100349.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 57424.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(4, '2022-09-23', 1, 100349.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 0.00, 1000.00, 0.00, 39425.00, 60924.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(4, '2022-10-18', 1, 100349.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 0.00, 1000.00, 0.00, 39425.00, 60924.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(5, '2022-04-25', 1, 98244.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 73338.00, '', '2022-10-14 12:25:09', NULL, NULL),
(5, '2022-05-25', 1, 98293.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 73387.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(5, '2022-06-24', 1, 98293.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 73387.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(5, '2022-07-25', 1, 98293.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 73387.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(5, '2022-08-25', 1, 100949.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 76043.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(5, '2022-09-23', 1, 100949.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 5000.00, 0.00, 21406.00, 79543.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(5, '2022-10-18', 1, 100949.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 5000.00, 0.00, 21406.00, 79543.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(6, '2022-04-25', 1, 55515.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 44062.00, '', '2022-10-14 12:25:09', NULL, NULL),
(6, '2022-05-25', 1, 55541.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 44088.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(6, '2022-06-24', 1, 55541.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 44088.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(6, '2022-07-25', 1, 55541.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 44088.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(6, '2022-08-25', 1, 56984.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 45531.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(6, '2022-09-23', 1, 56984.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 7953.00, 49031.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(6, '2022-10-18', 1, 56984.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 7953.00, 49031.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(7, '2022-04-25', 1, 48951.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 36082.00, '', '2022-10-14 12:25:09', NULL, NULL),
(7, '2022-05-25', 1, 48975.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 36106.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(7, '2022-06-24', 1, 48975.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 36106.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(7, '2022-07-25', 1, 48975.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 36106.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(7, '2022-08-25', 1, 52802.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 39933.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(7, '2022-09-23', 1, 52802.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 9369.00, 43433.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(7, '2022-10-18', 1, 52802.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 9369.00, 43433.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(8, '2022-04-25', 1, 50201.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 35877.00, '', '2022-10-14 12:25:09', NULL, NULL),
(8, '2022-05-25', 1, 50225.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 35901.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(8, '2022-06-24', 1, 50225.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 35901.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(8, '2022-07-25', 1, 50225.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 35901.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(8, '2022-08-25', 1, 54052.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 39728.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(8, '2022-09-23', 1, 54052.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 10824.00, 43228.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(8, '2022-10-18', 1, 54052.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 10824.00, 43228.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(9, '2022-04-25', 1, 55692.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 28550.00, '', '2022-10-14 12:25:09', NULL, NULL),
(9, '2022-05-25', 1, 55719.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 28577.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(9, '2022-06-24', 1, 55719.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 28577.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(9, '2022-07-25', 1, 55719.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 28577.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(9, '2022-08-25', 1, 57201.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 30059.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(9, '2022-09-23', 1, 57201.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 0.00, 0.00, 23642.00, 33559.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(9, '2022-10-18', 1, 57201.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 0.00, 0.00, 23642.00, 33559.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(10, '2022-04-25', 1, 38763.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 280.00, 1750.00, 1580.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 8513.00, 30250.00, '', '2022-10-14 12:25:09', NULL, NULL),
(10, '2022-05-25', 1, 37532.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 271.00, 1750.00, 1580.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 8504.00, 29028.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(10, '2022-06-24', 1, 38782.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 270.00, 1750.00, 1580.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 8503.00, 30279.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(10, '2022-07-25', 1, 39563.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 269.00, 1750.00, 1580.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 8502.00, 31061.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(10, '2022-08-25', 1, 41864.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 277.00, 1750.00, 1580.00, 0.00, 0.00, 200.00, 0.00, 2600.00, 0.00, 0.00, 8560.00, 33304.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(10, '2022-09-23', 1, 40614.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 259.00, 1750.00, 1580.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0.00, 5942.00, 34672.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(10, '2022-10-18', 1, 41864.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 285.00, 1750.00, 1580.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0.00, 5968.00, 35896.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(11, '2022-04-25', 1, 37513.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 4750.00, 32763.00, '', '2022-10-14 12:25:09', NULL, NULL),
(11, '2022-05-25', 1, 38782.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 4750.00, 34032.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(11, '2022-06-24', 1, 37532.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 4750.00, 32782.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(11, '2022-07-25', 1, 38782.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 4750.00, 34032.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(11, '2022-08-25', 1, 40614.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 2600.00, 0.00, 0.00, 4800.00, 35814.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(11, '2022-09-23', 1, 41864.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 39664.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(11, '2022-10-18', 1, 40614.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 38414.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(12, '2022-04-25', 1, 26573.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 194.00, 357.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 7995.00, 18578.00, '', '2022-10-14 12:25:09', NULL, NULL),
(12, '2022-05-25', 1, 26586.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 194.00, 344.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 7982.00, 18604.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(12, '2022-06-24', 1, 26586.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 454.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 8498.00, 18088.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(12, '2022-07-25', 1, 26586.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 589.00, 2089.00, 1260.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 8588.00, 17998.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(12, '2022-08-25', 1, 27291.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 606.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 8650.00, 18641.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(12, '2022-09-23', 1, 27291.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 348.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 5892.00, 21399.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(12, '2022-10-18', 1, 27291.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2944.00, 2788.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 11276.00, 16015.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(13, '2022-04-25', 1, 20769.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10643.00, 10126.00, '', '2022-10-14 12:25:09', NULL, NULL),
(13, '2022-05-25', 1, 22441.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10643.00, 11798.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(13, '2022-06-24', 1, 17454.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10643.00, 6811.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(13, '2022-07-25', 1, 24104.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10643.00, 13461.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(13, '2022-08-25', 1, 21330.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 10663.00, 10667.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(13, '2022-09-23', 1, 20477.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 9663.00, 10814.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(13, '2022-10-18', 1, 20477.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 9663.00, 10814.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(14, '2022-04-25', 1, 24923.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1268.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5648.00, 19275.00, '', '2022-10-14 12:25:09', NULL, NULL),
(14, '2022-05-25', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1221.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5601.00, 19334.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(14, '2022-06-24', 1, 24104.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1216.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5596.00, 18508.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(14, '2022-07-25', 1, 15792.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1209.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5589.00, 10203.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(14, '2022-08-25', 1, 24743.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1243.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 5643.00, 19100.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(14, '2022-09-23', 1, 22183.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1156.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 4556.00, 17627.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(14, '2022-10-18', 1, 23890.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1270.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 4670.00, 19220.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(15, '2022-04-25', 1, 24092.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10267.00, 13825.00, '', '2022-10-14 12:25:09', NULL, NULL),
(15, '2022-05-25', 1, 20779.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10267.00, 10512.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(15, '2022-06-24', 1, 21610.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10267.00, 11343.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(15, '2022-07-25', 1, 22441.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10267.00, 12174.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(15, '2022-08-25', 1, 20477.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 10287.00, 10190.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(15, '2022-09-23', 1, 22183.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 9287.00, 12896.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(15, '2022-10-18', 1, 19624.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 9287.00, 10337.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(16, '2022-04-25', 1, 24923.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 3130.00, 21793.00, '', '2022-10-14 12:25:09', NULL, NULL),
(16, '2022-05-25', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 3130.00, 21805.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(16, '2022-06-24', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 3130.00, 21805.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(16, '2022-07-25', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 3130.00, 21805.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(16, '2022-08-25', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 3150.00, 22446.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(16, '2022-09-23', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 2150.00, 23446.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(16, '2022-10-18', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 2150.00, 23446.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(17, '2022-04-25', 1, 24923.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 1508.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 7638.00, 17285.00, '', '2022-10-14 12:25:09', NULL, NULL),
(17, '2022-05-25', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 1508.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 7638.00, 17297.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(17, '2022-06-24', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 972.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5102.00, 19833.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(17, '2022-07-25', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 489.00, 3000.00, 1508.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 9127.00, 15808.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(17, '2022-08-25', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 500.00, 3000.00, 1508.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 9158.00, 16438.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(17, '2022-09-23', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 463.00, 3000.00, 1508.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 8121.00, 17475.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(17, '2022-10-18', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 506.00, 3000.00, 1508.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 8164.00, 17432.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(18, '2022-04-25', 1, 24923.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 1015.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5145.00, 19778.00, '', '2022-10-14 12:25:09', NULL, NULL),
(18, '2022-05-25', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 977.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5107.00, 19828.00, 'sss', '2022-10-17 11:47:58', NULL, NULL),
(18, '2022-06-24', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 296.00, 3000.00, 1508.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 8934.00, 16001.00, 'sss', '2022-10-17 01:04:05', NULL, NULL),
(18, '2022-07-25', 1, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 967.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5097.00, 19838.00, 'sss', '2022-10-17 02:11:07', NULL, NULL),
(18, '2022-08-25', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 534.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 6184.00, 19412.00, 'sss', '2022-10-18 08:57:23', NULL, NULL),
(18, '2022-09-23', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 1180.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 5830.00, 19766.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(18, '2022-10-18', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 1290.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 5940.00, 19656.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(19, '2022-04-25', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2862.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10659.00, 10341.00, 'sss', '2022-10-15 07:41:01', NULL, NULL),
(19, '2022-05-25', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2717.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10514.00, 10486.00, 'sss', '2022-10-17 12:30:41', NULL, NULL),
(19, '2022-06-24', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2676.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10473.00, 10527.00, 'sss', '2022-10-17 01:16:42', NULL, NULL),
(19, '2022-07-25', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2707.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10504.00, 10496.00, 'sss', '2022-10-17 02:23:15', NULL, NULL),
(19, '2022-08-25', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2656.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10453.00, 10547.00, 'sss', '2022-10-18 09:55:29', NULL, NULL),
(19, '2022-09-23', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2433.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 9230.00, 11770.00, 'sss', '2022-10-18 11:06:58', NULL, NULL),
(19, '2022-10-18', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2637.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 9434.00, 11566.00, 'sss', '2022-10-18 12:42:24', 'sss', '2022-10-21 01:35:29'),
(20, '2022-04-25', 2, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, 'sss', '2022-10-15 07:41:01', NULL, NULL),
(20, '2022-05-25', 2, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, 'sss', '2022-10-17 12:30:41', NULL, NULL),
(20, '2022-06-24', 2, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, 'sss', '2022-10-17 01:16:42', NULL, NULL),
(20, '2022-07-25', 2, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, 'sss', '2022-10-17 02:23:15', NULL, NULL),
(20, '2022-08-25', 2, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, 'sss', '2022-10-18 09:55:29', NULL, NULL),
(20, '2022-09-23', 1, 24743.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 6814.00, 17929.00, 'sss', '2022-10-18 10:33:48', NULL, NULL),
(20, '2022-10-18', 1, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 6814.00, 18782.00, 'sss', '2022-10-21 03:20:18', NULL, NULL),
(21, '2022-04-25', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 110.00, 10890.00, 'sss', '2022-10-15 07:41:01', NULL, NULL),
(21, '2022-05-25', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 110.00, 10890.00, 'sss', '2022-10-17 12:30:41', NULL, NULL),
(21, '2022-06-24', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 110.00, 10890.00, 'sss', '2022-10-17 01:16:42', NULL, NULL),
(21, '2022-07-25', 2, 10633.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 110.00, 10523.00, 'sss', '2022-10-17 02:23:15', NULL, NULL),
(21, '2022-08-25', 2, 11000.00, 550.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 660.00, 10340.00, 'sss', '2022-10-18 09:55:29', NULL, NULL),
(21, '2022-09-23', 2, 10633.00, 550.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 660.00, 9973.00, 'sss', '2022-10-18 11:06:58', NULL, NULL),
(21, '2022-10-18', 2, 11000.00, 550.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 660.00, 10340.00, 'sss', '2022-10-18 12:42:24', 'sss', '2022-10-21 01:35:29'),
(22, '2022-04-25', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 333.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 943.00, 12057.00, 'sss', '2022-10-15 07:41:01', NULL, NULL),
(22, '2022-05-25', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 318.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 928.00, 12072.00, 'sss', '2022-10-17 12:30:41', NULL, NULL),
(22, '2022-06-24', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 1899.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 3953.00, 9047.00, 'sss', '2022-10-17 01:16:42', NULL, NULL),
(22, '2022-07-25', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 2662.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 4716.00, 8284.00, 'sss', '2022-10-17 02:23:15', NULL, NULL),
(22, '2022-08-25', 2, 13000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 2647.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 5301.00, 7699.00, 'sss', '2022-10-18 09:55:29', NULL, NULL),
(22, '2022-09-23', 2, 13000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 2461.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 5115.00, 7885.00, 'sss', '2022-10-18 11:06:58', NULL, NULL),
(22, '2022-10-18', 2, 13000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 2700.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 5354.00, 7646.00, 'sss', '2022-10-18 12:42:24', 'sss', '2022-10-21 01:35:29'),
(23, '2022-04-25', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, 'sss', '2022-10-15 07:41:01', NULL, NULL),
(23, '2022-05-25', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, 'sss', '2022-10-17 12:30:41', NULL, NULL),
(23, '2022-06-24', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, 'sss', '2022-10-17 01:16:42', NULL, NULL),
(23, '2022-07-25', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, 'sss', '2022-10-17 02:23:15', NULL, NULL),
(23, '2022-08-25', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, 'sss', '2022-10-18 09:55:29', NULL, NULL),
(23, '2022-09-23', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 730.00, 19270.00, 'sss', '2022-10-18 11:06:58', NULL, NULL),
(23, '2022-10-18', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 730.00, 19270.00, 'sss', '2022-10-18 12:42:24', 'sss', '2022-10-21 01:35:29'),
(24, '2022-04-25', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, 'sss', '2022-10-15 07:41:01', NULL, NULL),
(24, '2022-05-25', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, 'sss', '2022-10-17 12:30:41', NULL, NULL),
(24, '2022-06-24', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, 'sss', '2022-10-17 01:16:42', NULL, NULL),
(24, '2022-07-25', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, 'sss', '2022-10-17 02:23:15', NULL, NULL),
(24, '2022-08-25', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, 'sss', '2022-10-18 09:55:29', NULL, NULL),
(24, '2022-09-23', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 3488.00, 16512.00, 'sss', '2022-10-18 11:06:58', NULL, NULL),
(24, '2022-10-18', 2, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 3488.00, 16512.00, 'sss', '2022-10-18 12:42:24', 'sss', '2022-10-21 01:35:29'),
(25, '2022-04-25', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 'sss', '2022-10-15 07:41:01', NULL, NULL),
(25, '2022-05-25', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 'sss', '2022-10-17 12:30:41', NULL, NULL),
(25, '2022-06-24', 2, 8000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 78.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 328.00, 7672.00, 'sss', '2022-10-17 01:16:42', NULL, NULL),
(25, '2022-07-25', 2, 9333.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 113.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 363.00, 8970.00, 'sss', '2022-10-17 02:23:15', NULL, NULL),
(25, '2022-08-25', 2, 8000.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 111.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 861.00, 7139.00, 'sss', '2022-10-18 09:55:29', NULL, NULL),
(25, '2022-09-23', 2, 9667.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 102.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 852.00, 8815.00, 'sss', '2022-10-18 11:06:58', NULL, NULL),
(25, '2022-10-18', 2, 10000.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 69.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1569.00, 8431.00, 'sss', '2022-10-18 12:42:24', 'sss', '2022-10-21 01:35:29');

-- --------------------------------------------------------

--
-- Table structure for table `td_income`
--

CREATE TABLE `td_income` (
  `emp_code` int(10) NOT NULL,
  `effective_date` date NOT NULL,
  `catg_id` int(11) NOT NULL COMMENT 'md_category->id',
  `basic` float(10,2) NOT NULL DEFAULT 0.00,
  `da` float(10,2) NOT NULL DEFAULT 0.00,
  `sa` float(10,2) NOT NULL DEFAULT 0.00,
  `hra` float(10,2) NOT NULL DEFAULT 0.00,
  `ta` float(10,2) NOT NULL DEFAULT 0.00,
  `da_on_sa` float(10,2) NOT NULL DEFAULT 0.00,
  `da_on_ta` float(10,2) NOT NULL DEFAULT 0.00,
  `ma` float(10,2) NOT NULL DEFAULT 0.00,
  `cash_swa` float(10,2) NOT NULL DEFAULT 0.00,
  `gross` float(10,2) NOT NULL DEFAULT 0.00,
  `lwp` float(10,2) NOT NULL DEFAULT 0.00,
  `final_gross` float(10,2) NOT NULL DEFAULT 0.00,
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `td_income`
--

INSERT INTO `td_income` (`emp_code`, `effective_date`, `catg_id`, `basic`, `da`, `sa`, `hra`, `ta`, `da_on_sa`, `da_on_ta`, `ma`, `cash_swa`, `gross`, `lwp`, `final_gross`, `created_by`, `created_dt`, `modified_by`, `modified_dt`) VALUES
(1, '2022-04-25', 1, 57870.00, 19080.00, 9491.00, 4000.00, 600.00, 3129.00, 198.00, 196.00, 0.00, 94564.00, 0.00, 94564.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(1, '2022-05-25', 1, 57870.00, 19120.00, 9491.00, 4000.00, 600.00, 3136.00, 198.00, 196.00, 0.00, 94611.00, 0.00, 94611.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(1, '2022-06-24', 1, 57870.00, 19120.00, 9491.00, 4000.00, 600.00, 3136.00, 198.00, 196.00, 0.00, 94611.00, 0.00, 94611.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(1, '2022-07-25', 1, 57870.00, 19120.00, 9491.00, 4000.00, 600.00, 3136.00, 198.00, 196.00, 0.00, 94611.00, 0.00, 94611.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(1, '2022-08-25', 1, 57870.00, 21308.00, 9491.00, 4000.00, 600.00, 3495.00, 221.00, 196.00, 0.00, 97181.00, 0.00, 97181.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(1, '2022-09-23', 1, 57870.00, 21308.00, 9491.00, 4000.00, 600.00, 3495.00, 221.00, 196.00, 0.00, 97181.00, 0.00, 97181.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(1, '2022-10-18', 1, 57870.00, 21308.00, 9491.00, 4000.00, 600.00, 3495.00, 221.00, 196.00, 0.00, 97181.00, 0.00, 97181.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(1, '2023-01-03', 1, 57870.00, 21308.00, 9491.00, 4000.00, 600.00, 3495.00, 221.00, 196.00, 0.00, 97181.00, 0.00, 97181.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(2, '2022-04-25', 1, 55880.00, 18424.00, 9164.00, 4000.00, 600.00, 3021.00, 198.00, 196.00, 0.00, 91483.00, 0.00, 91483.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(2, '2022-05-25', 1, 55880.00, 18463.00, 9164.00, 4000.00, 600.00, 3028.00, 198.00, 196.00, 0.00, 91529.00, 0.00, 91529.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(2, '2022-06-24', 1, 55880.00, 18463.00, 9164.00, 4000.00, 600.00, 3028.00, 198.00, 196.00, 0.00, 91529.00, 0.00, 91529.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(2, '2022-07-25', 1, 55880.00, 18463.00, 9164.00, 4000.00, 600.00, 3028.00, 198.00, 196.00, 0.00, 91529.00, 0.00, 91529.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(2, '2022-08-25', 1, 55880.00, 20575.00, 9164.00, 4000.00, 600.00, 3374.00, 221.00, 196.00, 0.00, 94010.00, 0.00, 94010.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(2, '2022-09-23', 1, 55880.00, 20575.00, 9164.00, 4000.00, 600.00, 3374.00, 221.00, 196.00, 0.00, 94010.00, 0.00, 94010.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(2, '2022-10-18', 1, 55880.00, 20575.00, 9164.00, 4000.00, 600.00, 3374.00, 221.00, 196.00, 0.00, 94010.00, 0.00, 94010.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(2, '2023-01-03', 1, 55880.00, 20575.00, 9164.00, 4000.00, 600.00, 3374.00, 221.00, 196.00, 0.00, 94010.00, 0.00, 94010.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(3, '2022-04-25', 1, 59860.00, 19736.00, 9817.00, 4000.00, 600.00, 3237.00, 198.00, 196.00, 0.00, 97644.00, 0.00, 97644.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(3, '2022-05-25', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 97693.00, 0.00, 97693.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(3, '2022-06-24', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 97693.00, 0.00, 97693.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(3, '2022-07-25', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 97693.00, 0.00, 97693.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(3, '2022-08-25', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(3, '2022-09-23', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(3, '2022-10-18', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(3, '2023-01-03', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(4, '2022-04-25', 1, 59860.00, 19736.00, 9817.00, 4000.00, 600.00, 3237.00, 198.00, 196.00, 0.00, 97644.00, 0.00, 97644.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(4, '2022-05-25', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 97693.00, 0.00, 97693.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(4, '2022-06-24', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 97693.00, 0.00, 97693.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(4, '2022-07-25', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 97693.00, 0.00, 97693.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(4, '2022-08-25', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(4, '2022-09-23', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(4, '2022-10-18', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(4, '2023-01-03', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(5, '2022-04-25', 1, 59860.00, 19736.00, 9817.00, 4000.00, 600.00, 3237.00, 198.00, 196.00, 600.00, 98244.00, 0.00, 98244.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(5, '2022-05-25', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 600.00, 98293.00, 0.00, 98293.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(5, '2022-06-24', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 600.00, 98293.00, 0.00, 98293.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(5, '2022-07-25', 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 600.00, 98293.00, 0.00, 98293.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(5, '2022-08-25', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 600.00, 100949.00, 0.00, 100949.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(5, '2022-09-23', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 600.00, 100949.00, 0.00, 100949.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(5, '2022-10-18', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 600.00, 100949.00, 0.00, 100949.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(5, '2023-01-03', 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 100349.00, 0.00, 100349.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(6, '2022-04-25', 1, 32280.00, 10643.00, 5294.00, 3309.00, 600.00, 1745.00, 198.00, 196.00, 1250.00, 55515.00, 0.00, 55515.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(6, '2022-05-25', 1, 32280.00, 10665.00, 5294.00, 3309.00, 600.00, 1749.00, 198.00, 196.00, 1250.00, 55541.00, 0.00, 55541.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(6, '2022-06-24', 1, 32280.00, 10665.00, 5294.00, 3309.00, 600.00, 1749.00, 198.00, 196.00, 1250.00, 55541.00, 0.00, 55541.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(6, '2022-07-25', 1, 32280.00, 10665.00, 5294.00, 3309.00, 600.00, 1749.00, 198.00, 196.00, 1250.00, 55541.00, 0.00, 55541.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(6, '2022-08-25', 1, 32280.00, 11885.00, 5294.00, 3309.00, 600.00, 1949.00, 221.00, 196.00, 1250.00, 56984.00, 0.00, 56984.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(6, '2022-09-23', 1, 32280.00, 11885.00, 5294.00, 3309.00, 600.00, 1949.00, 221.00, 196.00, 1250.00, 56984.00, 0.00, 56984.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(6, '2022-10-18', 1, 32280.00, 11885.00, 5294.00, 3309.00, 600.00, 1949.00, 221.00, 196.00, 1250.00, 56984.00, 0.00, 56984.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(6, '2023-01-03', 1, 32280.00, 11885.00, 5294.00, 3309.00, 600.00, 1949.00, 221.00, 196.00, 0.00, 55734.00, 0.00, 55734.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(7, '2022-04-25', 1, 29060.00, 9581.00, 4766.00, 2979.00, 600.00, 1571.00, 198.00, 196.00, 0.00, 48951.00, 0.00, 48951.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(7, '2022-05-25', 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 0.00, 48975.00, 0.00, 48975.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(7, '2022-06-24', 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 0.00, 48975.00, 0.00, 48975.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(7, '2022-07-25', 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 0.00, 48975.00, 0.00, 48975.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(7, '2022-08-25', 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 0.00, 52802.00, 0.00, 52802.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(7, '2022-09-23', 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 0.00, 52802.00, 0.00, 52802.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(7, '2022-10-18', 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 0.00, 52802.00, 0.00, 52802.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(7, '2023-01-03', 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 0.00, 52802.00, 0.00, 52802.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(8, '2022-04-25', 1, 29060.00, 9581.00, 4766.00, 2979.00, 600.00, 1571.00, 198.00, 196.00, 1250.00, 50201.00, 0.00, 50201.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(8, '2022-05-25', 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 1250.00, 50225.00, 0.00, 50225.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(8, '2022-06-24', 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 1250.00, 50225.00, 0.00, 50225.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(8, '2022-07-25', 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 1250.00, 50225.00, 0.00, 50225.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(8, '2022-08-25', 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 1250.00, 54052.00, 0.00, 54052.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(8, '2022-09-23', 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 1250.00, 54052.00, 0.00, 54052.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(8, '2022-10-18', 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 1250.00, 54052.00, 0.00, 54052.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(8, '2023-01-03', 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 0.00, 52802.00, 0.00, 52802.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(9, '2022-04-25', 1, 33145.00, 10928.00, 5436.00, 3397.00, 600.00, 1792.00, 198.00, 196.00, 0.00, 55692.00, 0.00, 55692.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(9, '2022-05-25', 1, 33145.00, 10951.00, 5436.00, 3397.00, 600.00, 1796.00, 198.00, 196.00, 0.00, 55719.00, 0.00, 55719.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(9, '2022-06-24', 1, 33145.00, 10951.00, 5436.00, 3397.00, 600.00, 1796.00, 198.00, 196.00, 0.00, 55719.00, 0.00, 55719.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(9, '2022-07-25', 1, 33145.00, 10951.00, 5436.00, 3397.00, 600.00, 1796.00, 198.00, 196.00, 0.00, 55719.00, 0.00, 55719.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(9, '2022-08-25', 1, 33145.00, 12204.00, 5436.00, 3397.00, 600.00, 2002.00, 221.00, 196.00, 0.00, 57201.00, 0.00, 57201.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(9, '2022-09-23', 1, 33145.00, 12204.00, 5436.00, 3397.00, 600.00, 2002.00, 221.00, 196.00, 0.00, 57201.00, 0.00, 57201.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(9, '2022-10-18', 1, 33145.00, 12204.00, 5436.00, 3397.00, 600.00, 2002.00, 221.00, 196.00, 0.00, 57201.00, 0.00, 57201.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(9, '2023-01-03', 1, 33145.00, 12204.00, 5436.00, 3397.00, 600.00, 2002.00, 221.00, 196.00, 0.00, 57201.00, 0.00, 57201.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(10, '2022-04-25', 1, 22130.00, 7296.00, 3629.00, 2268.00, 600.00, 1196.00, 198.00, 196.00, 1250.00, 38763.00, 0.00, 38763.00, 'sss', '2022-10-14 07:25:33', NULL, NULL),
(10, '2022-05-25', 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 0.00, 37532.00, 0.00, 37532.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(10, '2022-06-24', 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 1250.00, 38782.00, 0.00, 38782.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(10, '2022-07-25', 1, 23360.00, 7718.00, 3831.00, 2394.00, 600.00, 1266.00, 198.00, 196.00, 0.00, 39563.00, 0.00, 39563.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(10, '2022-08-25', 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 1250.00, 41864.00, 0.00, 41864.00, 'sss', '2022-10-18 08:28:56', NULL, NULL),
(10, '2022-09-23', 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 0.00, 40614.00, 0.00, 40614.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(10, '2022-10-18', 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 1250.00, 41864.00, 0.00, 41864.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(10, '2023-01-03', 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 0.00, 40614.00, 0.00, 40614.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(11, '2022-04-25', 1, 22130.00, 7296.00, 3629.00, 2268.00, 600.00, 1196.00, 198.00, 196.00, 0.00, 37513.00, 0.00, 37513.00, 'sss', '2022-10-14 07:25:34', NULL, NULL),
(11, '2022-05-25', 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 1250.00, 38782.00, 0.00, 38782.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(11, '2022-06-24', 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 0.00, 37532.00, 0.00, 37532.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(11, '2022-07-25', 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 1250.00, 38782.00, 0.00, 38782.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(11, '2022-08-25', 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 0.00, 40614.00, 0.00, 40614.00, 'sss', '2022-10-18 08:28:57', NULL, NULL),
(11, '2022-09-23', 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 1250.00, 41864.00, 0.00, 41864.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(11, '2022-10-18', 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 0.00, 40614.00, 0.00, 40614.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(11, '2023-01-03', 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 0.00, 40614.00, 0.00, 40614.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(12, '2022-04-25', 1, 15500.00, 5110.00, 2542.00, 1589.00, 600.00, 838.00, 198.00, 196.00, 0.00, 26573.00, 0.00, 26573.00, 'sss', '2022-10-14 07:25:34', NULL, NULL),
(12, '2022-05-25', 1, 15500.00, 5121.00, 2542.00, 1589.00, 600.00, 840.00, 198.00, 196.00, 0.00, 26586.00, 0.00, 26586.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(12, '2022-06-24', 1, 15500.00, 5121.00, 2542.00, 1589.00, 600.00, 840.00, 198.00, 196.00, 0.00, 26586.00, 0.00, 26586.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(12, '2022-07-25', 1, 15500.00, 5121.00, 2542.00, 1589.00, 600.00, 840.00, 198.00, 196.00, 0.00, 26586.00, 0.00, 26586.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(12, '2022-08-25', 1, 15500.00, 5707.00, 2542.00, 1589.00, 600.00, 936.00, 221.00, 196.00, 0.00, 27291.00, 0.00, 27291.00, 'sss', '2022-10-18 08:28:57', NULL, NULL),
(12, '2022-09-23', 1, 15500.00, 5707.00, 2542.00, 1589.00, 600.00, 936.00, 221.00, 196.00, 0.00, 27291.00, 0.00, 27291.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(12, '2022-10-18', 1, 15500.00, 5707.00, 2542.00, 1589.00, 600.00, 936.00, 221.00, 196.00, 0.00, 27291.00, 0.00, 27291.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(12, '2023-01-03', 1, 15500.00, 5707.00, 2542.00, 1589.00, 600.00, 936.00, 221.00, 196.00, 0.00, 27291.00, 0.00, 27291.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(13, '2022-04-25', 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 24923.00, 4154.00, 20769.00, 'sss', '2022-10-14 07:25:34', NULL, NULL),
(13, '2022-05-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 2494.00, 22441.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(13, '2022-06-24', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 7481.00, 17454.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(13, '2022-07-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 831.00, 24104.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(13, '2022-08-25', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 4266.00, 21330.00, 'sss', '2022-10-18 08:28:57', NULL, NULL),
(13, '2022-09-23', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 5119.00, 20477.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(13, '2022-10-18', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 5119.00, 20477.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(13, '2023-01-03', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:28'),
(14, '2022-04-25', 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 24923.00, 0.00, 24923.00, 'sss', '2022-10-14 07:25:34', NULL, NULL),
(14, '2022-05-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(14, '2022-06-24', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 831.00, 24104.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(14, '2022-07-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 9143.00, 15792.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(14, '2022-08-25', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 853.00, 24743.00, 'sss', '2022-10-18 08:28:57', NULL, NULL),
(14, '2022-09-23', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 3413.00, 22183.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(14, '2022-10-18', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 1706.00, 23890.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(14, '2023-01-03', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:29'),
(15, '2022-04-25', 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 24923.00, 831.00, 24092.00, 'sss', '2022-10-14 07:25:34', NULL, NULL),
(15, '2022-05-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 4156.00, 20779.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(15, '2022-06-24', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 3325.00, 21610.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(15, '2022-07-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 2494.00, 22441.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(15, '2022-08-25', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 5119.00, 20477.00, 'sss', '2022-10-18 08:28:57', NULL, NULL),
(15, '2022-09-23', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 3413.00, 22183.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(15, '2022-10-18', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 5972.00, 19624.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(15, '2023-01-03', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:29'),
(16, '2022-04-25', 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 24923.00, 0.00, 24923.00, 'sss', '2022-10-14 07:25:34', NULL, NULL),
(16, '2022-05-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(16, '2022-06-24', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(16, '2022-07-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(16, '2022-08-25', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 08:28:57', NULL, NULL),
(16, '2022-09-23', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(16, '2022-10-18', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(16, '2023-01-03', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2023-01-03 06:41:33', 'sss', '2023-01-03 06:42:29'),
(17, '2022-04-25', 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 24923.00, 0.00, 24923.00, 'sss', '2022-10-14 07:25:34', NULL, NULL),
(17, '2022-05-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(17, '2022-06-24', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(17, '2022-07-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(17, '2022-08-25', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 08:28:57', NULL, NULL),
(17, '2022-09-23', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(17, '2022-10-18', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(17, '2023-01-03', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2023-01-03 06:41:34', 'sss', '2023-01-03 06:42:29'),
(18, '2022-04-25', 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 24923.00, 0.00, 24923.00, 'sss', '2022-10-14 07:25:34', NULL, NULL),
(18, '2022-05-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 10:34:31', NULL, NULL),
(18, '2022-06-24', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 12:43:52', NULL, NULL),
(18, '2022-07-25', 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 24935.00, 0.00, 24935.00, 'sss', '2022-10-17 01:28:51', NULL, NULL),
(18, '2022-08-25', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 08:28:57', NULL, NULL),
(18, '2022-09-23', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(18, '2022-10-18', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(18, '2023-01-03', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2023-01-03 06:41:34', 'sss', '2023-01-03 06:42:29'),
(19, '2022-04-25', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 21000.00, 'sss', '2022-10-15 07:30:35', NULL, NULL),
(19, '2022-05-25', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 21000.00, 'sss', '2022-10-17 12:23:41', NULL, NULL),
(19, '2022-06-24', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 21000.00, 'sss', '2022-10-17 01:09:58', NULL, NULL),
(19, '2022-07-25', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 21000.00, 'sss', '2022-10-17 02:18:23', NULL, NULL),
(19, '2022-08-25', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 21000.00, 'sss', '2022-10-18 09:00:49', NULL, NULL),
(19, '2022-09-23', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 21000.00, 'sss', '2022-10-18 10:38:34', NULL, NULL),
(19, '2022-10-18', 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 21000.00, 'sss', '2022-10-18 12:38:49', 'sss', '2022-10-21 12:53:18'),
(20, '2022-04-25', 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 0.00, 15000.00, 'sss', '2022-10-15 07:30:35', NULL, NULL),
(20, '2022-05-25', 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 0.00, 15000.00, 'sss', '2022-10-17 12:23:41', NULL, NULL),
(20, '2022-06-24', 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 0.00, 15000.00, 'sss', '2022-10-17 01:09:58', NULL, NULL),
(20, '2022-07-25', 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 0.00, 15000.00, 'sss', '2022-10-17 02:18:23', NULL, NULL),
(20, '2022-08-25', 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 0.00, 15000.00, 'sss', '2022-10-18 09:00:49', NULL, NULL),
(20, '2022-09-23', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 853.00, 24743.00, 'sss', '2022-10-18 10:05:22', NULL, NULL),
(20, '2022-10-18', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2022-10-18 11:51:18', 'sss', '2022-10-21 12:50:03'),
(20, '2023-01-03', 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 25596.00, 0.00, 25596.00, 'sss', '2023-01-03 06:41:34', 'sss', '2023-01-03 06:42:29'),
(21, '2022-04-25', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 0.00, 11000.00, 'sss', '2022-10-15 07:30:35', NULL, NULL),
(21, '2022-05-25', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 0.00, 11000.00, 'sss', '2022-10-17 12:23:41', NULL, NULL),
(21, '2022-06-24', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 0.00, 11000.00, 'sss', '2022-10-17 01:09:58', NULL, NULL),
(21, '2022-07-25', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 367.00, 10633.00, 'sss', '2022-10-17 02:18:23', NULL, NULL),
(21, '2022-08-25', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 0.00, 11000.00, 'sss', '2022-10-18 09:00:49', NULL, NULL),
(21, '2022-09-23', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 367.00, 10633.00, 'sss', '2022-10-18 10:38:34', NULL, NULL),
(21, '2022-10-18', 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 0.00, 11000.00, 'sss', '2022-10-18 12:38:49', 'sss', '2022-10-21 12:53:18'),
(22, '2022-04-25', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 13000.00, 'sss', '2022-10-15 07:30:35', NULL, NULL),
(22, '2022-05-25', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 13000.00, 'sss', '2022-10-17 12:23:41', NULL, NULL),
(22, '2022-06-24', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 13000.00, 'sss', '2022-10-17 01:09:58', NULL, NULL),
(22, '2022-07-25', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 13000.00, 'sss', '2022-10-17 02:18:23', NULL, NULL),
(22, '2022-08-25', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 13000.00, 'sss', '2022-10-18 09:00:49', NULL, NULL),
(22, '2022-09-23', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 13000.00, 'sss', '2022-10-18 10:38:34', NULL, NULL),
(22, '2022-10-18', 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 13000.00, 'sss', '2022-10-18 12:38:49', 'sss', '2022-10-21 12:53:18'),
(23, '2022-04-25', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-15 07:30:35', NULL, NULL),
(23, '2022-05-25', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-17 12:23:41', NULL, NULL),
(23, '2022-06-24', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-17 01:09:58', NULL, NULL),
(23, '2022-07-25', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-17 02:18:23', NULL, NULL),
(23, '2022-08-25', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-18 09:00:49', NULL, NULL),
(23, '2022-09-23', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-18 10:38:34', NULL, NULL),
(23, '2022-10-18', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-18 12:38:49', 'sss', '2022-10-21 12:53:18'),
(24, '2022-04-25', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-15 07:30:35', NULL, NULL),
(24, '2022-05-25', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-17 12:23:41', NULL, NULL),
(24, '2022-06-24', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-17 01:09:58', NULL, NULL),
(24, '2022-07-25', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-17 02:18:23', NULL, NULL),
(24, '2022-08-25', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-18 09:00:49', NULL, NULL),
(24, '2022-09-23', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-18 10:38:34', NULL, NULL),
(24, '2022-10-18', 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 0.00, 20000.00, 'sss', '2022-10-18 12:38:49', 'sss', '2022-10-21 12:53:18'),
(25, '2022-04-25', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, 'sss', '2022-10-15 07:30:35', NULL, NULL),
(25, '2022-05-25', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, 'sss', '2022-10-17 12:23:41', NULL, NULL),
(25, '2022-06-24', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 2000.00, 8000.00, 'sss', '2022-10-17 01:09:58', NULL, NULL),
(25, '2022-07-25', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 667.00, 9333.00, 'sss', '2022-10-17 02:18:23', NULL, NULL),
(25, '2022-08-25', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 2000.00, 8000.00, 'sss', '2022-10-18 09:00:49', NULL, NULL),
(25, '2022-09-23', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 333.00, 9667.00, 'sss', '2022-10-18 10:38:34', NULL, NULL),
(25, '2022-10-18', 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, 'sss', '2022-10-18 12:38:49', 'sss', '2022-10-21 12:53:18');

-- --------------------------------------------------------

--
-- Table structure for table `td_leave_dtls`
--

CREATE TABLE `td_leave_dtls` (
  `trans_dt` date NOT NULL,
  `trans_cd` int(10) NOT NULL,
  `trans_type` varchar(1) NOT NULL,
  `emp_no` varchar(50) NOT NULL,
  `emp_name` varchar(120) NOT NULL,
  `docket_no` varchar(100) NOT NULL,
  `leave_type` varchar(5) NOT NULL,
  `leave_mode` varchar(1) NOT NULL,
  `from_dt` date NOT NULL,
  `to_dt` date NOT NULL,
  `no_of_days` decimal(4,1) NOT NULL DEFAULT 0.0,
  `remarks` tinytext NOT NULL,
  `approval_status` varchar(1) NOT NULL,
  `approved_dt` date NOT NULL,
  `approved_by` varchar(50) NOT NULL,
  `rollback_reason` tinytext NOT NULL,
  `roll_dt` date DEFAULT NULL,
  `roll_by` varchar(50) DEFAULT NULL,
  `cl_bal` decimal(4,1) NOT NULL DEFAULT 0.0,
  `el_bal` decimal(4,1) NOT NULL DEFAULT 0.0,
  `ml_bal` decimal(4,1) NOT NULL DEFAULT 0.0,
  `od_bal` decimal(4,1) NOT NULL DEFAULT 0.0,
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `td_leave_mat`
--

CREATE TABLE `td_leave_mat` (
  `trans_dt` date NOT NULL,
  `trans_cd` int(10) NOT NULL,
  `emp_no` varchar(50) NOT NULL,
  `emp_name` varchar(120) NOT NULL,
  `docket_no` varchar(100) NOT NULL,
  `from_dt` date NOT NULL,
  `to_dt` date NOT NULL,
  `no_of_days` float(3,1) NOT NULL,
  `remarks` tinytext NOT NULL,
  `approval_status` varchar(1) NOT NULL,
  `approved_dt` date NOT NULL,
  `approved_by` varchar(50) NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `td_pay_slip`
--

CREATE TABLE `td_pay_slip` (
  `trans_date` date NOT NULL,
  `trans_no` int(11) NOT NULL,
  `sal_month` varchar(10) NOT NULL,
  `sal_year` int(11) NOT NULL,
  `emp_code` int(10) NOT NULL,
  `catg_id` int(11) NOT NULL COMMENT 'md_category->id',
  `basic` float(10,2) NOT NULL DEFAULT 0.00,
  `da` float(10,2) NOT NULL DEFAULT 0.00,
  `sa` float(10,2) NOT NULL DEFAULT 0.00,
  `hra` float(10,2) NOT NULL DEFAULT 0.00,
  `ta` float(10,2) NOT NULL DEFAULT 0.00,
  `da_on_sa` float(10,2) NOT NULL DEFAULT 0.00,
  `da_on_ta` float(10,2) NOT NULL DEFAULT 0.00,
  `ma` float(10,2) NOT NULL DEFAULT 0.00,
  `cash_swa` float(10,2) NOT NULL DEFAULT 0.00,
  `lwp` float(10,2) NOT NULL DEFAULT 0.00,
  `final_gross` float(10,2) NOT NULL DEFAULT 0.00,
  `pf` float(10,2) NOT NULL,
  `adv_agst_hb_prin` float(10,2) NOT NULL,
  `adv_agst_hb_int` float(10,2) NOT NULL,
  `adv_agst_hb_const_prin` float(10,2) NOT NULL,
  `adv_agst_hb_const_int` float(10,2) NOT NULL,
  `adv_agst_hb_staff_prin` float(10,2) NOT NULL,
  `adv_agst_hb_staff_int` float(10,2) NOT NULL,
  `gross_hb_int` float(10,2) NOT NULL,
  `adv_agst_of_staff_prin` float(10,2) NOT NULL,
  `adv_agst_of_staff_int` float(10,2) NOT NULL,
  `staff_adv_ext_prin` float(10,2) NOT NULL,
  `staff_adv_ext_int` float(10,2) NOT NULL,
  `motor_cycle_prin` float(10,2) NOT NULL,
  `motor_cycle_int` float(10,2) NOT NULL,
  `p_tax` float(10,2) NOT NULL,
  `gici` float(10,2) NOT NULL,
  `puja_adv` float(10,2) NOT NULL,
  `income_tax_tds` float(10,2) NOT NULL,
  `union_subs` float(10,2) NOT NULL,
  `tot_diduction` float(10,2) NOT NULL,
  `net_sal` float(10,2) NOT NULL,
  `bank_ac_no` varchar(50) NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `approval_status` varchar(5) NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `td_pay_slip`
--

INSERT INTO `td_pay_slip` (`trans_date`, `trans_no`, `sal_month`, `sal_year`, `emp_code`, `catg_id`, `basic`, `da`, `sa`, `hra`, `ta`, `da_on_sa`, `da_on_ta`, `ma`, `cash_swa`, `lwp`, `final_gross`, `pf`, `adv_agst_hb_prin`, `adv_agst_hb_int`, `adv_agst_hb_const_prin`, `adv_agst_hb_const_int`, `adv_agst_hb_staff_prin`, `adv_agst_hb_staff_int`, `gross_hb_int`, `adv_agst_of_staff_prin`, `adv_agst_of_staff_int`, `staff_adv_ext_prin`, `staff_adv_ext_int`, `motor_cycle_prin`, `motor_cycle_int`, `p_tax`, `gici`, `puja_adv`, `income_tax_tds`, `union_subs`, `tot_diduction`, `net_sal`, `bank_ac_no`, `created_by`, `created_dt`, `modified_by`, `modified_dt`, `remarks`, `approval_status`) VALUES
('2022-10-14', 1, '4', 2022, 1, 1, 57870.00, 19080.00, 9491.00, 4000.00, 600.00, 3129.00, 198.00, 196.00, 0.00, 0.00, 94564.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2778.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 15367.00, 79197.00, '20122081', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 2, 1, 55880.00, 18424.00, 9164.00, 4000.00, 600.00, 3021.00, 198.00, 196.00, 0.00, 0.00, 91483.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 53751.00, '20104765', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 3, 1, 59860.00, 19736.00, 9817.00, 4000.00, 600.00, 3237.00, 198.00, 196.00, 0.00, 0.00, 97644.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 71606.00, '10106016', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 4, 1, 59860.00, 19736.00, 9817.00, 4000.00, 600.00, 3237.00, 198.00, 196.00, 0.00, 0.00, 97644.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 54719.00, '10108744', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 5, 1, 59860.00, 19736.00, 9817.00, 4000.00, 600.00, 3237.00, 198.00, 196.00, 600.00, 0.00, 98244.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 73338.00, '10105782', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 6, 1, 32280.00, 10643.00, 5294.00, 3309.00, 600.00, 1745.00, 198.00, 196.00, 1250.00, 0.00, 55515.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 44062.00, '10114226', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 7, 1, 29060.00, 9581.00, 4766.00, 2979.00, 600.00, 1571.00, 198.00, 196.00, 0.00, 0.00, 48951.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 36082.00, '10108872', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 8, 1, 29060.00, 9581.00, 4766.00, 2979.00, 600.00, 1571.00, 198.00, 196.00, 1250.00, 0.00, 50201.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 35877.00, '20104280', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 9, 1, 33145.00, 10928.00, 5436.00, 3397.00, 600.00, 1792.00, 198.00, 196.00, 0.00, 0.00, 55692.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 28550.00, '10108796', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 10, 1, 22130.00, 7296.00, 3629.00, 2268.00, 600.00, 1196.00, 198.00, 196.00, 1250.00, 0.00, 38763.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 280.00, 1750.00, 1580.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 8513.00, 30250.00, '20114909', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 11, 1, 22130.00, 7296.00, 3629.00, 2268.00, 600.00, 1196.00, 198.00, 196.00, 0.00, 0.00, 37513.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 4750.00, 32763.00, '20118521', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 12, 1, 15500.00, 5110.00, 2542.00, 1589.00, 600.00, 838.00, 198.00, 196.00, 0.00, 0.00, 26573.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 194.00, 357.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 7995.00, 18578.00, '20123493', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 13, 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 4154.00, 20769.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10643.00, 10126.00, '20109621', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 14, 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 0.00, 24923.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1268.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5648.00, 19275.00, '20102437', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 15, 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 831.00, 24092.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10267.00, 13825.00, '20111876', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 16, 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 0.00, 24923.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 3130.00, 21793.00, '10110886', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 17, 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 0.00, 24923.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 1508.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 7638.00, 17285.00, '20111826', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-14', 1, '4', 2022, 18, 1, 14500.00, 4781.00, 2378.00, 1486.00, 600.00, 784.00, 198.00, 196.00, 0.00, 0.00, 24923.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 1015.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5145.00, 19778.00, '10113013', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-15', 1, '4', 2022, 19, 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2862.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10659.00, 10341.00, '10109891', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-15', 1, '4', 2022, 20, 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, '20120730', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-15', 1, '4', 2022, 21, 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 110.00, 10890.00, '10113275', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-15', 1, '4', 2022, 22, 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 333.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 943.00, 12057.00, '20104071', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-15', 1, '4', 2022, 23, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, '20105798', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-15', 1, '4', 2022, 24, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, '20105799', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-15', 1, '4', 2022, 25, 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, '20124646', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 1, 1, 57870.00, 19120.00, 9491.00, 4000.00, 600.00, 3136.00, 198.00, 196.00, 0.00, 0.00, 94611.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2676.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 15265.00, 79346.00, '20122081', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 2, 1, 55880.00, 18463.00, 9164.00, 4000.00, 600.00, 3028.00, 198.00, 196.00, 0.00, 0.00, 91529.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 53797.00, '20104765', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 3, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 0.00, 97693.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 71655.00, '10106016', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 4, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 0.00, 97693.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 54768.00, '10108744', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 5, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 600.00, 0.00, 98293.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 73387.00, '10105782', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 6, 1, 32280.00, 10665.00, 5294.00, 3309.00, 600.00, 1749.00, 198.00, 196.00, 1250.00, 0.00, 55541.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 44088.00, '10114226', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 7, 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 0.00, 0.00, 48975.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 36106.00, '10108872', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 8, 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 1250.00, 0.00, 50225.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 35901.00, '20104280', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 9, 1, 33145.00, 10951.00, 5436.00, 3397.00, 600.00, 1796.00, 198.00, 196.00, 0.00, 0.00, 55719.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 28577.00, '10108796', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 10, 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 0.00, 0.00, 37532.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 271.00, 1750.00, 1580.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 8504.00, 29028.00, '20114909', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 11, 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 1250.00, 0.00, 38782.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 4750.00, 34032.00, '20118521', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 12, 1, 15500.00, 5121.00, 2542.00, 1589.00, 600.00, 840.00, 198.00, 196.00, 0.00, 0.00, 26586.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 194.00, 344.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 7982.00, 18604.00, '20123493', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 13, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 2494.00, 22441.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10643.00, 11798.00, '20109621', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 14, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1221.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5601.00, 19334.00, '20102437', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 15, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 4156.00, 20779.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10267.00, 10512.00, '20111876', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 16, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 3130.00, 21805.00, '10110886', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 17, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 1508.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 7638.00, 17297.00, '20111826', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '5', 2022, 18, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 977.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5107.00, 19828.00, '10113013', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '5', 2022, 19, 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2717.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10514.00, 10486.00, '10109891', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '5', 2022, 20, 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, '20120730', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '5', 2022, 21, 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 110.00, 10890.00, '10113275', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '5', 2022, 22, 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 318.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 928.00, 12072.00, '20104071', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '5', 2022, 23, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, '20105798', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '5', 2022, 24, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, '20105799', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '5', 2022, 25, 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, '20124646', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 1, 1, 57870.00, 19120.00, 9491.00, 4000.00, 600.00, 3136.00, 198.00, 196.00, 0.00, 0.00, 94611.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2660.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 15249.00, 79362.00, '20122081', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 2, 1, 55880.00, 18463.00, 9164.00, 4000.00, 600.00, 3028.00, 198.00, 196.00, 0.00, 0.00, 91529.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 53797.00, '20104765', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 3, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 0.00, 97693.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 71655.00, '10106016', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 4, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 0.00, 97693.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 54768.00, '10108744', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 5, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 600.00, 0.00, 98293.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 73387.00, '10105782', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 6, 1, 32280.00, 10665.00, 5294.00, 3309.00, 600.00, 1749.00, 198.00, 196.00, 1250.00, 0.00, 55541.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 44088.00, '10114226', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 7, 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 0.00, 0.00, 48975.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 36106.00, '10108872', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 8, 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 1250.00, 0.00, 50225.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 35901.00, '20104280', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 9, 1, 33145.00, 10951.00, 5436.00, 3397.00, 600.00, 1796.00, 198.00, 196.00, 0.00, 0.00, 55719.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 28577.00, '10108796', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 10, 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 1250.00, 0.00, 38782.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 270.00, 1750.00, 1580.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 8503.00, 30279.00, '20114909', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 11, 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 0.00, 0.00, 37532.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 4750.00, 32782.00, '20118521', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 12, 1, 15500.00, 5121.00, 2542.00, 1589.00, 600.00, 840.00, 198.00, 196.00, 0.00, 0.00, 26586.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 454.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 8498.00, 18088.00, '20123493', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 13, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 7481.00, 17454.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10643.00, 6811.00, '20109621', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 14, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 831.00, 24104.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1216.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5596.00, 18508.00, '20102437', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 15, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 3325.00, 21610.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10267.00, 11343.00, '20111876', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 16, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 3130.00, 21805.00, '10110886', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 17, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 972.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5102.00, 19833.00, '20111826', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '6', 2022, 18, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 296.00, 3000.00, 1508.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 8934.00, 16001.00, '10113013', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '6', 2022, 19, 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2676.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10473.00, 10527.00, '10109891', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '6', 2022, 20, 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, '20120730', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '6', 2022, 21, 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 110.00, 10890.00, '10113275', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '6', 2022, 22, 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 1899.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 3953.00, 9047.00, '20104071', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '6', 2022, 23, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, '20105798', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '6', 2022, 24, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, '20105799', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '6', 2022, 25, 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 8000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 78.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 328.00, 7672.00, '20124646', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 1, 1, 57870.00, 19120.00, 9491.00, 4000.00, 600.00, 3136.00, 198.00, 196.00, 0.00, 0.00, 94611.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2053.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 14642.00, 79969.00, '20122081', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 2, 1, 55880.00, 18463.00, 9164.00, 4000.00, 600.00, 3028.00, 198.00, 196.00, 0.00, 0.00, 91529.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 53797.00, '20104765', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 3, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 0.00, 97693.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 71655.00, '10106016', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 4, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 0.00, 0.00, 97693.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 54768.00, '10108744', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 5, 1, 59860.00, 19778.00, 9817.00, 4000.00, 600.00, 3244.00, 198.00, 196.00, 600.00, 0.00, 98293.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 73387.00, '10105782', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 6, 1, 32280.00, 10665.00, 5294.00, 3309.00, 600.00, 1749.00, 198.00, 196.00, 1250.00, 0.00, 55541.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 44088.00, '10114226', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 7, 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 0.00, 0.00, 48975.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 36106.00, '10108872', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 8, 1, 29060.00, 9601.00, 4766.00, 2979.00, 600.00, 1575.00, 198.00, 196.00, 1250.00, 0.00, 50225.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 35901.00, '20104280', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 9, 1, 33145.00, 10951.00, 5436.00, 3397.00, 600.00, 1796.00, 198.00, 196.00, 0.00, 0.00, 55719.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 28577.00, '10108796', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 10, 1, 23360.00, 7718.00, 3831.00, 2394.00, 600.00, 1266.00, 198.00, 196.00, 0.00, 0.00, 39563.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 269.00, 1750.00, 1580.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 8502.00, 31061.00, '20114909', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 11, 1, 22130.00, 7312.00, 3629.00, 2268.00, 600.00, 1199.00, 198.00, 196.00, 1250.00, 0.00, 38782.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 2600.00, 0.00, 0.00, 4750.00, 34032.00, '20118521', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 12, 1, 15500.00, 5121.00, 2542.00, 1589.00, 600.00, 840.00, 198.00, 196.00, 0.00, 0.00, 26586.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 589.00, 2089.00, 1260.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 8588.00, 17998.00, '20123493', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 13, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 831.00, 24104.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10643.00, 13461.00, '20109621', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 14, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 9143.00, 15792.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1209.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5589.00, 10203.00, '20102437', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 15, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 2494.00, 22441.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10267.00, 12174.00, '20111876', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 16, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 3130.00, 21805.00, '10110886', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 17, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 489.00, 3000.00, 1508.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 9127.00, 15808.00, '20111826', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 1, '7', 2022, 18, 1, 14500.00, 4791.00, 2378.00, 1486.00, 600.00, 786.00, 198.00, 196.00, 0.00, 0.00, 24935.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 967.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 5097.00, 19838.00, '10113013', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '7', 2022, 19, 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2707.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10504.00, 10496.00, '10109891', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '7', 2022, 20, 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, '20120730', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '7', 2022, 21, 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 367.00, 10633.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 110.00, 10523.00, '10113275', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '7', 2022, 22, 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 2662.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 4716.00, 8284.00, '20104071', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '7', 2022, 23, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, '20105798', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '7', 2022, 24, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, '20105799', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-17', 2, '7', 2022, 25, 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 667.00, 9333.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 113.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 363.00, 8970.00, '20124646', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 1, 1, 57870.00, 21308.00, 9491.00, 4000.00, 600.00, 3495.00, 221.00, 196.00, 0.00, 0.00, 97181.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2529.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 3000.00, 0.00, 15118.00, 82063.00, '20122081', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 2, 1, 55880.00, 20575.00, 9164.00, 4000.00, 600.00, 3374.00, 221.00, 196.00, 0.00, 0.00, 94010.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 1000.00, 20.00, 37732.00, 56278.00, '20104765', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 3, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 0.00, 100349.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 3000.00, 20.00, 26038.00, 74311.00, '10106016', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 4, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 0.00, 100349.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 1000.00, 0.00, 42925.00, 57424.00, '10108744', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 5, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 600.00, 0.00, 100949.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 5000.00, 0.00, 24906.00, 76043.00, '10105782', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 6, 1, 32280.00, 11885.00, 5294.00, 3309.00, 600.00, 1949.00, 221.00, 196.00, 1250.00, 0.00, 56984.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 11453.00, 45531.00, '10114226', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 7, 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 0.00, 0.00, 52802.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 12869.00, 39933.00, '10108872', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 8, 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 1250.00, 0.00, 54052.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 3500.00, 0.00, 20.00, 14324.00, 39728.00, '20104280', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 9, 1, 33145.00, 12204.00, 5436.00, 3397.00, 600.00, 2002.00, 221.00, 196.00, 0.00, 0.00, 57201.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 3500.00, 0.00, 0.00, 27142.00, 30059.00, '10108796', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 10, 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 1250.00, 0.00, 41864.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 277.00, 1750.00, 1580.00, 0.00, 0.00, 200.00, 0.00, 2600.00, 0.00, 0.00, 8560.00, 33304.00, '20114909', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 11, 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 0.00, 0.00, 40614.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 2600.00, 0.00, 0.00, 4800.00, 35814.00, '20118521', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 12, 1, 15500.00, 5707.00, 2542.00, 1589.00, 600.00, 936.00, 221.00, 196.00, 0.00, 0.00, 27291.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 606.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 1900.00, 0.00, 0.00, 8650.00, 18641.00, '20123493', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 13, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 4266.00, 21330.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 10663.00, 10667.00, '20109621', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 14, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 853.00, 24743.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1243.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 5643.00, 19100.00, '20102437', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 15, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 5119.00, 20477.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 10287.00, 10190.00, '20111876', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 16, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 3150.00, 22446.00, '10110886', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 17, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 500.00, 3000.00, 1508.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 9158.00, 16438.00, '20111826', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '8', 2022, 18, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 534.00, 0.00, 0.00, 150.00, 0.00, 1000.00, 0.00, 0.00, 6184.00, 19412.00, '10113013', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '8', 2022, 19, 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2656.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 10453.00, 10547.00, '10109891', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '8', 2022, 20, 2, 15000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 110.00, 0.00, 1000.00, 0.00, 0.00, 6374.00, 8626.00, '20120730', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '8', 2022, 21, 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 550.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 660.00, 10340.00, '10113275', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '8', 2022, 22, 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 2647.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 5301.00, 7699.00, '20104071', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '8', 2022, 23, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 1730.00, 18270.00, '20105798', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '8', 2022, 24, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 1000.00, 0.00, 0.00, 4488.00, 15512.00, '20105799', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '8', 2022, 25, 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 8000.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 111.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 861.00, 7139.00, '20124646', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 1, 1, 57870.00, 21308.00, 9491.00, 4000.00, 600.00, 3495.00, 221.00, 196.00, 0.00, 0.00, 97181.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2346.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 3000.00, 0.00, 11435.00, 85746.00, '20122081', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 2, 1, 55880.00, 20575.00, 9164.00, 4000.00, 600.00, 3374.00, 221.00, 196.00, 0.00, 0.00, 94010.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 0.00, 1000.00, 20.00, 34232.00, 59778.00, '20104765', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 3, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 0.00, 100349.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 3000.00, 20.00, 22538.00, 77811.00, '10106016', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 4, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 0.00, 100349.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 0.00, 1000.00, 0.00, 39425.00, 60924.00, '10108744', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 5, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 600.00, 0.00, 100949.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 5000.00, 0.00, 21406.00, 79543.00, '10105782', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 6, 1, 32280.00, 11885.00, 5294.00, 3309.00, 600.00, 1949.00, 221.00, 196.00, 1250.00, 0.00, 56984.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 7953.00, 49031.00, '10114226', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 7, 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 0.00, 0.00, 52802.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 9369.00, 43433.00, '10108872', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 8, 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 1250.00, 0.00, 54052.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 10824.00, 43228.00, '20104280', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 9, 1, 33145.00, 12204.00, 5436.00, 3397.00, 600.00, 2002.00, 221.00, 196.00, 0.00, 0.00, 57201.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 0.00, 0.00, 23642.00, 33559.00, '10108796', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 10, 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 0.00, 0.00, 40614.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 259.00, 1750.00, 1580.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0.00, 5942.00, 34672.00, '20114909', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 11, 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 1250.00, 0.00, 41864.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 39664.00, '20118521', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 12, 1, 15500.00, 5707.00, 2542.00, 1589.00, 600.00, 936.00, 221.00, 196.00, 0.00, 0.00, 27291.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 348.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 5892.00, 21399.00, '20123493', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 13, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 5119.00, 20477.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 9663.00, 10814.00, '20109621', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 14, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 3413.00, 22183.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1156.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 4556.00, 17627.00, '20102437', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 15, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 3413.00, 22183.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 9287.00, 12896.00, '20111876', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 16, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 2150.00, 23446.00, '10110886', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 17, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 463.00, 3000.00, 1508.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 8121.00, 17475.00, '20111826', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 18, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 1180.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 5830.00, 19766.00, '10113013', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '9', 2022, 19, 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2433.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 9230.00, 11770.00, '10109891', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 1, '9', 2022, 20, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 853.00, 24743.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 6814.00, 17929.00, '20120730', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '9', 2022, 21, 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 367.00, 10633.00, 550.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 660.00, 9973.00, '10113275', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '9', 2022, 22, 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 2461.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 5115.00, 7885.00, '20104071', NULL, NULL, NULL, NULL, 'System Generated', 'A');
INSERT INTO `td_pay_slip` (`trans_date`, `trans_no`, `sal_month`, `sal_year`, `emp_code`, `catg_id`, `basic`, `da`, `sa`, `hra`, `ta`, `da_on_sa`, `da_on_ta`, `ma`, `cash_swa`, `lwp`, `final_gross`, `pf`, `adv_agst_hb_prin`, `adv_agst_hb_int`, `adv_agst_hb_const_prin`, `adv_agst_hb_const_int`, `adv_agst_hb_staff_prin`, `adv_agst_hb_staff_int`, `gross_hb_int`, `adv_agst_of_staff_prin`, `adv_agst_of_staff_int`, `staff_adv_ext_prin`, `staff_adv_ext_int`, `motor_cycle_prin`, `motor_cycle_int`, `p_tax`, `gici`, `puja_adv`, `income_tax_tds`, `union_subs`, `tot_diduction`, `net_sal`, `bank_ac_no`, `created_by`, `created_dt`, `modified_by`, `modified_dt`, `remarks`, `approval_status`) VALUES
('2022-10-18', 2, '9', 2022, 23, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 730.00, 19270.00, '20105798', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '9', 2022, 24, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 3488.00, 16512.00, '20105799', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-18', 2, '9', 2022, 25, 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 333.00, 9667.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 102.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 852.00, 8815.00, '20124646', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 1, 1, 57870.00, 21308.00, 9491.00, 4000.00, 600.00, 3495.00, 221.00, 196.00, 0.00, 0.00, 97181.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3889.00, 2570.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 3000.00, 0.00, 11659.00, 85522.00, '20122081', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 2, 1, 55880.00, 20575.00, 9164.00, 4000.00, 600.00, 3374.00, 221.00, 196.00, 0.00, 0.00, 94010.00, 2000.00, 0.00, 0.00, 7273.00, 5018.00, 3500.00, 1759.00, 6777.00, 4273.00, 2511.00, 4167.00, 2511.00, 0.00, 0.00, 200.00, 0.00, 0.00, 1000.00, 20.00, 34232.00, 59778.00, '20104765', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 3, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 0.00, 100349.00, 2000.00, 0.00, 0.00, 565.00, 273.00, 15152.00, 1288.00, 1561.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 3000.00, 20.00, 22538.00, 77811.00, '10106016', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 4, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 0.00, 0.00, 100349.00, 2000.00, 2222.00, 1006.00, 10000.00, 3025.00, 5333.00, 2014.00, 6045.00, 3809.00, 1010.00, 6250.00, 1516.00, 0.00, 0.00, 200.00, 40.00, 0.00, 1000.00, 0.00, 39425.00, 60924.00, '10108744', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 5, 1, 59860.00, 22040.00, 9817.00, 4000.00, 600.00, 3615.00, 221.00, 196.00, 600.00, 0.00, 100949.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 8333.00, 2521.00, 3611.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 5000.00, 0.00, 21406.00, 79543.00, '10105782', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 6, 1, 32280.00, 11885.00, 5294.00, 3309.00, 600.00, 1949.00, 221.00, 196.00, 1250.00, 0.00, 56984.00, 2000.00, 0.00, 0.00, 2222.00, 1090.00, 1667.00, 754.00, 1844.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 7953.00, 49031.00, '10114226', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 7, 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 0.00, 0.00, 52802.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 5385.00, 1764.00, 1764.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 9369.00, 43433.00, '10108872', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 8, 1, 30550.00, 11249.00, 5010.00, 3131.00, 600.00, 1845.00, 221.00, 196.00, 1250.00, 0.00, 54052.00, 2000.00, 0.00, 0.00, 1899.00, 818.00, 0.00, 0.00, 818.00, 1000.00, 555.00, 3947.00, 385.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 20.00, 10824.00, 43228.00, '20104280', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 9, 1, 33145.00, 12204.00, 5436.00, 3397.00, 600.00, 2002.00, 221.00, 196.00, 0.00, 0.00, 57201.00, 2000.00, 0.00, 0.00, 8696.00, 1522.00, 0.00, 0.00, 1522.00, 8911.00, 2273.00, 0.00, 0.00, 0.00, 0.00, 200.00, 40.00, 0.00, 0.00, 0.00, 23642.00, 33559.00, '10108796', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 10, 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 1250.00, 0.00, 41864.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 153.00, 285.00, 1750.00, 1580.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0.00, 5968.00, 35896.00, '20114909', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 11, 1, 23360.00, 8601.00, 3831.00, 2394.00, 600.00, 1411.00, 221.00, 196.00, 0.00, 0.00, 40614.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 38414.00, '20118521', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 12, 1, 15500.00, 5707.00, 2542.00, 1589.00, 600.00, 936.00, 221.00, 196.00, 0.00, 0.00, 27291.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2944.00, 2788.00, 2089.00, 1305.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 11276.00, 16015.00, '20123493', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 13, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 5119.00, 20477.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5000.00, 2513.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 9663.00, 10814.00, '20109621', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 14, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 1706.00, 23890.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 1270.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 4670.00, 19220.00, '20102437', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 15, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 5972.00, 19624.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4750.00, 2387.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 9287.00, 10337.00, '20111876', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 16, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 2150.00, 23446.00, '10110886', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 17, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 506.00, 3000.00, 1508.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 8164.00, 17432.00, '20111826', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 18, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 1290.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 5940.00, 19656.00, '10113013', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 2, '10', 2022, 19, 2, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6667.00, 2637.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 9434.00, 11566.00, '10109891', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 1, '10', 2022, 20, 1, 14500.00, 5339.00, 2378.00, 1486.00, 600.00, 876.00, 221.00, 196.00, 0.00, 0.00, 25596.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2778.00, 1886.00, 0.00, 0.00, 150.00, 0.00, 0.00, 0.00, 0.00, 6814.00, 18782.00, '20120730', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 2, '10', 2022, 21, 2, 11000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11000.00, 550.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 660.00, 10340.00, '10113275', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 2, '10', 2022, 22, 2, 13000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1944.00, 2700.00, 0.00, 0.00, 110.00, 0.00, 0.00, 0.00, 0.00, 5354.00, 7646.00, '20104071', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 2, '10', 2022, 23, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 730.00, 19270.00, '20105798', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 2, '10', 2022, 24, 2, 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20000.00, 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 758.00, 0.00, 0.00, 130.00, 0.00, 0.00, 0.00, 0.00, 3488.00, 16512.00, '20105799', NULL, NULL, NULL, NULL, 'System Generated', 'A'),
('2022-10-21', 2, '10', 2022, 25, 2, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 69.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1569.00, 8431.00, '20124646', NULL, NULL, NULL, NULL, 'System Generated', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `td_salary`
--

CREATE TABLE `td_salary` (
  `trans_date` date NOT NULL,
  `trans_no` int(11) NOT NULL,
  `sal_month` int(10) NOT NULL,
  `sal_year` int(11) NOT NULL,
  `catg_cd` int(11) NOT NULL,
  `approval_status` varchar(1) NOT NULL DEFAULT 'U',
  `created_by` varchar(50) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  `approved_by` varchar(50) DEFAULT NULL,
  `approved_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `td_salary`
--

INSERT INTO `td_salary` (`trans_date`, `trans_no`, `sal_month`, `sal_year`, `catg_cd`, `approval_status`, `created_by`, `created_dt`, `modified_by`, `modified_dt`, `approved_by`, `approved_dt`) VALUES
('2022-03-31', 0, 3, 2022, 1, 'A', 'admin', '2022-10-11 00:00:00', NULL, NULL, 'admin', '2022-10-11 00:00:00'),
('2022-03-31', 0, 3, 2022, 2, 'A', 'admin', '2022-10-11 00:00:00', NULL, NULL, 'admin', '2022-10-11 00:00:00'),
('2022-10-14', 1, 4, 2022, 1, 'A', 'sss', '2022-10-14 12:28:39', NULL, NULL, 'sss', '2022-10-14 00:00:00'),
('2022-10-15', 1, 4, 2022, 2, 'A', 'sss', '2022-10-15 07:41:30', NULL, NULL, 'sss', '2022-10-15 00:00:00'),
('2022-10-17', 1, 5, 2022, 1, 'A', 'sss', '2022-10-17 11:49:23', NULL, NULL, 'sss', '2022-10-17 00:00:00'),
('2022-10-17', 1, 6, 2022, 1, 'A', 'sss', '2022-10-17 01:05:54', NULL, NULL, 'sss', '2022-10-17 00:00:00'),
('2022-10-17', 1, 7, 2022, 1, 'A', 'sss', '2022-10-17 02:11:23', NULL, NULL, 'sss', '2022-10-17 00:00:00'),
('2022-10-17', 2, 5, 2022, 2, 'A', 'sss', '2022-10-17 12:30:55', NULL, NULL, 'sss', '2022-10-17 00:00:00'),
('2022-10-17', 2, 6, 2022, 2, 'A', 'sss', '2022-10-17 01:16:57', NULL, NULL, 'sss', '2022-10-17 00:00:00'),
('2022-10-17', 2, 7, 2022, 2, 'A', 'sss', '2022-10-17 02:23:39', NULL, NULL, 'sss', '2022-10-17 00:00:00'),
('2022-10-18', 1, 8, 2022, 1, 'A', 'sss', '2022-10-18 08:57:51', NULL, NULL, 'sss', '2022-10-18 00:00:00'),
('2022-10-18', 1, 9, 2022, 1, 'A', 'sss', '2022-10-18 10:34:02', NULL, NULL, 'sss', '2022-10-18 00:00:00'),
('2022-10-18', 2, 8, 2022, 2, 'A', 'sss', '2022-10-18 09:55:52', NULL, NULL, 'sss', '2022-10-18 00:00:00'),
('2022-10-18', 2, 9, 2022, 2, 'A', 'sss', '2022-10-18 11:07:17', NULL, NULL, 'sss', '2022-10-18 00:00:00'),
('2022-10-21', 1, 10, 2022, 1, 'A', 'sss', '2022-10-21 03:31:04', NULL, NULL, 'sss', '2022-10-25 00:00:00'),
('2022-10-21', 2, 10, 2022, 2, 'A', 'sss', '2022-10-21 03:31:24', NULL, NULL, 'sss', '2022-10-25 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `td_stop_salary`
--

CREATE TABLE `td_stop_salary` (
  `trans_dt` date NOT NULL,
  `emp_no` int(11) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `status` varchar(1) NOT NULL,
  `remarks` text NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_dt` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `td_stop_salary`
--
DELIMITER $$
CREATE TRIGGER `ai_stop_salary` AFTER INSERT ON `td_stop_salary` FOR EACH ROW BEGIN

		UPDATE md_employee SET
                emp_status	=	NEW.status
            
                WHERE emp_code	=	NEW.emp_no;
     
     
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_pf_dtls`
--

CREATE TABLE `tm_pf_dtls` (
  `trans_dt` date NOT NULL,
  `trans_no` int(11) NOT NULL DEFAULT 0,
  `sal_month` varchar(10) NOT NULL,
  `sal_year` int(11) NOT NULL,
  `emp_no` int(11) NOT NULL,
  `employee_cntr` decimal(10,2) NOT NULL DEFAULT 0.00,
  `employer_cntr` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `md_basic_pay`
--
ALTER TABLE `md_basic_pay`
  ADD PRIMARY KEY (`effective_dt`,`emp_cd`);

--
-- Indexes for table `md_branch`
--
ALTER TABLE `md_branch`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_category`
--
ALTER TABLE `md_category`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `md_department`
--
ALTER TABLE `md_department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_district`
--
ALTER TABLE `md_district`
  ADD PRIMARY KEY (`district_code`);

--
-- Indexes for table `md_employee`
--
ALTER TABLE `md_employee`
  ADD PRIMARY KEY (`emp_code`);

--
-- Indexes for table `md_fin_year`
--
ALTER TABLE `md_fin_year`
  ADD PRIMARY KEY (`sl_no`);

--
-- Indexes for table `md_leave_allocation`
--
ALTER TABLE `md_leave_allocation`
  ADD PRIMARY KEY (`sl_no`);

--
-- Indexes for table `md_month`
--
ALTER TABLE `md_month`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_parameters`
--
ALTER TABLE `md_parameters`
  ADD PRIMARY KEY (`sl_no`);

--
-- Indexes for table `md_ptax`
--
ALTER TABLE `md_ptax`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_ptax_slab`
--
ALTER TABLE `md_ptax_slab`
  ADD PRIMARY KEY (`effective_dt`,`sl_no`);

--
-- Indexes for table `md_users`
--
ALTER TABLE `md_users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `td_attendance`
--
ALTER TABLE `td_attendance`
  ADD PRIMARY KEY (`trans_dt`,`sal_year`,`sal_month`,`emp_cd`);

--
-- Indexes for table `td_audit_trail`
--
ALTER TABLE `td_audit_trail`
  ADD PRIMARY KEY (`sl_no`);

--
-- Indexes for table `td_deductions`
--
ALTER TABLE `td_deductions`
  ADD PRIMARY KEY (`emp_code`,`effective_date`,`catg_id`) USING BTREE;

--
-- Indexes for table `td_income`
--
ALTER TABLE `td_income`
  ADD PRIMARY KEY (`emp_code`,`effective_date`,`catg_id`) USING BTREE;

--
-- Indexes for table `td_leave_dtls`
--
ALTER TABLE `td_leave_dtls`
  ADD PRIMARY KEY (`trans_dt`,`trans_cd`) USING BTREE;

--
-- Indexes for table `td_leave_mat`
--
ALTER TABLE `td_leave_mat`
  ADD PRIMARY KEY (`trans_cd`,`trans_dt`) USING BTREE;

--
-- Indexes for table `td_pay_slip`
--
ALTER TABLE `td_pay_slip`
  ADD PRIMARY KEY (`trans_date`,`sal_month`,`sal_year`,`emp_code`);

--
-- Indexes for table `td_salary`
--
ALTER TABLE `td_salary`
  ADD PRIMARY KEY (`trans_date`,`trans_no`,`sal_month`,`sal_year`,`catg_cd`) USING BTREE;

--
-- Indexes for table `td_stop_salary`
--
ALTER TABLE `td_stop_salary`
  ADD PRIMARY KEY (`trans_dt`,`emp_no`) USING BTREE;

--
-- Indexes for table `tm_pf_dtls`
--
ALTER TABLE `tm_pf_dtls`
  ADD PRIMARY KEY (`trans_dt`,`emp_no`,`sal_month`,`sal_year`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `md_branch`
--
ALTER TABLE `md_branch`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Here id is Disctrict Code', AUTO_INCREMENT=349;

--
-- AUTO_INCREMENT for table `md_category`
--
ALTER TABLE `md_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `md_department`
--
ALTER TABLE `md_department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `md_district`
--
ALTER TABLE `md_district`
  MODIFY `district_code` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=349;

--
-- AUTO_INCREMENT for table `md_fin_year`
--
ALTER TABLE `md_fin_year`
  MODIFY `sl_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `md_leave_allocation`
--
ALTER TABLE `md_leave_allocation`
  MODIFY `sl_no` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `md_month`
--
ALTER TABLE `md_month`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `md_parameters`
--
ALTER TABLE `md_parameters`
  MODIFY `sl_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `md_ptax`
--
ALTER TABLE `md_ptax`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `td_audit_trail`
--
ALTER TABLE `td_audit_trail`
  MODIFY `sl_no` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
