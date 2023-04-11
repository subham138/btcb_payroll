-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2022 at 03:07 PM
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
(1, 'Permanent', 36.82, 16.40, 10.25, 4000.00, 12.00, 6000.00, 0.00, 600.00, 196.00, 'sss', '2022-09-15 02:23:52', 'sss', '2022-09-15 02:27:28'),
(2, 'Temporary', 0.00, 0.00, 0.00, 0.00, 5.00, 600.00, 300.00, 0.00, 0.00, 'sss', '2022-09-15 02:28:31', 'sss', '2022-09-15 02:28:45');

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
(1, 'ACCOUNTS', '2022-08-25 00:00:00', 'demo', '2022-08-25 06:25:47', 'sss'),
(2, 'demo', '2022-08-25 05:24:53', 'sss', '2022-08-25 06:25:55', 'sss');

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
(0, 'SHYAM KUMAR CHETRI', 2, 332, '1975-04-05', '2000-06-11', '2035-04-30', 'Sr. Assistant', 'demo', '9475699969', '', 'AQVPC7886M', '674600585326', 'Puratali, Chaituli Lane, PO. & Dist. Malda.\r\n', 'SBI', '523658956', 'WB/CAL/13787/665', '100383139665', '0.00', 'anirbanc', '2021-02-26 07:58:07', 'R', NULL, 'sss', '2022-08-30 03:16:44'),
(99, 'SAMIR KUMAR DINDA', 2, 344, '1964-07-16', '1985-09-01', '2024-07-31', 'Group-D', '', '9647477663', '', 'AFDPD8982L', '', 'PO.Subhasnagar Midnapur, Dist. Midnapur(West)\r\n', 'SBI', '31457384087', 'WB/CAL/13787/455', '100378585225', '42300.00', 'anirbanc', '2021-02-26 05:55:15', 'A', NULL, NULL, NULL),
(100, 'TAPAN KUMAR DAS', 2, 328, '1962-01-07', '1998-10-03', '2022-01-31', 'Group-D', '', '9832526542', '', 'BAAPD1291H', '290737907631', 'Temple Street, Near Ananda Model High School, Jalpaiguri-735101\r\n', 'SBI', '31410825562', 'WB/CAL/13787/642', '100393148501', '33400.00', 'anirbanc', '2021-02-27 10:32:42', 'A', NULL, 'anirbanc', '2021-02-27 10:37:55'),
(101, 'GOUTAM SINGHA ROY', 2, 342, '1962-01-04', '1998-11-03', '2022-01-31', 'Group-D', 'Engineering', '9679777146', '', 'DHJPS4192C', '725141441465', '\"Vill. Goonpala, PO:Babnan, \r\nDist.Hooghly-712305\"\r\n', 'SBI', '20065033102', 'WB/CAL/13787/635', '100159329565', '33400.00', 'anirbanc', '2021-02-25 07:02:37', 'A', NULL, 'anirbanc', '2021-02-25 10:41:03'),
(102, 'BISWAJIT ADHIKARI', 2, 345, '1969-05-11', '1998-11-03', '2029-05-31', 'Group-D', '', '09477851002', '', '', '217341736013', '\"P/2 P.B.Road, Prafulla Ch. Sen Colony, \r\nKolkata-700 041.\"\r\n', 'SBI', '20072906986', 'WB/CAL/13787/577', '100119927751', '33401.00', 'anirbanc', '2021-02-25 05:45:07', 'A', NULL, 'anirbanc', '2021-02-25 10:41:13'),
(105, 'SWARUP KOLEY', 2, 335, '1971-08-17', '1998-12-03', '2031-08-31', 'Group-D', '', '9474662722', '', 'BTHPK6999R', '670001805590', 'Vill. Moyna, PO.Nabagram, Dist. Burdwan, PS.Jamalpur\r\n', 'SBI', '31439513797', 'WB/CAL/13787/605', '100386773909', '33400.00', 'anirbanc', '2021-02-27 10:28:51', 'A', NULL, NULL, NULL),
(163, 'TAPAS SINGHA ROY', 2, 331, '1965-11-08', '1989-12-06', '2025-11-30', 'Sr. Assistant', '', '9434502270', '', 'CNMPS3803A', '462175185674', '80, Bebekananda Pally, PO.Berhimpur, Dist.Murshidabad\r\n', 'SBI', '31474251080', 'WB/CAL/13787/506', '100393175285', '53300.00', 'anirbanc', '2021-02-27 10:49:20', 'A', NULL, NULL, NULL),
(165, 'DEB KUMAR ROY', 2, 342, '1969-09-10', '1991-03-04', '2029-09-30', 'Dy.Manager', 'Marketing', '8902233094', '', 'AHGPR4514F', '0', '\"Vill.Kanagarh, PO:Naldanga, PS:Chinsurah, \r\nDist. Hooghly-712123.\"\r\n', 'SBI', '31445593469', 'WB/CAL/13787/514', '100142462431', '65000.00', 'anirbanc', '2021-02-25 06:00:08', 'A', NULL, 'anirbanc', '2021-02-25 10:41:31'),
(170, 'KRISHNA GOPAL DUTTA', 2, 342, '1965-01-07', '1987-08-10', '2025-01-31', 'Dy.Manager (A/cs)', 'ACCOUNTS', '9732238515', '', 'ADWPD3365L', '239496547512', '\"Vidyasagarpally (Harinarayanpur) \r\nPO.Bajeprotapur, PS.Burdwan Sadar, \"\r\n', 'SBI', '31433467519', 'WB/CAL/13787/485', '100201097040', '65000.00', 'anirbanc', '2021-02-25 09:10:12', 'A', NULL, 'anirbanc', '2021-02-25 10:02:00'),
(174, 'SAMIR KANTI SAHA', 2, 342, '1964-12-15', '1989-05-07', '2024-12-31', 'Asstt.Manager', 'Marketing', '9433401739', '', 'DEBPS8751A', '641643271489', 'BA-164, Salt Lake City, Sector-1, Kolkata-700 064\r\n', 'SBI', '20065032799', 'WB/CAL/13787/495', '100378582988', '57400.00', 'anirbanc', '2021-02-26 05:48:21', 'R', NULL, 'sss', '2022-08-30 04:59:02'),
(183, 'SUMAN CHAKRABORTY', 2, 340, '1987-10-25', '2012-08-12', '2047-10-31', 'Dy.Manager', '', '9474043365', '', 'APJPC4302F', '831189659203', 'Vill.Khairamary, P.O.&PS. Bongaon, Dist. North 24-Pgns. Pin-743235\r\n', 'SBI', '32241026517', 'WB/CAL/13787/689', '100385394509', '63100.00', 'anirbanc', '2021-02-26 09:22:20', 'A', NULL, NULL, NULL),
(184, 'KOUSHIK CHAKRABORTY', 2, 329, '1985-10-08', '2012-03-13', '2045-10-31', 'Dy.Manager', '', '9434872039', '', 'AJJPC9155C', '974666259562', '\"Vill. Barashimulguri, PO.Ghoksadanga, \r\nDist.Coochbehar 736171\"\r\n', 'SBI', '32246748368', 'WB/CAL/13787/691', '100201011979', '63100.00', 'anirbanc', '2021-02-25 09:05:47', 'A', NULL, 'anirbanc', '2021-02-25 10:02:58'),
(187, 'SITANGSU MANDAL', 2, 342, '1967-07-20', '1988-04-20', '2027-07-31', 'Group-D', 'Personnel', '9734418409', '', 'BFEPM8570B', '880381808455', 'Vill. Radna, PO.Hotar, PS Mograhat, Dist.24-Parganas(South)-743610\r\n', 'SBI', '20065032802', 'WB/CAL/13787/489', '100383445032', '38700.00', 'anirbanc', '2021-02-26 08:03:32', 'A', NULL, NULL, NULL),
(203, 'PARTHA ROY', 2, 332, '1968-01-01', '1986-10-06', '2027-12-31', 'Sr. Assistant', '', '', '', '', '479968117300', 'Flat No.2C, 2nd Fl. 2/39A/1, Vidyasagar Colony, PS Jadavpur, Kolkata-700 047.\r\n', 'SBI', '31464880087', 'WB/CAL/13787/474', '100284120097', '50200.00', 'anirbanc', '2021-02-25 03:55:33', 'A', NULL, NULL, NULL),
(209, 'SUJIT SAHA', 2, 344, '1966-12-19', '1987-10-26', '2026-12-31', 'Sr. Assistant', '', '9434178010', '', 'CFYPS1299N', '534453966224', 'Vill.Kasthagura, PO.Panikotor, PS.Garhbeta, Dist. Paschim Medinipur-721127\r\n', 'SBI', '31356977785', 'WB/CAL/13787/483', '100385227621', '47300.00', 'anirbanc', '2021-02-26 09:17:59', 'A', NULL, NULL, NULL),
(213, 'RABINDRA NATH PAL', 2, 334, '1961-07-06', '1990-10-04', '2021-07-31', 'Group-D', '', '9126115661', '', 'BNTPP0888G', '897877536065', 'Vill.Maldiha, PO.Kablilpur, PS.Mahamad Bazar, Dist. Birbhum:731132\r\n', 'SBI', '31421199642', 'WB/CAL/13787/504', '100317019949', '37600.00', 'anirbanc', '2021-02-26 05:13:28', 'A', NULL, NULL, NULL),
(214, 'ARABINDA DAS', 2, 335, '1965-04-04', '1990-11-04', '2025-04-30', 'Group-D', '', '9872448636', '', 'AXLPD8785B', '571765437786', '\"Talmarai Kundu Pukur Dakshin Gally, \r\nPO: & Dist. Burdwan-713101.\"\r\n', 'SBI', '31433555439', 'WB/CAL/13787/503', '100100260200', '37600.00', 'anirbanc', '2021-02-25 04:30:04', 'A', NULL, 'anirbanc', '2021-02-25 10:04:39'),
(215, 'SK. KOARMANUDDIN', 2, 343, '1973-01-03', '1991-08-14', '2033-01-31', 'Assistant', '', '9564829330', '', 'BTLPK4675G', '237034354922', 'Vill.Ichapur (D.K.Para), PO & PS.Memari, Dist. Burdwan-713146\r\n', 'SBI', '30833868591', 'WB/CAL/13787/516', '100383574694', '42100.00', 'anirbanc', '2021-02-26 08:12:08', 'A', NULL, NULL, NULL),
(234, 'JALAL AHMED KHAN', 2, 341, '1961-06-16', '1980-01-30', '2021-06-30', 'Group-D', '', '9733328885', '', 'BYWPK8105P', '800105113535', '\"Vill.Jalalshi, PO: Islampur, PS.Jagathballavpur, \r\nDist. Howrah.\"\r\n', 'SBI', '31434667006', 'WB/CAL/13787/425', '100179676498', '50500.00', 'anirbanc', '2021-02-25 07:48:22', 'A', NULL, 'anirbanc', '2021-02-25 10:04:54'),
(236, 'SARAJIT KUMAR GHOSAL', 2, 333, '1961-10-30', '1980-01-30', '2021-10-31', 'Sr. Assistant', '', '9434009780', '', 'AELPG0653A', '834494131266', 'Vill. Keshabnagar, PO.Cossimbazar Raj, Dist.Murshidabad-742102.\r\n', 'SBI', '31418727363', 'WB/CAL/13787/410', '100379875339', '63600.00', 'anirbanc', '2021-02-26 06:37:33', 'A', NULL, NULL, NULL),
(238, 'PRADIP KUMAR DAS', 0, 344, '1967-01-25', '1986-05-07', '2027-01-31', 'Group-D', '', '8768236754', '', 'BAXPD3762L', '', 'Vill. Ekteswar, PO. Bankura, Dist. Bankura 722101\r\n', 'SBI', '20078612573', 'WB/CAL/13787/473', '100285074467', '39900.00', 'anirbanc', '2021-02-25 04:29:05', 'A', NULL, NULL, NULL),
(239, 'JAKIR AHMED KHAN', 2, 341, '1964-01-02', '1989-05-23', '2024-01-31', 'Group-D', '', '9735735568', '', 'COVPK2178E', '373021009615', 'Vill.Jalalshi, PO: Islampur, Dist. Howrah.\r\n', 'SBI', '31434653774', 'WB/CAL/13787/494', '100179668099', '37600.00', 'anirbanc', '2021-02-25 07:44:04', 'A', NULL, 'anirbanc', '2021-02-25 10:05:08'),
(240, 'SMT. ANIMA SAMANTA', 2, 344, '1961-07-15', '1998-12-13', '2021-07-31', 'Group-D', '', '0', '', 'AQNPS4487L', '788858944998', '\"Vill.Bachardoba,PO:Jhargram, \r\nDist. Midnapur(W).\"\r\n', 'SBI', '20072906895', 'WB/CAL/13787/492', '100099583882', '38700.00', 'anirbanc', '2021-02-25 04:19:25', 'A', NULL, 'anirbanc', '2021-02-25 10:06:32'),
(242, 'SMT. ARCHANA DAS', 2, 339, '1973-09-05', '1993-03-08', '2033-09-30', 'Group-D', '', '9933756132', '', '', '919971600480', 'Vill.& PO: Kenduadihi, Dist. Bankura.\r\n', 'SBI', '31424769156', 'WB/CAL/13787/517', '100100309077', '35400.00', 'anirbanc', '2021-02-25 04:33:37', 'A', NULL, 'anirbanc', '2021-02-25 10:08:07'),
(243, 'SMT. LAXMI MURMU', 2, 336, '1963-05-06', '1995-04-08', '2023-05-31', 'Group-D', '', '8348739471', '', 'BKXPM6765N', '645472195089', 'Vill.Palpara Netajinagar, PO & PS. Chakdah, Dist. Nadia\r\n', 'SBI', '31445593538', 'WB/CAL/13787/518', '100207354891', '35400.00', 'anirbanc', '2021-02-25 09:14:56', 'A', NULL, 'anirbanc', '2021-02-25 10:11:37'),
(249, 'SMT. SELIMA BIBI', 2, 343, '1968-09-10', '1996-07-16', '2028-09-30', 'Group-D', '', '9775232684', '', 'BPZPB5184H', '978054651110', 'Vill.Tala, PO.Sengrampur Hat, PS.Usti, Dist. South 24-Pgns.\r\n', 'SBI', '31403672023', 'WB/CAL/13787/523', '100380802293', '33400.00', 'anirbanc', '2021-02-26 06:57:00', 'A', NULL, NULL, NULL),
(250, 'MD. ABDUL WALI MONDAL', 2, 334, '1973-12-26', '1996-07-18', '2033-12-31', 'Group-D', '', '9609684863', '', 'BGTPM0919C', '716064964901', '\"Vill.Bandhgacha, PO.Bolpur,PS Raina-I,\r\n Dist.Burdwqan- 713103\"\r\n', 'SBI', '31436510993', 'WB/CAL/13787/524', '100097382142', '33400.00', 'anirbanc', '2021-02-25 10:54:47', 'A', NULL, NULL, NULL),
(251, 'SUJIT DAS GUPTA', 2, 336, '1970-04-12', '1996-08-19', '2030-04-30', 'Group-D', '', '9748970154', '', 'AWQPD8026M', '968619818724', '10, Rabindrapally, Khardah, 24-Parganas (North) (near Pincall)\r\n', 'SBI', '31424907438', 'WB/CAL/13787/525', '100385218612', '33400.00', 'anirbanc', '2021-02-26 09:12:01', 'A', NULL, NULL, NULL),
(252, 'SUBRATA KR. LAHA', 2, 345, '1968-07-15', '1996-01-15', '2028-07-31', 'Sr. Assistant', '', '9830820131', '', 'AGHPL7749L', '967311153304', '4/2/1, Abhoy Pada Kundu Lane, Kadamtala, PS.Bantra, Dist. Howrah-711101\r\n', 'SBI', '31498337481', 'WB/CAL/13787/526', '100384868004', '43300.00', 'anirbanc', '2021-02-26 08:54:03', 'A', NULL, NULL, NULL),
(256, 'Abdul Kalam', 2, 334, '1965-03-10', '1996-08-20', '2025-03-31', ' Assistant', '', '7797540205', '', 'BRSPK6036L', '448137864789', '\"Maonya Chaulpatty, Ward No.07,PO Tarakeswar,\r\nDist. Hooghly-712410.\"\r\n', 'STATE BANK OF INDIA, DOVER PLACE BRANCH', '20065032824', 'WB/CAL/13787/530', '100097347910', '38500.00', 'anirbanc', '2021-02-24 11:11:01', 'A', NULL, 'anirbanc', '2021-02-25 10:13:26'),
(257, 'ALOKE KUMAR KOLEY', 2, 343, '1963-10-01', '1996-08-20', '2023-02-28', 'BRANCH ACCOUNTANT', '', '9475061295', '', 'BRVPK6264R', '583956234260', '\"Vill.Kanchirapara, Dhaniakhali, PO&PS Dhaniakhali,\r\nDist.Hooghly-712302.\"\r\n', 'SBI', '31403639959', 'WB/CAL/13787/531', '100098443637', '44600.00', 'anirbanc', '2021-02-25 04:15:33', 'A', NULL, 'anirbanc', '2021-02-25 10:14:47'),
(260, 'MIHIR KUMAR SAHA', 2, 0, '1965-09-26', '1996-08-20', '2025-09-30', 'Sr. Assistant', '', '9732239149', '', '', '424776139812', 'Vill. Sahapur, PO.Belia via.Ahmadpur,Dist.Birbhum 731201\r\n', 'SBI', '31312803095', 'WB/CAL/13787/534', '100242366078', '44600.00', 'anirbanc', '2021-02-25 11:37:35', 'A', NULL, NULL, NULL),
(261, 'BIDYUT BHUSAN SADHU', 2, 338, '1964-12-12', '1996-08-20', '2024-12-31', 'Sr. Assistant', '', '8436838668', '', '', '214777818215', '\"B.C.Road Barabazar, PO:Rajbati, PS:Burdwan, \r\nDist. Burdwan-713104\"\r\n', 'SBI', '31403656158', 'WB/CAL/13787/535', '100119601559', '43300.00', 'anirbanc', '2021-02-25 05:34:46', 'A', NULL, 'anirbanc', '2021-02-25 10:16:45'),
(262, 'KASHI NATH MUKHOPADHYAY', 2, 330, '1964-01-10', '1996-08-20', '2024-01-31', 'Assistant', '', '9002841391', '', 'BGPPM7618Q', '929516334729', 'Vill.&PO:Rasulpur, Dist. Burdwan-713151.\r\n', 'SBI', '20073250923', 'WB/CAL/13787/536', '100200276002', '39700.00', 'anirbanc', '2021-02-25 08:58:29', 'A', NULL, 'anirbanc', '2021-02-25 10:17:06'),
(264, 'PRASANTA KUMAR DAS', 2, 342, '1962-03-25', '1996-08-16', '2022-03-31', 'Assistant', 'PERSONNEL', '9609638722', '', 'AWNPD5854E', '799740433162', 'Vill.&P.O.Porabazar, PS.Dhaniakhali, Dist. Hooghly712305\r\n', 'SBI', '20065033453', 'WB/CAL/13787/539', '100285555050', '39700.00', 'anirbanc', '2021-02-25 04:41:10', 'A', NULL, 'anirbanc', '2021-02-26 05:09:20'),
(265, 'SAMSUDDIN  MONDAL', 2, 334, '1968-08-24', '1996-08-20', '2028-08-31', 'Assistant', '', '8945008004', '', 'AZCPM5078K', '', 'Vill. Tatarpur, PO.Mermari, Dist. Burdwan-713146\r\n', 'SBI', '31421193991', 'WB/CAL/13787/540', '100378644622', '39700.00', 'anirbanc', '2021-02-26 06:00:09', 'A', NULL, NULL, NULL),
(270, 'DEBASISH DUTTA', 2, 339, '1963-06-06', '1996-08-20', '2023-06-30', 'BRANCH ACCOUNTANT', '', '9474361083', '', 'AKTPD7350D', '387103893692', '\"Vill.&PO:Guir, PS: Khandaghosh, \r\nDist. Burdwan-713423\"\r\n', 'SBI', '31498089403', 'WB/CAL/13787/545', '100142507537', '43300.00', 'anirbanc', '2021-02-25 06:23:08', 'A', NULL, 'anirbanc', '2021-02-25 10:19:14'),
(271, 'SANJOY DAS', 2, 342, '1963-08-06', '1996-08-21', '2023-08-31', 'Group-D', 'Personnel', '9832827830', '', 'BFFPD0736M', '771775133597', 'Vill. Mohanbati, PO. Nachipur,PS.Tarakeswar, Dist. Hooghly-312410\r\n', 'SBI', '20065032697', 'WB/CAL/13787/546', '100379427423', '33400.00', 'anirbanc', '2021-02-26 06:05:10', 'A', NULL, NULL, NULL),
(273, 'UJJAL BARAN PAUL', 2, 339, '1967-07-17', '1996-08-21', '2027-07-31', 'Assistant', '', '9474929513', '', 'AIOPP3644F', '549690186148', 'Vill.Adilpur, PO.Mandra, PS.Indas,Dist.Bankura-722201\r\n', 'SBI', '31424769134', 'WB/CAL/13787/548', '100396886103', '38496.00', 'anirbanc', '2021-02-27 11:13:19', 'A', NULL, NULL, NULL),
(274, 'BHAKTA PRASAD BHATTACHARJEE', 2, 338, '1970-05-25', '1996-08-21', '2030-05-31', 'Group-D', '', '8900326469', '', '', '296129939974', '\"Vill.&PO: Amadpur, PS: Memari,\r\nDist. Burdwan-713154\"\r\n', 'SBI', '20073250945', 'WB/CAL/13787/549', '100119097413', '33400.00', 'anirbanc', '2021-02-25 04:53:55', 'A', NULL, 'anirbanc', '2021-02-25 10:20:37'),
(275, 'SUDIP KUMAR DAS', 2, 336, '1967-01-22', '1996-08-20', '2027-01-31', 'Sr. Assistant', '', '9932880851', '', 'BBJPD2307L', '508892717094', 'Vill. & PO. Dadpur, Dist.Birbhum-731224\r\n', 'SBI', '31424769076', 'WB/CAL/13787/550', '100385089349', '44600.00', 'anirbanc', '2021-02-26 09:01:43', 'A', NULL, NULL, NULL),
(276, 'SUBHAS CHANDRA JALAL', 2, 339, '1965-01-01', '1996-08-22', '2024-12-31', 'Assistant', '', '9474725581', '', '', '493553642844', 'Vill.&PO. Goghat, Dist. Hooghly-712614\r\n', 'SBI', '20073251020', 'WB/CAL/13787/551', '100384707038', '39700.00', 'anirbanc', '2021-02-26 08:26:45', 'A', NULL, NULL, NULL),
(277, 'YUDISHTHIR DEY', 2, 338, '1963-09-29', '1996-08-21', '2023-09-30', 'Assistant', '', '9475802372', '', 'AFDPD8877Q', '410855286362', 'Vill.Gopinathpur, PO.Kinkar Bati, Haripal, Dist.Hooghly-712407\r\n', 'SBI', '20073250989', 'WB/CAL/13787/552', '100416778230', '37400.00', 'anirbanc', '2021-02-27 11:17:33', 'A', NULL, NULL, NULL),
(278, 'JAYDEEP CHAKRABORTY', 2, 333, '1966-07-01', '1996-08-22', '2026-06-30', 'Assistant', '', '9126357265', '', 'AJCPC8122C', '665845276785', '\"PS & PO Dubrajpur, Lalbazar, \r\nDist. Birbhum 731123\"\r\n', 'SBI', '31314524860', 'WB/CAL/13787/553', '100180654625', '43300.00', 'anirbanc', '2021-02-25 08:18:56', 'A', NULL, 'anirbanc', '2021-02-25 10:21:06'),
(279, 'PRABIR DUTTA', 2, 334, '1967-03-02', '1996-08-23', '2027-03-31', 'Branch Accountant', '', '9732174471', '', 'AWVPD7188D', '823975562410', 'Nalhati, Harihar Rice Mill Para, Ward No.06, PO.Nalhati(Ts) Dist. Burdwan\r\n', 'SBI', '31297479661', 'WB/CAL/13787/554', '100284890708', '44600.00', 'anirbanc', '2021-02-25 04:23:14', 'A', NULL, NULL, NULL),
(282, 'SMT. SANKARI GHOSH', 2, 338, '1968-05-10', '1996-08-21', '2028-05-31', 'Group-D', '', '8001585305', '', 'AYLPG5768L', '885267813371', 'Vill.Bajitpur, PO&PS. Tarakeswar, Dist. Hooghly-712410\r\n', 'SBI', '20073251064', 'WB/CAL/13787/558', '100379478471', '33400.00', 'anirbanc', '2021-02-26 06:10:59', 'A', NULL, NULL, NULL),
(283, 'JAYANTA KUMAR SAHA', 2, 334, '1977-08-01', '1997-05-29', '2037-01-31', 'Sr. Assistant', '', '9434325935', '', '', '998406507138', '\"Vill.Sahapur, PO.Balia, PS.Sainthia, \r\nDist. Birbhum 731201.\"\r\n', 'SBI', '11204059995', 'WB/CAL/13787/560', '100180015517', '48700.00', 'anirbanc', '2021-02-25 08:15:12', 'A', NULL, 'anirbanc', '2021-02-25 10:21:25'),
(284, 'SUBRATA KR. BOSE', 2, 337, '1965-07-29', '1998-09-03', '2025-07-31', 'Assistant', '', '9432389927', '', '', '588393144902', 'Vill. & PO. Porabazar, PS.Dhaniakhali, Dist. Hooghly-712305\r\n', 'SBI', '31433490162', 'WB/CAL/13787/561', '100384867622', '39700.00', 'anirbanc', '2021-02-26 08:48:08', 'A', NULL, NULL, NULL),
(285, 'PRAKASH CHATTERJEE', 2, 342, '1966-04-20', '1998-03-10', '2026-04-30', 'Group-D', 'G.M(B)', '', '', 'AOVPC4577R', '841318110025', '7/1,Guruprasad Chowdhury Lane, Kolkata : 700 006\r\n', 'SBI', '31424907392', 'WB/CAL/13787/573', '100285201531', '33400.00', 'anirbanc', '2021-02-25 04:35:12', 'A', NULL, NULL, NULL),
(286, 'TAPAN KUMAR PAL', 2, 342, '1965-02-18', '1998-11-03', '2025-02-28', '', 'FERTILISER', '8013124273', '', '', '306084233132', 'Vill. & PO. Jayer, PS.Pandua, Dist.Hooghly.\r\n', 'SBI', '20065032755', 'WB/CAL/13787/655', '100393151484', '33400.00', 'anirbanc', '2021-02-27 10:45:34', 'A', NULL, NULL, NULL),
(293, 'BISWAJIT MUKHERJEE', 2, 335, '1973-01-04', '1998-12-03', '2033-01-31', 'Assistant', '', '9474184548', '', 'BEQPN1886P', '746756575065', '\"Sukanta Nagar,(near Police line)PO: Sripally,\r\n Dist. Burdwan-713103\"\r\n', 'SBI', '20072906862', 'WB/CAL/13787/610', '100119941393', '43300.00', 'anirbanc', '2021-02-25 05:55:14', 'A', NULL, 'anirbanc', '2021-02-25 10:22:57'),
(294, 'SATYENDRA NATH GHOSH', 2, 339, '1965-01-15', '1998-12-03', '2025-01-31', 'Assistant', '', '9474565978', '', 'AXYPG9840P', '485660364499', 'Vill.Gopinathpur, PO.Burar, Via.Shyamsundar, PS.Raina,Dist.Burdwan-713424.\r\n', 'SBI', '31457384021', 'WB/CAL/13787/613', '100380566246', '39700.00', 'anirbanc', '2021-02-26 06:43:29', 'A', NULL, NULL, NULL),
(297, 'JAYANTA KUMAR HALDER', 2, 340, '1966-10-28', '1998-11-03', '2026-10-31', 'Assistant', '', '9477012328', '', '', '399889636505', '\"Vill.&P.O.Porabazar, PS.Dhaniakhali,\r\n Dist.Hooghly-712305\"\r\n', 'SBI', '20065033317', 'WB/CAL/13787/648', '100180014573', '39700.00', 'anirbanc', '2021-02-25 08:35:09', 'A', NULL, 'anirbanc', '2021-02-25 10:23:21'),
(298, 'PARTHA BHATTACHARYA', 2, 342, '1970-12-05', '1998-10-03', '2030-12-31', 'Sr. Assistant', 'PERSONNEL', '9830772370', '', 'APEPB6315G', '204924658854', '35/B/1B, Raja Nabakrishna Street, PS.Shyampukur, Kolkata-700 005\r\n', 'SBI', '20065032711', 'WB/CAL/13787/568', '100284111966', '43300.00', 'anirbanc', '2021-02-25 03:49:30', 'A', NULL, NULL, NULL),
(300, 'MAHABUB ALAM', 2, 334, '1962-01-13', '1998-11-03', '2022-01-31', 'Assistant', '', '9474632561', '', 'ALNPA0457H', '834518925696', 'Suri Seharapara, PO&PS. Suri, Dist. Birbhum 731101.\r\n', 'SBI', '31421195274', 'WB/CAL/13787/578', '100242279330', '43300.00', 'anirbanc', '2021-02-25 09:19:45', 'A', NULL, 'anirbanc', '2021-02-25 10:23:37'),
(303, 'MANASA RAM PAUL', 2, 331, '1963-01-03', '1998-11-03', '2023-01-31', 'Assistant', '', '9476179691', '', 'BNPPP5419R', '905512760423', 'Vill. Kurchi, PO.Udayanarayanpur, Dist. Howrah\r\n', 'SBI', '20068025723', 'WB/CAL/13787/626', '100241738161', '37400.00', 'anirbanc', '2021-02-25 09:44:05', 'A', NULL, 'anirbanc', '2021-02-25 10:23:54'),
(305, 'NANDA DULAL BANERJEE', 2, 338, '1967-04-25', '1998-10-03', '2027-04-30', 'Group-D', '', '3213230316', '', 'BHPPB2261K', '616595947985', '\"Vill.&PO.Hanral, Via.Pandua,PS.Dadpur, \r\nDist.Hooghly:712149\"\r\n', 'SBI', '20073251053', 'WB/CAL/13787/587', '100258965849', '33400.00', 'anirbanc', '2021-02-25 03:15:34', 'A', NULL, NULL, NULL),
(306, 'SUBHASISH ROY', 2, 343, '1966-12-27', '1998-09-03', '2026-12-31', 'JR.ENG.', '', '9163495489', '', '', '275224973132', '14B, Rahim Ostagar Road, Kolkata-700 045\r\n', 'SBI', '31775012855', 'WB/CAL/13787/622', '100384783309', '48100.00', 'anirbanc', '2021-02-26 08:31:41', 'A', NULL, NULL, NULL),
(307, 'SANTI NATH HAZRA', 2, 345, '1966-03-02', '1998-12-03', '2026-03-31', 'Sr. Assistant', '', '9733604590', '', 'AFPPH2778N', '257347005811', 'Vill.Akna, PO.Sonagachi, Dist. Howrah-711226.\r\n', 'SBI', '31498148892', 'WB/CAL/13787/630', '100379598699', '43300.00', 'anirbanc', '2021-02-26 06:32:40', 'A', NULL, NULL, NULL),
(308, 'DEBABRATA BHATTACHARJEE', 2, 342, '1965-12-30', '1998-10-03', '2025-12-31', 'Group-D', 'Marketing', '9836088038', '', '', '648838593737', '\"159, Subhasnagar Bye Lane, Dum Dum Cant. \r\nKolkata-700 065.\"\r\n', 'SBI', '31403644096', 'WB/CAL/13787/593', '100142465989', '33400.00', 'anirbanc', '2021-02-25 06:04:10', 'A', NULL, 'anirbanc', '2021-02-25 10:25:34'),
(310, 'NATARAJ MUKHERJEE', 2, 335, '1965-01-30', '1998-12-03', '2025-01-31', 'Assistant', '', '9433309350', '', 'BGJPM6163J', '843733393771', 'Baromitra Para, Kalna, Burdwan\r\n', 'SBI', '31433583524', 'WB/CAL/13787/612', '100259375426', '43300.00', 'anirbanc', '2021-02-25 03:22:56', 'A', NULL, NULL, NULL),
(311, 'AJAY KUMAR NAG', 2, 344, '1963-06-05', '1998-10-03', '2023-06-30', 'Group-D', '', '8016996071', '', 'AIBPN6137E', '0', 'Vill.&PO Nabagram,Dist. Burdwan-713166.\r\n', 'SBI', '20072906476', 'WB/CAL/13787/575', '100098146191', '33400.00', 'anirbanc', '2021-02-25 04:10:53', 'A', NULL, 'anirbanc', '2021-02-25 10:26:51'),
(314, 'PRABIR KUMAR DUTTA II', 2, 339, '1967-10-01', '1998-10-03', '2027-09-30', 'Assistant', '', '9434492035', '', 'AQXPD4054A', '241294657251', 'Vill. & PO. Seharabazar, PS.Raina, Dist. Burdwan 713423\r\n', 'SBI', '31433539733', 'WB/CAL/13787/619', '100284890118', '39700.00', 'anirbanc', '2021-02-25 04:17:16', 'A', NULL, NULL, NULL),
(318, 'DIPAK KUMAR PAL', 2, 333, '1970-01-22', '1998-01-22', '2030-01-31', 'Assistant', '', '8926424486', '', 'BCIPP6913N', '854603593415', '\"Vill.&PO: Kinkarbati, PS: Haripal, \r\nDist. Hooghly-712407\"\r\n', 'SBI', '31433510872', 'WB/CAL/13787/597', '100143871494', '39700.00', 'anirbanc', '2021-02-25 06:51:24', 'A', NULL, 'anirbanc', '2021-02-25 10:28:42'),
(320, 'MD. SALAMAT HOSSAIN', 2, 332, '1962-10-04', '1998-10-03', '2022-10-31', 'Assistant', '', '9475903124', '', 'AIWPH2796J', '843799764460', 'Vill. New Krishnapur, PO. Dhuliyan, Dist. Murshidabad-742202\r\n', 'SBI', '31499064748', 'WB/CAL/13787/606', '100378421474', '39700.00', 'anirbanc', '2021-02-26 05:35:24', 'A', NULL, NULL, NULL),
(321, 'BASUDEB BANERJEE', 2, 333, '1971-06-13', '1998-11-03', '2031-06-30', 'Group-D', '', '9734334833', '', 'AZWPB8412E', '863790898842', '\"Vill. Chalkia Berhampur, \r\nDist. Murshidabad-742101.\"\r\n', 'SBI', '31418788134', 'WB/CAL/13787/656', '100118912355', '33400.00', 'anirbanc', '2021-02-25 04:45:37', 'A', NULL, 'anirbanc', '2021-02-25 10:30:12'),
(322, 'ASHOKE BANERJEE', 2, 335, '1962-03-26', '1998-11-03', '2022-03-31', 'Assistant', '', '9679713452', '', 'AZFPB0401L', '760334213183', '\"Sukantapally, Kanla Gate(East), PO: Burdwan, \r\nDist. Burdwan-713101.\"\r\n', 'SBI', '31421193731', 'WB/CAL/13787/611', '100101209143', '37400.00', 'anirbanc', '2021-02-25 04:38:43', 'A', NULL, 'anirbanc', '2021-02-25 10:31:19'),
(323, 'TUSHAR KANTI MONDAL', 2, 344, '1970-04-21', '1998-03-17', '2030-04-30', 'Assistant', '', '9647492005', '', 'BGEPM0486K', '694725859051', 'Vill.Salbagan, PO.Bishnupur, Dist.Bankura-722122\r\n', 'SBI', '20072906556', 'WB/CAL/13787/592', '100393717638', '43299.00', 'anirbanc', '2021-02-27 11:00:01', 'A', NULL, NULL, NULL),
(324, 'JATADHARI GHOSH', 2, 337, '1969-09-03', '1998-09-03', '2029-09-30', 'Group-D', '', '9874563470', '', 'AVUPG0343D', '710721681075', 'Vill.&PO.Tenya, PS.Salar, Dist. Murshidabad 742404.\r\n', 'SBI', '31424907675', 'WB/CAL/13787/591', '100179864756', '33400.00', 'anirbanc', '2021-02-25 07:55:15', 'A', NULL, 'anirbanc', '2021-02-25 10:31:34'),
(325, 'SUHAS RANJAN SEN', 2, 339, '1964-11-12', '1998-11-03', '2024-11-30', 'Sr. Assistant', '', '9474388139', '', 'CGGPS4111J', '316129796971', 'Vill. Nandanpur, PO.Uchalan, Dist. Burdwan-713427\r\n', 'SBI', '31424769054', 'WB/CAL/13787/603', '100385152091', '43300.00', 'anirbanc', '2021-02-26 09:07:05', 'A', NULL, NULL, NULL),
(331, 'ATANU CHANDA', 2, 342, '1963-12-04', '1998-10-03', '2023-12-31', 'Assistant', 'CASH', '8145502032', '', 'ARBPC9607R', '286129163558', 'Vill.&P.O.Jamalpur, Dist. Burdwan-713408\r\n', 'SBI', '20073250934', 'WB/CAL/13787/608', '100101398996', '39700.00', 'anirbanc', '2021-02-25 04:41:54', 'A', NULL, 'anirbanc', '2021-02-25 10:32:30'),
(334, 'MOTILAL GOSWAMI', 2, 344, '1969-11-08', '1998-10-03', '2029-11-30', 'Group-D', '', '9051557521', '', 'AXGPG7519K', '985526014009', '1No.Bangasree Pally, \r\n', 'SBI', '20072906512', 'WB/CAL/13787/574', '100243110413', '31500.00', 'anirbanc', '2021-02-25 11:41:59', 'A', NULL, NULL, NULL),
(335, 'SUBHAYU MAJUMDAR', 2, 338, '1964-01-29', '1998-10-03', '2024-01-31', 'Assistant', '', '8420681164', '', 'AUAPM4418L', '792628214337', 'Nabapally(near State Bank), Natunbazar, PO & PS. Singur, Dist.Hooghly-712409\r\n', 'SBI', '20073251279', 'WB/CAL/13787/588', '100384785099', '38500.00', 'anirbanc', '2021-02-26 08:37:38', 'A', NULL, NULL, NULL),
(337, 'SIBNATH CHAKRABORTY', 2, 342, '1963-12-22', '1998-12-03', '2023-12-31', 'Assistant', 'ACCOUNTS', '9830664103', '', 'APEPC8325H', '364915293661', 'Vill.Baidyakhali, PO.Burul, PS.Falta, Dist.24-Parganas(N)-743318.\r\n', 'SBI', '31382165070', 'WB/CAL/13787/634', '100383225003', '38500.00', 'anirbanc', '2021-02-26 07:54:50', 'A', NULL, NULL, NULL),
(339, 'BIJAN KUMAR PAL', 2, 342, '1968-12-25', '1998-03-11', '2028-12-31', 'Sr. Assistant', 'Personnel', '9153114845', '', 'BKNPP1532P', '787073456725', '\"Vill. & P.O.Keshabchak, PS:Tarakeswar,\r\n Dist. Hooghly-712410\"\r\n', 'SBI', '20073251031', 'WB/CAL/13787/584', '100119611533', '43300.00', 'anirbanc', '2021-02-25 05:40:26', 'A', NULL, 'anirbanc', '2021-02-25 10:33:39'),
(342, 'MRITUNJOY PURKAIT', 2, 342, '1970-01-02', '1998-10-03', '0000-00-00', 'Group-D', 'PERSONNEL', '9831796845', '', 'BKOPP3964K', '581288272991', '\"79/9,P.Mazumdar, PO.Haltu, PS.Kasba,\r\nKolkata:700 078\"\r\n', 'SBI', '30772266447', 'WB/CAL/13787/629', '100244537989', '33400.00', 'anirbanc', '2021-02-25 03:01:53', 'A', NULL, NULL, NULL),
(344, 'BISWAJIT GANGOPADHYAY', 2, 342, '1969-02-02', '1998-11-03', '2029-02-28', 'Dy.Manager', 'Fertiliser', '9434853571', '', 'AILPG0301K', '399826290314', '\"Vill.Kanaipur,PO: Dakshin Basudebpur, \r\nDist. Hooghly-712301.\"\r\n', 'SBI', '20073250990', 'WB/CAL/13787/586', '100119935690', '63100.00', 'anirbanc', '2021-02-25 05:49:05', 'A', NULL, 'anirbanc', '2021-02-25 10:34:54'),
(347, 'TAPAN KR. MAJILLA', 2, 335, '1965-01-02', '1998-10-03', '2025-01-31', 'Group-D', '', '9474784249', '', 'BGTPM0918D', '', 'Vill.Palsha, PO.Hatgobindapur, PS.Memari, Dist.Burdwan-713407\r\n', 'SBI', '31436526448', 'WB/CAL/13787/572', '100393149970', '33400.00', 'anirbanc', '2021-02-27 10:41:44', 'A', NULL, NULL, NULL),
(348, 'TAPAS THAKUR', 2, 337, '1964-04-03', '1998-10-03', '2024-04-30', 'Assistant', '', '9474366094', '', 'AKWPT2384C', '352817269572', 'Chotonilpur, Kamala Dighir-Par, PO.Sreepally, Dist.Burdwan-713103\r\n', 'SBI', '31424907563', 'WB/CAL/13787/609', '100393175432', '39700.00', 'anirbanc', '2021-02-27 10:52:39', 'A', NULL, NULL, NULL),
(349, 'MD. AKSAM ALI MONDAL', 2, 335, '1964-09-16', '1998-10-03', '2024-09-30', 'Assistant', '', '9093829648', '', 'BGZPM4477K', '579525457865', 'Bahir Sarbamangola Para, PO & Dist. Burdwan 713101\r\n', 'SBI', '31294044270', 'WB/CAL/13787/571', '100098267939', '39700.00', 'anirbanc', '2021-02-25 11:26:03', 'A', NULL, NULL, NULL),
(350, 'RAMESH SINGH', 2, 342, '1966-07-08', '1998-10-03', '2026-07-31', 'Group-D', 'Personnel', '9748838734', '', 'DBIPS9353G', '512475204258', '8/2, Gopi Sen Lane, PO. Hatkhola, Sovabazar, Kolkata-700 005.\r\n', 'SBI', '31464879989', 'WB/CAL/13787/637', '100319432510', '33400.00', 'anirbanc', '2021-02-26 05:17:09', 'A', NULL, NULL, NULL),
(352, 'MD. FARUQUE HOSSAIN', 2, 328, '1996-11-05', '1998-10-03', '2026-11-30', 'Group-D', '', '9093361971', '', 'AGHPH3054Q', '461559044621', 'Shanti Para, PO.Bhaktinagar, Dist. Jalpaiguri.\r\n', 'SBI', '31410825595', 'WB/CAL/13787/639', '100146760063', '33400.00', 'anirbanc', '2021-02-25 11:31:22', 'A', NULL, NULL, NULL),
(353, 'RAMU YADAV', 2, 332, '1965-08-02', '1998-03-16', '2025-08-31', 'Group-D', '', '9051985598', '', 'AFJPY7522F', '606386649840', '1582, Rajdanga Main Road, PS.Kasba, Kolkata-700 107\r\n', 'SBI', '20065032664', 'WB/CAL/13787/594', '100319603223', '32400.00', 'anirbanc', '2021-02-26 05:20:47', 'A', NULL, NULL, NULL),
(354, 'KANCHAN SENGUPTA', 2, 343, '1962-02-07', '1998-10-03', '2022-02-28', 'Assistant', '', '9432989740', '', 'CVYPS5887G', '205173157627', '\"167, Harendra Nath Mukherjee Road, \r\nNew Barrackpore BT College,Kolkata-700 131.\"\r\n', 'SBI', '31382163946', 'WB/CAL/13787/563', '100199858817', '38500.00', 'anirbanc', '2021-02-25 08:53:26', 'A', NULL, 'anirbanc', '2021-02-25 10:35:15'),
(355, 'SK. HABIB', 2, 338, '1962-07-06', '1998-09-03', '2022-07-31', 'Group-D', '', '8927188967', '', 'AGGPH4897N', '279893176036', 'Vill.Bagbari, PO.Baliguri, PS.Tarakeswar, Dist. Hooghly-712410\r\n', 'SBI', '20073251133', 'WB/CAL/13787/585', '100383570736', '32400.00', 'anirbanc', '2021-02-26 08:07:41', 'A', NULL, NULL, NULL),
(356, 'MD. ABUL HASSEM', 2, 343, '1967-03-13', '1998-09-03', '2027-03-31', 'Group-D', '', '9775158423', '', 'AGHPH4396K', '732878588472', '\"Vill.&PO.Uttar Kusum Majerhat Para, PS.Usthi, \r\nDist.South 24-Parganas 743375\"\r\n', 'SBI', '31403661689', 'WB/CAL/13787/654', '100097672290', '33400.00', 'anirbanc', '2021-02-25 11:19:19', 'A', NULL, NULL, NULL),
(357, 'NABA KUMAR MONDAL', 2, 342, '1962-04-06', '1998-03-09', '2022-06-30', 'Group-D', 'PERSONNEL', '8116989512', '', '', '387060689557', '\"Vill. Ratna, PO.Hotor, PS.Magrahat, \r\nDist. South 24-Pgns.\"\r\n', 'SBI', '31403991232', 'WB/CAL/13787/653', '100258614374', '33400.00', 'anirbanc', '2021-02-25 03:08:53', 'A', NULL, 'anirbanc', '2021-02-25 03:09:40'),
(359, 'TAPAN KR. KARFA', 2, 334, '1963-07-28', '1998-03-16', '2023-07-31', 'Assistant', '', '8016245614', '', 'BWAPK7011A', '873333787090', 'Vill.Nerodighi More, PO.Baje Pratappure, Dist. Burdwan\r\n', 'SBI', '31382286313', 'WB/CAL/13787/652', '100393149621', '38500.00', 'anirbanc', '2021-02-27 10:37:25', 'A', NULL, NULL, NULL),
(360, 'SUNIL KR. SAMANTA', 2, 341, '1966-10-07', '0998-01-31', '2026-10-31', 'Assistant', '', '9733762011', '', 'CYXPS0430H', '487647602028', 'Vill. Uttar Harishpur, PO.Pancharul, PS.Udayanarayanpur, Dist.Howrah-711225.\r\n', 'SBI', '31498052064', 'WB/CAL/13787/579', '100385776038', '43300.00', 'anirbanc', '2021-02-26 09:35:12', 'A', NULL, NULL, NULL),
(362, 'BHOLA NATH KHAMARU', 2, 337, '1966-10-08', '1998-10-03', '2026-10-31', 'Group-D', '', '9933117146', '', 'BSTPK9849P', '527667422206', '\"Vill.&PO:Porbazar,PS Dhaniakhali,\r\nDist.Hooghly.\"\r\n', 'SBI', '31445593550', 'WB/CAL/13787/617', '100119437019', '33400.00', 'anirbanc', '2021-02-25 05:00:21', 'A', NULL, 'anirbanc', '2021-02-25 10:36:25'),
(363, 'MD. MAHADEB SARDAR', 2, 331, '1977-08-05', '1997-09-17', '2037-08-31', 'Group-D', '', '9434857070', '', '', '793389817969', '\"Bishnupur Kalibari, PO.Cossimbazar, PS. Berhampur, \r\nDist.Murshidabad\"\r\n', 'SBI', '31418786272', 'WB/CAL/13787/669', '100240283939', '33400.00', 'anirbanc', '2021-02-25 09:27:36', 'A', NULL, 'anirbanc', '2021-02-25 10:36:47'),
(364, 'SMT.TAPASI DASGUPTA', 2, 342, '1963-12-31', '1997-03-12', '2023-12-31', 'Sr. Assistant', 'Personnel', '7231183592', '', 'AWVPD7753N', '450118561255', '1714, Vidyasagar Sarani, Ground Floor, Barabagan, Kolkata-700 063\r\n', 'SBI', '20065033340', 'WB/CAL/13787/660', '100393178499', '48700.00', 'anirbanc', '2021-02-27 10:56:18', 'A', NULL, 'anirbanc', '2021-03-01 05:58:03'),
(366, 'SUSANTA MONDAL', 2, 327, '1963-11-01', '1998-10-03', '2023-10-31', 'Sr. Assistant', '', '9434041298', '', 'BGQPM4622P', '435737313401', '249/B, Deshbandhu Nagar Colony, PO. Jalpaiguri-735101\r\n', 'SBI', '31499064680', 'WB/CAL/13787/640', '100386507277', '44600.00', 'anirbanc', '2021-02-27 10:18:20', 'A', NULL, NULL, NULL),
(367, 'JAYANTA BASU', 2, 328, '1968-03-25', '1998-12-02', '2028-03-31', 'Assistant', '', '9434112374', '', 'ARGPB9565Q', '976895648882', '\"2 No.R R School More, Arabinda Nagar (W), \r\nJalpaiguri 735101\"\r\n', 'SBI', '31294055351', 'WB/CAL/13787/599', '100180008576', '43300.00', 'anirbanc', '2021-02-25 08:03:52', 'A', NULL, 'anirbanc', '2021-02-25 10:37:02'),
(368, 'DEBASISH CHATTERJEE', 2, 332, '1966-12-01', '1998-09-03', '2026-11-30', 'Assistant', '', '9153074145', '', 'APAPC8394Q', '941266946149', '\"PO Mathurapur (Subash Sarani), PS: Manikchak, \r\nDist. Malda-732203\"\r\n', 'SBI', '31380083039', 'WB/CAL/13787/647', '100142505935', '39700.00', 'anirbanc', '2021-02-25 06:18:23', 'A', NULL, 'anirbanc', '2021-02-25 10:38:17'),
(369, 'SMT. DEBARATI SEN', 2, 342, '1978-03-15', '1998-01-09', '2038-03-31', 'Sr. Assistant', 'Fertiliser', '9903218844', '', 'CWUPS2829D', '463939411073', '1/3, M Nil Moni Mitra Row, Kolkata-700 002.\r\n', 'SBI', '20065032733', 'WB/CAL/13787/661', '100142486106', '47300.00', 'anirbanc', '2021-02-25 06:14:28', 'A', NULL, 'anirbanc', '2021-03-01 05:09:06'),
(370, 'SUBHANU GHOSH', 2, 345, '1973-01-04', '1998-11-15', '2033-01-31', 'Dy.Manager', '', '9433071104', '', 'AKAPG7818G', '334356175472', '75, Ghoshpara Lane, PO. Makhla, Dist.Hooghly-712245\r\n', 'SBI', '20065033124', 'WB/CAL/13787/662', '100384704405', '63100.00', 'anirbanc', '2021-02-26 08:20:50', 'A', NULL, NULL, NULL),
(371, 'SURAJ GEJMIR', 2, 327, '1975-01-06', '2000-03-11', '2035-01-31', 'Assistant', '', '9932188320', '', 'AVQPG9849J', '424428270231', 'Premarati Kutir, Ashoke Nagar, PO.Siliguri Bazar, Pin-734005\r\n', 'SBI', '31380083040', 'WB/CAL/13787/664', '100386438396', '40800.00', 'anirbanc', '2021-02-27 10:08:44', 'A', NULL, NULL, NULL),
(373, 'RUPAK DAS', 2, 345, '1972-12-08', '2007-04-04', '2032-12-31', 'BRANCH ACCOUNTANT', '', '9593670301', '', 'BAMPD0751L', '', '42, Progati Granthagar Road, Ismile, Asansol, PO.Asansol,Dist.Burdwan-713301\r\n', 'SBI', '31424769032', 'WB/CAL/13787/666', '100321155207', '44600.00', 'anirbanc', '2021-02-26 05:24:28', 'A', NULL, NULL, NULL),
(374, 'PANKAJ KUMAR DAS', 2, 342, '1972-01-08', '2007-04-16', '2032-01-31', 'Dy.Manager (A/cs)', 'ACCOUNTS', '8584046483', '', 'AQTPD0468Q', '596715936378', '8/7/C PURBACHAL KALITALA LINK RD.  P.O. HALTU, KOLKATA- 700078\r\n', 'SBI', '30749282082', 'WB/CAL/13787/668', '100283809368', '71100.00', 'anirbanc', '2021-02-25 03:34:53', 'A', NULL, NULL, NULL),
(375, 'MD. AJAJUL SAIKH', 2, 332, '1969-08-31', '2007-05-12', '2029-08-31', 'Group-D', '', '7501130340', '', 'CXMPS2607E', '0', 'MAHESMATI, PO & DIST. MALDA-732101', 'SBI', '31294057788', 'WB/CAL/13787/670', '100097858618', '28000.00', 'anirbanc', '2021-02-25 03:47:34', 'A', NULL, 'anirbanc', '2021-02-25 10:40:29'),
(376, 'SUNIL CHANDRA SARKAR', 2, 329, '1974-08-01', '2010-06-09', '2034-07-31', 'BRANCH ACCOUNTANT', '', '9734111733', '', 'EFNPS9146M', '941822213442', 'Vill. Bara Krishnapur, PO.Shib Krishnapur, Dist. Dk.Dinajpur-733132\r\n', 'SBI', '31581876144', 'WB/CAL/13787/675', '100385666448', '40800.00', 'anirbanc', '2021-02-26 09:27:23', 'A', NULL, NULL, NULL),
(377, 'HIRALAL PIRI', 2, 335, '1978-08-19', '2010-08-09', '2038-08-31', 'BRANCH ACCOUNTANT', '', '9734405674', '', '', '229353385389', '\"Vill. & PO: Ramjibanpur, PS: Chandrakona,\r\n Ward No.6, \"\r\n', 'SBI', '31480809807', 'WB/CAL/13787/676', '100166307633', '40800.00', 'anirbanc', '2021-02-25 07:35:10', 'A', NULL, 'anirbanc', '2021-02-25 10:41:52'),
(378, 'SAUMEN KUNDU', 2, 333, '1970-02-01', '2010-10-09', '2030-01-31', 'BRANCH ACCOUNTANT', '', '9732978917', '', 'AJXPK6513E', '759912588412', 'Vill.Keshabnagar, PO.Cossimbazar Raj, Murshidabad-742101\r\n', 'SBI', '31656164394', 'WB/CAL/13787/674', '100384044319', '40800.00', 'anirbanc', '2021-02-26 06:49:34', 'A', NULL, NULL, NULL),
(382, 'SHUBHASHISH BISWAS', 2, 336, '1984-02-27', '2012-09-03', '2044-02-28', 'Dy.Manager', '', '9735424893', '', 'BDMPB6982J', '756944529152', 'Vill.Chitrqngapur, PO.Ambikapur, Dist. North 24-Parganas-743251\r\n', 'SBI', '32252589374', 'WB/CAL/13787/687', '100383068300', '63100.00', 'anirbanc', '2021-02-26 07:05:53', 'A', NULL, NULL, NULL),
(385, 'MRIDUL MONDAL', 2, 328, '1984-12-12', '2012-12-03', '0000-00-00', 'Dy.Manager', '', '9038531526', '', 'BAAPM2511F', '858485009847', 'B-8/39 (C.A.) Kalyani, Nadia 741235\r\n', 'SBI', '32241029074', 'WB/CAL/13787/692', '100244516125', '63100.00', 'anirbanc', '2021-02-25 02:55:25', 'A', NULL, NULL, NULL),
(388, 'KALYAN BISWAS', 2, 339, '1986-11-22', '2012-06-03', '2046-11-30', 'Dy.Manager', '', '9735283153', '', 'BGXPB1503K', '967600492377', '\"Vill. Saltia, PO & PS Habra,\r\n Dist.North 24-Parganas 743263\"\r\n', 'SBI', '32242253630', 'WB/CAL/13787/683', '100199614985', '63100.00', 'anirbanc', '2021-02-25 08:41:57', 'A', NULL, 'anirbanc', '2021-02-25 10:42:04'),
(389, 'SOMNATH KOTAL', 2, 338, '1984-05-07', '2012-03-15', '2044-05-31', 'Dy.Manager (A/cs)', '', '8584033810', '', 'CVWPK2526A', '568401966462', 'Vill.Jangipara, PO & PS. Jangipara, Dist. Hooghly-712404\r\n', 'SBI', '32249058428', 'WB/CAL/13787/680', '100383873615', '63100.00', 'anirbanc', '2021-02-26 08:16:27', 'A', NULL, NULL, NULL),
(392, 'PIJUSH KANTI PATRA', 2, 341, '1989-01-28', '2012-12-03', '2049-01-31', 'Branch Accountant', '', '9038368548', '', 'BWTPP5947F', '586793762201', 'Vill.Belley, PO.Kushdanga, PS.Jagaddal, Dist. 24-Pgns(N) 743126\r\n', 'SBI', '32249056033', 'WB/CAL/13787/690', '100284537370', '38400.00', 'anirbanc', '2021-02-25 04:01:06', 'A', NULL, NULL, NULL),
(394, 'ESHAN MONDAL', 2, 342, '1987-05-17', '2012-05-03', '2047-05-31', 'Dy.Manager (A/cs)', 'ACCOUNTS', '8902043845', '', 'ASKPM0789N', '602134047126', '\"138/3/6, Benaras Road, Salkia, \r\nHowrah-711106\"\r\n', 'SBI', '32241989068', 'WB/CAL/13787/677', '100145717018', '67000.00', 'anirbanc', '2021-02-25 06:55:05', 'A', NULL, 'anirbanc', '2021-02-25 10:43:28'),
(400, 'Abirlal Bhuiya', 2, 338, '1985-11-02', '2012-04-18', '2045-11-30', 'BRANCH ACCOUNTANT', '', '9038616195', '', 'BHRPB9213P', '525140050367', '\"Sreenagar, PO Birati, PS Nimta,\r\n Dist. 24-Parganas(N) 700051.\"\r\n', 'SBI', '32323731493', 'WB/CAL/13787/695', '100097655734', '38400.00', 'anirbanc', '2021-02-25 03:22:29', 'A', NULL, 'anirbanc', '2021-02-25 10:44:59'),
(405, 'SUROJIT NASKAR', 2, 332, '1984-04-06', '2013-07-01', '2044-04-30', 'Branch Accountant', '', '9830990148', '', 'AQOPN7870M', '887969395187', '16, Sisir Bagan Road, Behala, Kolkata-700 034\r\n', 'SBI', '32778558951', 'WB/CAL/13787/702', '100386058122', '38400.00', 'anirbanc', '2021-02-27 10:13:05', 'A', NULL, 'anirbanc', '2021-02-27 10:19:33'),
(406, 'SMT.SUSMITA NATH', 2, 343, '1982-09-20', '2013-01-02', '2042-09-30', 'Dy.Manager', '', '9874086442', '', 'AMDPN4157G', '', 'Saheed Binoy Sarani, Durganagar(North), PO.Rabindranagar, PS.Nimtala, Kol-65\r\n', 'SBI', '31601138368', 'WB/CAL/13787/703', '100386632970', '63100.00', 'anirbanc', '2021-02-27 10:24:33', 'A', NULL, NULL, NULL),
(412, 'PRASAD MONDAL', 2, 330, '1987-02-17', '2013-09-23', '2047-02-28', 'Dy.Manager', '', '9477474145', '', 'BTUPM8222Q', '419651852091', 'Vill. & PO. Radharghat (Ghoshpara)PS.Berhampur, Dist. Murshidabad :742187\r\n', 'SBI', '20008904157', 'WB/CAL/13787/710', '100285488544', '63100.00', 'anirbanc', '2021-02-25 03:42:41', 'A', NULL, NULL, NULL),
(413, 'ISHAN BANIK', 2, 332, '1987-12-14', '2013-09-20', '2047-12-31', 'Dy.Manager', '', '9038461048', '', 'BRUPB5099G', '841151172078', 'P-8, Milan Park, Garia, Kolkata :700084\r\n', 'SBI', '33316454793', 'WB/CAL/13787/709', '100168543301', '63100.00', 'anirbanc', '2021-02-25 07:39:57', 'A', NULL, 'anirbanc', '2021-02-25 10:45:13'),
(414, 'SMT. APARAJITA SAMNTA', 2, 344, '1985-06-06', '2014-01-31', '2045-06-30', 'BRANCH ACCOUNTANT', '', '', '', 'FPYPS6818Q', '442860280407', '\"Vill.AT-Padumbasan (Opp. ICICI Bank) P.O. Tamluk, \r\nDist. Purba Medinipur,721636\"\r\n', 'SBI', '33662506474', 'WB/CAL/13787/711', '100022449589', '37300.00', 'anirbanc', '2021-02-25 04:27:05', 'A', NULL, 'anirbanc', '2021-02-25 10:46:08'),
(418, 'SMT. SABITA BISWAS', 2, 337, '1988-03-07', '2016-09-03', '2048-03-31', 'Asstt.Manager', '', '', '', '', '0', 'Vill Kathalia, P.O. Nandanpur, P.S. Karimpur, Dist. Nadia 741165\r\n', 'SBI', '35633755839', 'WB/CAL/13787/714', '', '41500.00', 'anirbanc', '2021-02-26 05:31:12', 'A', NULL, 'anirbanc', '2021-02-26 05:36:02'),
(419, 'MARSHAL SENGEL BASKEY', 2, 331, '1986-02-24', '2016-09-03', '2046-02-28', 'Asstt.Manager', '', '9674746940', '', '', '0', '\"HARISAVATALA, DAKSHIN NAWABAZ, GIP COLONY, \r\nHOWRAH-711112 \"\r\n', 'SBI', '30435657470', 'WB/CAL/13787/715', '', '41500.00', 'anirbanc', '2021-02-25 09:51:19', 'A', NULL, 'anirbanc', '2021-02-25 10:46:37'),
(420, 'SUBHRO DAS', 2, 333, '1984-08-23', '2016-01-04', '2044-08-31', 'Asstt.Manager', '', '', '', '', '', '155/6,Monosha Row, P.O. Garden Reach, P.S.Metiabruz, Kolkata : 700 024\r\n', 'SBI', '33416373727', '', '', '41500.00', 'anirbanc', '2021-02-26 08:43:15', 'A', NULL, NULL, NULL),
(421, 'DIPAK BARUA', 2, 331, '1989-04-17', '2017-01-09', '2049-04-30', 'BRANCH ACCOUNTANT', '', '', '', '', '0', '\"Nangi Chakraborty Para. PO.Batanagar,\r\nPS.Mahestala, Kol.700140\"\r\n', 'SBI', '34488000138', 'WB/CAL/13787/717', '', '36200.00', 'anirbanc', '2021-02-25 06:31:03', 'A', NULL, 'anirbanc', '2021-02-25 10:47:14'),
(423, 'KALYAN NASKAR', 2, 330, '1990-06-30', '2017-09-01', '2050-06-30', 'BRANCH ACCOUNTANT', '', '', '', '', '0', '\"Vill. Mahadebapur (Jalkal) P.O. Maheshtala,\r\n Dist. South 24-Pgns. 700140\"\r\n', 'SBI', '36488410630', 'WB/CAL/13787/719', '', '36200.00', 'anirbanc', '2021-02-25 08:47:05', 'A', NULL, 'anirbanc', '2021-02-25 10:48:23'),
(424, 'ANIRBAN CHAKRABORTY', 2, 342, '1979-01-14', '2017-02-27', '2039-01-31', 'MANAGER (AUDIT & ACCOUTS)', 'ACCOUNTS', '9674746908', '', ' AMVPC6853C', ' ', ' 38/A Kali Temple Road\r\nKalighat, Kolkata-700026', 'SBI', '20387113606', 'WB/CAL/13787/720', '101032285425', '75700.00', 'anirbanc', '2021-02-25 04:24:02', 'A', NULL, 'anirbanc', '2021-03-02 06:29:15'),
(1008, 'BHOLANATH MONDAL', 1, 342, '0000-00-00', '0000-00-00', '0000-00-00', 'MANAGER [MARKETING]', 'MARKETING', '', '', '', '', '', 'SBI', '11850726511', '', '', '85200.00', 'anirbanc', '2021-02-27 11:24:40', 'A', NULL, NULL, NULL),
(1013, 'SUMAN DAS GUPTA', 1, 342, '0000-00-00', '0000-00-00', '0000-00-00', 'DY.MANAGER [PERS]', 'PERSONNEL', '', '', '', '', '', 'SBI', '31830762827', '', '', '70000.00', 'anirbanc', '2021-02-27 11:28:58', 'A', NULL, NULL, NULL),
(1014, 'MANAB BANERJEE', 1, 342, '0000-00-00', '0000-00-00', '0000-00-00', 'MANAGER [FERT & INPUTS]', 'FERTILISER & INPUTS', '', '', '', '', '', 'SBI', '20108559219', '', '', '80300.00', 'anirbanc', '2021-02-27 11:27:02', 'A', NULL, NULL, NULL),
(1015, 'LAKSHMAN BANIK', 1, 342, '0000-00-00', '0000-00-00', '0000-00-00', 'GENERAL MANAGER[ADMN]', 'PERSONNEL', '9674746922', '', '', '', '', 'SBI', '33306029269', '', '', '126800.00', 'anirbanc', '2021-02-27 11:20:52', 'A', NULL, NULL, NULL),
(1016, 'DEBANGSHU BANERJEE', 1, 342, '0000-00-00', '0000-00-00', '0000-00-00', 'CA&AO', 'ACCOUNTS', '', '', '', '', '', 'SBI', '20064962862', '', '', '110200.00', 'anirbanc', '2021-02-27 11:22:46', 'A', NULL, NULL, NULL),
(2432, 'SMT. LAXMI MURMU', 2, 336, '1963-05-06', '1995-04-08', '2023-05-31', 'Group-D', '', '8348739471', '', 'BKXPM6765N', '645472195089', 'Vill.Palpara Netajinagar, PO & PS. Chakdah, Dist. Nadia\r\n', 'SBI', '31445593538', 'WB/CAL/13787/518', '100207354891', '35400.00', 'anirbanc', '2021-02-25 09:14:56', 'R', NULL, 'sss', '2022-08-30 02:53:44');

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
('sss', '$2y$10$.hGN2NZbdZxhvY6t4f7Xp.izntLjFMXhKAY1rIBaShZUbMdmH1KvG', 'A', 'synergic', 'A', '341', 0, 'Synergic Softek', NULL, NULL, NULL),
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
(66, '2022-09-16 12:15:36', 'sss', '127.0.0.1', NULL);

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
(174, '0000-00-00', 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'sss', '2022-08-30 02:43:03', NULL, NULL),
(389, '0000-00-00', 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'anirbanc', '2021-04-02 06:13:13', NULL, NULL),
(394, '0000-00-00', 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'anirbanc', '2021-03-09 07:28:01', 'anirbanc', '2021-04-02 06:10:19'),
(424, '0000-00-00', 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'anirbanc', '2021-03-09 07:21:45', 'anirbanc', '2021-04-02 06:11:27');

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
(1008, '2022-09-16', 1, 85200.00, 31371.00, 13973.00, 4000.00, 600.00, 5145.00, 221.00, 196.00, 100.00, 140806.00, 0.00, 140806.00, 'sss', '2022-09-16 10:03:29', 'sss', '2022-09-16 12:51:10'),
(1013, '2022-09-16', 1, 70000.00, 25774.00, 11480.00, 4000.00, 600.00, 4227.00, 221.00, 196.00, 0.00, 116498.00, 0.00, 116498.00, 'sss', '2022-09-16 10:03:29', 'sss', '2022-09-16 12:51:10'),
(1014, '2022-09-16', 1, 80300.00, 29566.00, 13169.00, 4000.00, 600.00, 4849.00, 221.00, 196.00, 0.00, 132901.00, 0.00, 132901.00, 'sss', '2022-09-16 10:03:29', 'sss', '2022-09-16 12:51:10'),
(1015, '2022-09-16', 1, 126800.00, 46688.00, 20795.00, 4000.00, 600.00, 7657.00, 221.00, 196.00, 0.00, 206957.00, 0.00, 206957.00, 'sss', '2022-09-16 10:03:29', 'sss', '2022-09-16 12:51:10'),
(1016, '2022-09-16', 1, 110200.00, 40576.00, 18073.00, 4000.00, 600.00, 6654.00, 221.00, 196.00, 0.00, 180520.00, 0.00, 180520.00, 'sss', '2022-09-16 10:03:30', 'sss', '2022-09-16 12:51:10');

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
  `emp_no` int(11) NOT NULL,
  `basic_pay` decimal(10,2) NOT NULL,
  `da_amt` decimal(10,2) NOT NULL,
  `hra_amt` decimal(10,2) NOT NULL,
  `med_allow` decimal(10,2) NOT NULL DEFAULT 0.00,
  `othr_allow` decimal(10,2) NOT NULL,
  `insuarance` decimal(10,2) NOT NULL,
  `ccs` decimal(10,2) NOT NULL,
  `hbl` decimal(10,2) NOT NULL,
  `telephone` decimal(10,2) NOT NULL,
  `med_adv` decimal(10,2) NOT NULL,
  `festival_adv` decimal(10,2) NOT NULL,
  `tf` decimal(20,2) DEFAULT NULL,
  `med_ins` decimal(20,2) DEFAULT NULL,
  `comp_loan` decimal(20,2) DEFAULT NULL,
  `ptax` decimal(10,2) NOT NULL,
  `itax` decimal(10,2) NOT NULL,
  `gpf` decimal(20,2) NOT NULL,
  `epf` decimal(20,2) NOT NULL,
  `other_deduction` decimal(10,2) NOT NULL,
  `tot_deduction` decimal(20,2) NOT NULL DEFAULT 0.00,
  `net_amount` decimal(10,2) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `approval_status` varchar(5) NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `td_pay_slip`
