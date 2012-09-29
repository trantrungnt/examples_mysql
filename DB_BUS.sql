-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 29, 2012 at 01:30 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `DB_BUS`
--

-- --------------------------------------------------------

--
-- Table structure for table `Bus`
--

CREATE TABLE IF NOT EXISTS `Bus` (
  `Bus_id` varchar(15) NOT NULL,
  `Bus_quantities` int(11) NOT NULL,
  `Bus_date_production` date DEFAULT NULL,
  `Bus_manuafacturer` varchar(200) DEFAULT NULL,
  `Bus_total_seat` int(11) DEFAULT NULL,
  PRIMARY KEY (`Bus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Bus`
--

INSERT INTO `Bus` (`Bus_id`, `Bus_quantities`, `Bus_date_production`, `Bus_manuafacturer`, `Bus_total_seat`) VALUES
('KA19-8P8488', 12, '2006-11-21', 'Telma', 80),
('MH02-6M-1381', 8, '2003-11-15', 'Cummins', 39),
('RJ14-3C-0343', 5, '2006-11-21', 'Mercedes-Benz', 47);

-- --------------------------------------------------------

--
-- Table structure for table `Drivers`
--

CREATE TABLE IF NOT EXISTS `Drivers` (
  `Drv_id` int(11) NOT NULL AUTO_INCREMENT,
  `Drv_fname` varchar(100) NOT NULL,
  `Drv_phone` varchar(20) NOT NULL,
  `Drv_birth` char(10) DEFAULT NULL,
  `Drv_email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Drv_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `Drivers`
--

INSERT INTO `Drivers` (`Drv_id`, `Drv_fname`, `Drv_phone`, `Drv_birth`, `Drv_email`) VALUES
(1, 'Linus Torvalds', '+91-11-23765299', '19780511', 'torvalds@mumbus.in'),
(2, 'Stephen Fry', '+91-11-23765255', '19650122', 'fry@mumbus.in'),
(3, 'Peter Han', '+91-11-23765233', '19841231', 'han@mumbus.in'),
(4, 'Rasmus Lerdorf', '+91-11-23765266', '19821120', 'lerdorf@mumbus.in');

-- --------------------------------------------------------

--
-- Table structure for table `Rountes`
--

CREATE TABLE IF NOT EXISTS `Rountes` (
  `Rnt_id` int(11) NOT NULL AUTO_INCREMENT,
  `Rnt_rounting` varchar(200) NOT NULL,
  `Rnt_price` float NOT NULL,
  `Rnt_long` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rnt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `Rountes`
--

INSERT INTO `Rountes` (`Rnt_id`, `Rnt_rounting`, `Rnt_price`, `Rnt_long`) VALUES
(1, 'Mumbai-Nashik', 25.5, 120),
(2, 'Mumbai-Bhayandar', 16.5, 95),
(3, 'Mumbai-Pune', 28.5, 235);

-- --------------------------------------------------------

--
-- Table structure for table `Tours`
--

CREATE TABLE IF NOT EXISTS `Tours` (
  `Tou_id` int(11) NOT NULL AUTO_INCREMENT,
  `Bus_id` varchar(15) DEFAULT NULL,
  `Rnt_id` int(11) DEFAULT NULL,
  `Drv_id` int(11) DEFAULT NULL,
  `Tou_time_start` datetime NOT NULL,
  `Tou_time_end` datetime NOT NULL,
  `Tou_total_siting` int(11) DEFAULT NULL,
  PRIMARY KEY (`Tou_id`),
  KEY `Tours_Bus` (`Bus_id`),
  KEY `Tours_Rountes` (`Rnt_id`),
  KEY `Tours_Drivers` (`Drv_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `Tours`
--

INSERT INTO `Tours` (`Tou_id`, `Bus_id`, `Rnt_id`, `Drv_id`, `Tou_time_start`, `Tou_time_end`, `Tou_total_siting`) VALUES
(1, 'MH02-6M-1381', 2, 1, '2008-09-13 14:21:00', '2008-09-13 15:31:00', 35),
(2, 'RJ14-3C-0343', 2, 3, '2008-10-20 04:36:00', '2008-10-20 05:36:00', 42),
(3, 'RJ14-3C-0343', 1, 2, '2008-01-10 15:30:00', '2008-01-10 17:40:00', 38),
(4, 'KA19-8P8488', 3, 3, '2009-10-23 18:05:00', '2009-10-23 20:25:00', 76);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Tours`
--
ALTER TABLE `Tours`
  ADD CONSTRAINT `Tours_Bus` FOREIGN KEY (`Bus_id`) REFERENCES `Bus` (`Bus_id`),
  ADD CONSTRAINT `Tours_Rountes` FOREIGN KEY (`Rnt_id`) REFERENCES `Rountes` (`Rnt_id`),
  ADD CONSTRAINT `Tours_Drivers` FOREIGN KEY (`Drv_id`) REFERENCES `Drivers` (`Drv_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

--
create view dbbus4a
as
select r.Rnt_rounting, t.Bus_id, d.Drv_fname, t.Tou_total_siting from Tours as t inner join Rountes as r on t.Rnt_id = r.Rnt_id inner join Bus as b on t.Bus_id = b.Bus_id inner join Drivers as d on t.Drv_id = d.Drv_id   
where Year(t.Tou_time_start) = 2008

--
create view dbbus4b
as
select Drv_fname from Tours as t inner join Drivers as d on t.Drv_id = d.Drv_id 
group by t.Drv_id
having count(t.Drv_id) and max(Date(d.Drv_Birth))
order by t.Drv_id desc 
limit 1

--
create view dbbus4c
as
select Rnt_rounting from Tours as t inner join Rountes as r on t.Rnt_id = r.Rnt_id 
where t.Tou_total_siting = (select max(Tou_total_siting) from Tours)

--
CREATE VIEW dbbus4d AS
SELECT d.Drv_fname, b.Bus_id, (SUM(t.Tou_total_siting * r.Rnt_price)) AS total
FROM Rountes r, Bus b, Tours t, Drivers d
WHERE t.Rnt_id = r.Rnt_id AND t.Bus_id = b.Bus_id AND t.Drv_id = d.Drv_id
GROUP BY d.Drv_fname
ORDER BY total DESC
LIMIT 1;


--
Delimiter //

create trigger trig_del_Drivers 
after delete on Drivers
for each row
 begin
  set @Drv_id = old.Drv_id;
  set @Drv_fname=old.Drv_fname;
  set @Drv_phone=old.Drv_phone;
  set @Drv_birth=old.Drv_birth;
  set @Drv_email=old.Drv_email;

CREATE TABLE IF NOT EXISTS `bk_Drivers` (
  `Drv_id` int(11),
  `Drv_fname` varchar(100) NOT NULL,
  `Drv_phone` varchar(20) NOT NULL,
  `Drv_birth` char(10)  NULL,
  `Drv_email` varchar(50)  NULL,
  
) ;

insert into bk_Drivers 
values (@Drv_id, @Drv_fname, @Drv_phone, @Drv_birth, @Drv_email);

end//

--
delimiter //
create trigger trig_update_Drivers
after update on Drivers
for each row
 begin
  set @Drv_id = old.Drv_id;
  set @Drv_fname = old.Drv_fname;
  set @Drv_phone = old.Drv_phone;
  set @Drv_birth = old.Drv_birth;
  set @Drv_email = old.Drv_email;

CREATE TABLE IF NOT EXISTS `bk_Drivers` (
  `Drv_id` int(11),
  `Drv_fname` varchar(100) NOT NULL,
  `Drv_phone` varchar(20) NOT NULL,
  `Drv_birth` char(10)  NULL,
  `Drv_email` varchar(50)  NULL,
) ;

insert into bk_Drivers values (@Drv_id, @Drv_fname, @Drv_phone,@Drv_birth, @Drv_email);

end//

--
delimiter //
create procedure sp_sum(Driv_id int(11) , Bus_id varchar(15), Year int)
begin
       select sum(Tou_total_siting)
       from Bus b , Drivers d, Tours t
      where t.Bus_id = b.Bus_id and t.Driv_id = d.Driv_id
       and  year(t.Tou_time_start) = Year
       and t.Bus_id = Bus_id
       and t.Driv_id = Driv_id;

end//


--
DELIMITER //
CREATE PROCEDURE sp_sum_Total()
BEGIN
SELECT b.Bus_id, SUM(t.Tou_total_siting * r.Rnt_price)
FROM Rountes r, Bus b, Tours t
WHERE t.Rnt_id = r.Rnt_id AND t.Bus_id = b.Bus_id
GROUP BY b.Bus_id;
END//


--
DELIMITER //
CREATE PROCEDURE sp_display()
BEGIN
SELECT b.Bus_id, (SUM(t.Tou_total_siting * r.Rnt_price)) AS total
FROM Rountes r, Bus b, Tours t
WHERE t.Rnt_id = r.Rnt_id AND t.Bus_id = b.Bus_id
GROUP BY b.Bus_id
ORDER BY total
LIMIT 1;
END//


