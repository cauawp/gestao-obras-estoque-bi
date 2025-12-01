CREATE DATABASE  IF NOT EXISTS `estoque_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `estoque_db`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: estoque_db
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alocacao_equipe`
--

DROP TABLE IF EXISTS `alocacao_equipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alocacao_equipe` (
  `alocacao_id` int NOT NULL AUTO_INCREMENT,
  `obra_id` int NOT NULL,
  `equipe_id` int NOT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  PRIMARY KEY (`alocacao_id`),
  KEY `equipe_id` (`equipe_id`),
  KEY `idx_aloc_obra` (`obra_id`),
  CONSTRAINT `alocacao_equipe_ibfk_1` FOREIGN KEY (`obra_id`) REFERENCES `obra` (`obra_id`),
  CONSTRAINT `alocacao_equipe_ibfk_2` FOREIGN KEY (`equipe_id`) REFERENCES `equipe` (`equipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alocacao_equipe`
--

LOCK TABLES `alocacao_equipe` WRITE;
/*!40000 ALTER TABLE `alocacao_equipe` DISABLE KEYS */;
INSERT INTO `alocacao_equipe` VALUES (1,1,1,'2024-01-10','2024-03-01'),(2,1,2,'2024-03-05',NULL),(3,3,3,'2024-04-01','2024-06-30');
/*!40000 ALTER TABLE `alocacao_equipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `compra_id` int NOT NULL AUTO_INCREMENT,
  `fornecedor_id` int NOT NULL,
  `obra_id` int NOT NULL,
  `data_compra` date DEFAULT (curdate()),
  `valor_total` decimal(14,2) DEFAULT NULL,
  `nota_fiscal` varchar(100) DEFAULT NULL,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`compra_id`),
  KEY `idx_compra_obra` (`obra_id`),
  KEY `idx_compra_fornecedor` (`fornecedor_id`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedor` (`fornecedor_id`),
  CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`obra_id`) REFERENCES `obra` (`obra_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,1,1,'2024-01-20',4500.00,'NF001-A','2025-11-18 02:07:15'),(2,1,1,'2024-02-10',8200.00,'NF002-A','2025-11-18 02:07:15'),(3,2,2,'2024-03-15',3200.00,'NF003-B','2025-11-18 02:07:15'),(4,3,3,'2024-04-01',1500.00,'NF004-C','2025-11-18 02:07:15');
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra_item`
--

DROP TABLE IF EXISTS `compra_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra_item` (
  `compra_item_id` int NOT NULL AUTO_INCREMENT,
  `compra_id` int NOT NULL,
  `material_id` int NOT NULL,
  `quantidade` decimal(14,2) NOT NULL,
  `preco_unitario` decimal(14,2) DEFAULT NULL,
  `subtotal` decimal(14,2) DEFAULT NULL,
  PRIMARY KEY (`compra_item_id`),
  KEY `compra_id` (`compra_id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `compra_item_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `compra` (`compra_id`) ON DELETE CASCADE,
  CONSTRAINT `compra_item_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `material` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra_item`
--

LOCK TABLES `compra_item` WRITE;
/*!40000 ALTER TABLE `compra_item` DISABLE KEYS */;
INSERT INTO `compra_item` VALUES (1,1,1,100.00,30.00,3000.00),(2,1,2,5.00,110.00,550.00),(3,2,4,900.00,6.50,5850.00),(4,2,5,2000.00,1.05,2100.00),(5,3,3,10.00,135.00,1350.00),(6,4,6,40.00,28.50,1140.00);
/*!40000 ALTER TABLE `compra_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipe`
--

DROP TABLE IF EXISTS `equipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipe` (
  `equipe_id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `funcao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`equipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipe`
--

LOCK TABLES `equipe` WRITE;
/*!40000 ALTER TABLE `equipe` DISABLE KEYS */;
INSERT INTO `equipe` VALUES (1,'Equipe Alpha','Fundação'),(2,'Equipe Beta','Estrutura'),(3,'Equipe Gama','Acabamento');
/*!40000 ALTER TABLE `equipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etapa`
--

DROP TABLE IF EXISTS `etapa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etapa` (
  `etapa_id` int NOT NULL AUTO_INCREMENT,
  `obra_id` int NOT NULL,
  `nome` varchar(200) NOT NULL,
  `descricao` text,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `percentual_previsto` decimal(14,2) DEFAULT NULL,
  `percentual_executado` decimal(14,2) DEFAULT NULL,
  PRIMARY KEY (`etapa_id`),
  KEY `idx_etapa_obra` (`obra_id`),
  CONSTRAINT `etapa_ibfk_1` FOREIGN KEY (`obra_id`) REFERENCES `obra` (`obra_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etapa`
--

LOCK TABLES `etapa` WRITE;
/*!40000 ALTER TABLE `etapa` DISABLE KEYS */;
INSERT INTO `etapa` VALUES (1,1,'Fundação','Escavação e concretagem','2024-01-15','2024-02-10',100.00,100.00),(2,1,'Estrutura','Pilares e vigas','2024-02-15','2024-06-10',80.00,70.00),(3,2,'Infraestrutura','Rede elétrica e hidráulica','2024-03-10','2024-06-20',40.00,30.00),(4,3,'Acabamento','Pintura e pisos','2024-04-01','2024-06-30',100.00,100.00);
/*!40000 ALTER TABLE `etapa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `fornecedor_id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `endereco` text,
  PRIMARY KEY (`fornecedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
INSERT INTO `fornecedor` VALUES (1,'Construmax Materiais','12.345.678/0001-99','11998887766','contato@construmax.com','Avenida 1'),(2,'Casa da Construção','31.222.111/0001-10','11997776655','vendas@casaconstrucao.com','Rua B, 50'),(3,'Tintas ProColor','55.444.333/0001-22','11990011223','atendimento@procolor.com','Rua das Tintas, 77'),(4,'Construmax Materiais','12.345.678/0001-99','11998887766','contato@construmax.com','Avenida 1'),(5,'Casa da Construção','31.222.111/0001-10','11997776655','vendas@casaconstrucao.com','Rua B, 50'),(6,'Tintas ProColor','55.444.333/0001-22','11990011223','atendimento@procolor.com','Rua das Tintas, 77');
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `funcionario_id` int NOT NULL AUTO_INCREMENT,
  `equipe_id` int DEFAULT NULL,
  `nome` varchar(150) NOT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`funcionario_id`),
  KEY `equipe_id` (`equipe_id`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`equipe_id`) REFERENCES `equipe` (`equipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,1,'João Silva','Pedreiro','11991112222'),(2,1,'Carlos Lima','Servente','11992223333'),(3,2,'Marcos Souza','Carpinteiro','11993334444'),(4,3,'Ana Paula','Pintora','11994445555');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `unidade` varchar(20) DEFAULT NULL,
  `custo_medio` decimal(14,2) DEFAULT NULL,
  `estoque_minimo` decimal(14,2) DEFAULT NULL,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'Cimento CP-II','Saco',32.50,50.00,'2025-11-18 02:06:53'),(2,'Areia Média','m3',120.00,10.00,'2025-11-18 02:06:53'),(3,'Brita 1','m3',140.00,10.00,'2025-11-18 02:06:53'),(4,'Aço CA-50','Kg',6.80,200.00,'2025-11-18 02:06:53'),(5,'Tijolo 8 furos','Un',1.10,500.00,'2025-11-18 02:06:53'),(6,'Tinta Acrílica','L',28.90,20.00,'2025-11-18 02:06:53');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimentacao_material`
--

DROP TABLE IF EXISTS `movimentacao_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimentacao_material` (
  `mov_id` int NOT NULL AUTO_INCREMENT,
  `obra_id` int NOT NULL,
  `material_id` int NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `origem` varchar(30) DEFAULT NULL,
  `referencia_id` int DEFAULT NULL,
  `quantidade` decimal(14,2) NOT NULL,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `responsavel` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`mov_id`),
  KEY `idx_mov_obra` (`obra_id`),
  KEY `idx_mov_material` (`material_id`),
  CONSTRAINT `movimentacao_material_ibfk_1` FOREIGN KEY (`obra_id`) REFERENCES `obra` (`obra_id`),
  CONSTRAINT `movimentacao_material_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `material` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimentacao_material`
--

LOCK TABLES `movimentacao_material` WRITE;
/*!40000 ALTER TABLE `movimentacao_material` DISABLE KEYS */;
INSERT INTO `movimentacao_material` VALUES (1,1,1,'ENTRADA','COMPRA',1,100.00,'2025-11-18 02:07:27','Carlos'),(2,1,2,'ENTRADA','COMPRA',1,5.00,'2025-11-18 02:07:27','Carlos'),(3,1,4,'ENTRADA','COMPRA',2,900.00,'2025-11-18 02:07:27','Roberto'),(4,2,3,'ENTRADA','COMPRA',3,10.00,'2025-11-18 02:07:27','Daniel'),(5,3,6,'ENTRADA','COMPRA',4,40.00,'2025-11-18 02:07:27','Ana'),(6,1,1,'SAÍDA','USO',NULL,-40.00,'2025-11-18 02:07:27','Mestre João'),(7,1,4,'SAÍDA','USO',NULL,-300.00,'2025-11-18 02:07:27','Mestre João'),(8,3,6,'SAÍDA','USO',NULL,-10.00,'2025-11-18 02:07:27','Pintor Luís');
/*!40000 ALTER TABLE `movimentacao_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obra`
--

DROP TABLE IF EXISTS `obra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obra` (
  `obra_id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `endereco` text,
  `data_inicio` date DEFAULT NULL,
  `data_previsao` date DEFAULT NULL,
  `data_conclusao` date DEFAULT NULL,
  `status` varchar(30) DEFAULT 'EM ANDAMENTO',
  PRIMARY KEY (`obra_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obra`
--

LOCK TABLES `obra` WRITE;
/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
INSERT INTO `obra` VALUES (1,'Construção Casa Verde','Rua das Flores, 120 - São Paulo','2025-01-10','2025-06-30',NULL,'EM ANDAMENTO'),(2,'Reforma Comercial Centro','Av. Paulista, 900 - São Paulo','2025-02-01','2025-08-15',NULL,'EM ANDAMENTO'),(3,'Edifício Torres Azul','R. Diamante, 55 - Campinas','2025-03-05','2026-01-30',NULL,'EM ANDAMENTO'),(4,'Residencial Sol Nascente','Rua das Flores, 123','2024-01-10','2024-12-20',NULL,'EM ANDAMENTO'),(5,'Prédio Comercial Horizonte','Av. Central, 998','2024-03-01','2025-02-10',NULL,'EM ANDAMENTO'),(6,'Reforma Clínica Médica','Rua Saúde, 55','2024-02-15','2024-09-30',NULL,'CONCLUÍDA');
/*!40000 ALTER TABLE `obra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_estoque_material`
--

DROP TABLE IF EXISTS `vw_estoque_material`;
/*!50001 DROP VIEW IF EXISTS `vw_estoque_material`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_estoque_material` AS SELECT 
 1 AS `material_id`,
 1 AS `material_nome`,
 1 AS `unidade`,
 1 AS `estoque_atual`,
 1 AS `estoque_minimo`,
 1 AS `custo_medio`,
 1 AS `valor_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_estoque_material`
--

/*!50001 DROP VIEW IF EXISTS `vw_estoque_material`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_estoque_material` AS select `m`.`material_id` AS `material_id`,`m`.`nome` AS `material_nome`,`m`.`unidade` AS `unidade`,ifnull(sum(`mm`.`quantidade`),0) AS `estoque_atual`,`m`.`estoque_minimo` AS `estoque_minimo`,`m`.`custo_medio` AS `custo_medio`,(ifnull(sum(`mm`.`quantidade`),0) * ifnull(`m`.`custo_medio`,0)) AS `valor_total` from (`material` `m` left join `movimentacao_material` `mm` on((`mm`.`material_id` = `m`.`material_id`))) group by `m`.`material_id`,`material_nome`,`m`.`unidade`,`m`.`estoque_minimo`,`m`.`custo_medio` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-17 23:27:27