--

INSERT INTO `td_pay_slip` (`trans_date`, `trans_no`, `sal_month`, `sal_year`, `emp_no`, `basic_pay`, `da_amt`, `hra_amt`, `med_allow`, `othr_allow`, `insuarance`, `ccs`, `hbl`, `telephone`, `med_adv`, `festival_adv`, `tf`, `med_ins`, `comp_loan`, `ptax`, `itax`, `gpf`, `epf`, `other_deduction`, `tot_deduction`, `net_amount`, `remarks`, `approval_status`) VALUES
('2021-04-02', 1, '3', 2021, 0, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 99, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 100, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 101, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 102, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 105, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 163, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 165, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 170, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 174, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 183, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 184, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 187, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 203, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 209, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 213, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 214, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 215, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 234, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 236, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 239, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 240, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2021-04-02', 1, '3', 2021, 242, '35400.00', '1062.00', '4248.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 243, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 249, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 250, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 251, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 252, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 256, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 257, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 260, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 261, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 262, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 264, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 265, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '41210.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 270, '43300.00', '1299.00', '5196.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 271, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 273, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 274, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 275, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 276, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 277, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 278, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 279, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 282, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 283, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 284, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 285, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 286, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 293, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 294, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 297, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 298, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 300, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 303, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 305, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 306, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 307, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 308, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 310, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 311, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 314, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 318, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 320, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 321, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 322, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 323, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 324, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 325, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 331, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 334, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 335, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 337, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 339, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 342, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '50295.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 344, '63100.00', '1893.00', '7572.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 347, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 348, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 349, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 350, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 352, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 353, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 354, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 355, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 356, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 357, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 359, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 360, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 362, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 363, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 364, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 366, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 367, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 368, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 369, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 370, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 371, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 373, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 374, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 375, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 376, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 377, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 378, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 382, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 385, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 388, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 389, '63100.00', '1893.00', '7572.00', '0.00', '0.00', '0.00', '600.00', '0.00', '0.00', '0.00', '1000.00', '0.00', '0.00', '0.00', '200.00', '0.00', '0.00', '7799.00', '0.00', '0.00', '62466.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 392, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 394, '67000.00', '2010.00', '8040.00', '0.00', '0.00', '0.00', '600.00', '0.00', '0.00', '0.00', '1000.00', '0.00', '500.00', '0.00', '200.00', '0.00', '0.00', '8281.00', '0.00', '0.00', '65969.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 400, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 405, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 406, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 412, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 413, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 414, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 418, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 419, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 420, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 421, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 423, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2021-04-02', 1, '3', 2021, 424, '75700.00', '2271.00', '9084.00', '0.00', '0.00', '0.00', '5838.00', '0.00', '0.00', '0.00', '1000.00', '0.00', '500.00', '784.00', '200.00', '33260.00', '0.00', '9357.00', '0.00', '0.00', '35616.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 99, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 100, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 101, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 102, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 105, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 163, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 165, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 170, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 183, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 184, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 187, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 203, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 209, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 213, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 214, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 215, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 234, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 236, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 239, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 240, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 242, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 243, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 249, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 250, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 251, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 252, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 256, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 257, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 260, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 261, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 262, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 264, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 265, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 270, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 271, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 273, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 274, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 275, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 276, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 277, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 278, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 279, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 282, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, 'A'),
('2022-08-31', 1, '4', 2021, 283, '48700.00', '1461.00', '5844.00', '0.00', '1000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 284, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 285, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 286, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 293, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 294, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 297, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 298, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 300, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 303, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 305, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 306, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 307, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 308, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 310, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 311, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 314, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 318, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 320, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 321, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 322, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 323, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 324, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 325, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 331, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 334, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 335, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 337, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 339, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 342, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '57505.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 344, '63100.00', '1893.00', '7572.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 347, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 348, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 349, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 350, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 352, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 353, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 354, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 355, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 356, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 357, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 359, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 360, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 362, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 363, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 364, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 366, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 367, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 368, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 369, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 370, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 371, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 373, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 374, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 375, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 376, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 377, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 378, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 382, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 385, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 388, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 389, '63100.00', '1893.00', '7572.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 392, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '73065.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 394, '67000.00', '2010.00', '8040.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 400, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 405, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A');
INSERT INTO `td_pay_slip` (`trans_date`, `trans_no`, `sal_month`, `sal_year`, `emp_no`, `basic_pay`, `da_amt`, `hra_amt`, `med_allow`, `othr_allow`, `insuarance`, `ccs`, `hbl`, `telephone`, `med_adv`, `festival_adv`, `tf`, `med_ins`, `comp_loan`, `ptax`, `itax`, `gpf`, `epf`, `other_deduction`, `tot_deduction`, `net_amount`, `remarks`, `approval_status`) VALUES
('2022-08-31', 1, '4', 2021, 406, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 412, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 413, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 414, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 418, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 419, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 420, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 421, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 423, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77550.00', NULL, 'A'),
('2022-08-31', 1, '4', 2021, 424, '75700.00', '2271.00', '9084.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '87555.00', NULL, 'A');

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
('2021-04-02', 1, 3, 2021, 2, 'A', 'anirbanc', '2021-04-02 06:13:56', NULL, NULL, NULL, NULL),
('2022-08-31', 1, 4, 2021, 2, 'A', 'sss', '2022-08-31 06:49:46', NULL, NULL, 'sss', '2022-08-31 00:00:00');

--
-- Triggers `td_salary`
--
DELIMITER $$
CREATE TRIGGER `ai_payslip_generate` AFTER INSERT ON `td_salary` FOR EACH ROW BEGIN
     DECLARE    li_emp_no          INTEGER;
     DECLARE    ls_emp_name        varchar(100);
     DECLARE    li_emp_catg        INTEGER;
     DECLARE    ls_emp_desig       varchar(100);
     DECLARE    ls_emp_status      varchar(5);
     DECLARE    ls_remarks         varchar(35);
    
     DECLARE    ld_basic_pay       decimal(10,2);
     DECLARE    ld_da_amt          decimal(10,2);
     DECLARE    ld_oth_allow       decimal(10,2);
     DECLARE    ld_med_allow       decimal(10,2);
     DECLARE    ld_hra_amt         decimal(10,2);
     Declare    ld_gross_amt       decimal(10,2);
     DECLARE    ld_net_amt         decimal(10,2);
     
     
     Declare    li_count          INTEGER;
     Declare    li_days           INTEGER;
     Declare    li_count_income   INTEGER;
     Declare    ld_insuarance     decimal(20,2);
     Declare    ld_ccs            decimal(20,2);
     Declare    ld_hbl            decimal(20,2);
     Declare    ld_festival_adv   decimal(20,2);
     Declare    ld_telephone      decimal(20,2);
     Declare    ld_med_adv        decimal(20,2);
    
     Declare   ld_tf              decimal(20,2);
     Declare   ld_med_ins         decimal(20,2);
     Declare   ld_comp_loan       decimal(20,2);
     Declare   ld_itax            decimal(20,2);
     Declare   ld_gpf             decimal(20,2);
     Declare   ld_epf             decimal(20,2);
     Declare   ld_ptax            decimal(20,2);
     Declare   ld_other_deduction decimal(20,2);
     DECLARE   ld_tot_amt         decimal(20,2);
     DECLARE   ld_total_deduct    decimal(10,2);
    
    DECLARE v_finished INTEGER DEFAULT 0;
    
    DECLARE emp_dtls CURSOR FOR 
      SELECT emp_code,
             emp_name,
             emp_catg,
             IFNULL(designation,'NA')designation,
              emp_status
       from  md_employee
       where emp_status in('A','S')
       and   emp_catg = new.catg_cd;
       
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1; 
  
   OPEN emp_dtls;
   
   read_loop: LOOP
        
    FETCH emp_dtls INTO li_emp_no,ls_emp_name,li_emp_catg,ls_emp_desig,
                          ls_emp_status;
    
        IF v_finished = 1 THEN
            LEAVE read_loop;
        END IF;
        
    
    SELECT count(*)
    into   li_count_income
    FROM   td_income
    where  emp_code = li_emp_no;
    
 /*Eaning*/   
    
 if  li_count_income > 0  THEN
 
		SELECT  IFNULL(basic_pay,0),IFNULL(da_amt,0),IFNULL(hra_amt,0),
				IFNULL(othr_allow,0),IFNULL(med_allow,0)
		into    ld_basic_pay,ld_da_amt ,ld_hra_amt, ld_oth_allow ,ld_med_allow
		FROM    td_income
		where   emp_code		=	li_emp_no
		and     effective_date 	=	(select max(effective_date) 
                     			     from  td_income where emp_code=li_emp_no);


		SET ld_gross_amt = (ld_basic_pay + ld_da_amt + ld_med_allow + ld_hra_amt + ld_oth_allow );
 ELSE
  

    
     	SET ld_basic_pay = 0;
    	SET ld_da_amt = 0;
    	SET ld_hra_amt = 0;
    	SET ld_oth_allow = 0;
    	SET ld_med_allow = 0;
     
  End if;        

/*Deduction*/
   SELECT count(*)
    into   li_count
    FROM   td_deductions
    where  emp_cd = li_emp_no;
     

if li_count > 0 Then
   
    Select  IFNULL(insuarance,0)insuarance,
            IFNULL(ccs,0)ccs,
            IFNULL(hbl,0)hbl,
            IFNULL(telephone,0)telephone,
            IFNULL(med_adv,0)med_adv,
            IFNULL(festival_adv,0)festival_adv,
            IFNULL(tf,0)tf,
            IFNULL(med_ins,0)med_ins,
            IFNULL(comp_loan,0)comp_loan,
            IFNULL(itax,0)itax,
            IFNULL(gpf,0)gpf,
            IFNULL(epf,0)epf,
            IFNULL(ptax,0)ptax,
            IFNULL(other_deduction,0)other_deduction
        into  ld_insuarance,
                ld_ccs,
                ld_hbl,
                ld_telephone,
                ld_med_adv,
                ld_festival_adv,
                ld_tf,
                ld_med_ins,
                ld_comp_loan,
                ld_itax,
                ld_gpf,
                ld_epf,
                ld_ptax,
                ld_other_deduction
        from  td_deductions
        where emp_cd    = li_emp_no;

     
    ELSE
    
            SET ld_insuarance = 0;
            SET ld_ccs = 0;
            SET ld_hbl = 0;
            SET ld_telephone = 0;
            SET ld_med_adv= 0;
            SET ld_festival_adv= 0;
	        SET ld_tf= 0;
            SET ld_med_ins= 0;
            SET ld_comp_loan= 0;
            SET ld_itax= 0;
	        SET ld_gpf= 0;
            SET ld_epf= 0;
            SET ld_ptax= 0;
            SET ld_other_deduction= 0;
 End if;

SET ld_total_deduct = (ld_insuarance+ld_ccs+ld_hbl+ld_festival_adv+ld_telephone+ld_med_adv+ld_festival_adv+ld_tf+ld_med_ins+ld_comp_loan+ld_itax+ld_gpf+ld_epf+ld_ptax+ld_other_deduction);
      
SET ld_net_amt = (ld_gross_amt - ld_total_deduct);

        insert into td_pay_slip(trans_date,
                                trans_no,
                                sal_month,
                                sal_year,
                                emp_no,basic_pay,da_amt,hra_amt,othr_allow,
                                insuarance,
                                ccs,hbl,telephone,med_adv,
                               festival_adv,tf,med_ins,comp_loan,ptax
                               ,itax,gpf,epf,other_deduction,net_amount)
                       values( new.trans_date,
                               new.trans_no,
                                new.sal_month,
                                new.sal_year,
                                li_emp_no,
                                ld_basic_pay ,
                                ld_da_amt , 
                                ld_hra_amt,
                                ld_oth_allow,
					      		ld_insuarance, 
					            ld_ccs,
					            ld_hbl,
					            ld_telephone,
					            ld_med_adv,
					            ld_festival_adv,
						        ld_tf,
					            ld_med_ins,
					            ld_comp_loan,
					            ld_ptax,
					            ld_itax,
						        ld_gpf,
					            ld_epf,
					            
					            ld_other_deduction,ld_net_amt);    
                              
END LOOP;
     
CLOSE emp_dtls;  
  
  
END
$$
DELIMITER ;

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
  ADD PRIMARY KEY (`emp_code`) USING BTREE;

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
  ADD PRIMARY KEY (`trans_date`,`sal_month`,`sal_year`,`emp_no`);

--
-- Indexes for table `td_salary`
--
ALTER TABLE `td_salary`
  ADD PRIMARY KEY (`trans_date`,`trans_no`) USING BTREE;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `sl_no` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
