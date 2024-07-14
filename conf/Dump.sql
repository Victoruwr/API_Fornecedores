/*
SQLyog Community v13.2.1 (64 bit)
MySQL - 8.3.0 : Database - horse
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`horse` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `horse`;

/*Table structure for table `tbl_fornecedores` */

DROP TABLE IF EXISTS `tbl_fornecedores`;

CREATE TABLE `tbl_fornecedores` (
  `CODIGO` bigint NOT NULL AUTO_INCREMENT,
  `RAZAO_SOCIAL` varchar(100) NOT NULL,
  `CNPJ_CPF` varchar(14) DEFAULT NULL,
  `FANTASIA` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tbl_fornecedores` */

insert  into `tbl_fornecedores`(`CODIGO`,`RAZAO_SOCIAL`,`CNPJ_CPF`,`FANTASIA`) values 
(1,'Banco leopoldina LTDA','53977133000189','Banco de leopoldina'),
(2,'FERREIRAS LTDA','88742206000138','FERREIRAS'),
(3,'VOTIRA DA CONQUISTA LTDA','44871304000108','LIMADUARTE'),
(4,'Antônio Gilberto de lima','63545670007','Antônio Gilberto'),
(5,'Felipe lima','47699606035','Felipe lima'),
(6,'Jorge Luiz','20822032040','LIMADUARTE'),
(7,'Spettos e CIA lTDA','74620399000140','Spettos'),
(8,'Ferragens e Contruções LTDA','83523052000170','Ferragens'),
(9,'Artur Almeida','24260487000','Artur Almeida'),
(11,'Posto Ipiranga LTDA','41928680000195','Posto Ipiranga'),
(12,'Banco cataguases LTDA','53977133000189','Banco de cataguases'),
(13,'Banco miraí LTDA','53977133000189','Banco de cataguases'),
(14,'Banco testa LTDA','53977133000189','Banco de teste'),
(15,'Banco testa LTDA','53977133000189','Banco de teste'),
(16,'joao da silva','12345678912','joao da silva');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
