-- MySQL Script generated by MySQL Workbench
-- Wed Oct 19 15:02:00 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema VendasPontoCom
-- -----------------------------------------------------
-- Bando de dados do sistema de vendas na web.

-- -----------------------------------------------------
-- Schema VendasPontoCom
--
-- Bando de dados do sistema de vendas na web.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `VendasPontoCom` DEFAULT CHARACTER SET utf8 ;
USE `VendasPontoCom` ;

-- -----------------------------------------------------
-- Table `VendasPontoCom`.`Produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VendasPontoCom`.`Produtos` ;

CREATE TABLE IF NOT EXISTS `VendasPontoCom`.`Produtos` (
  `prodId` INT NOT NULL AUTO_INCREMENT,
  `prodNome` VARCHAR(45) NOT NULL,
  `prodDescricao` VARCHAR(500) NOT NULL,
  `prodValor` FLOAT NOT NULL,
  `prodQtdeEmEstoque` INT NOT NULL,
  PRIMARY KEY (`prodId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendasPontoCom`.`Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VendasPontoCom`.`Clientes` ;

CREATE TABLE IF NOT EXISTS `VendasPontoCom`.`Clientes` (
  `clieCPF` VARCHAR(11) NOT NULL,
  `clieNome` VARCHAR(45) NOT NULL,
  `clieEndereco` VARCHAR(100) NOT NULL,
  `clieComplementoDoEndereco` VARCHAR(30) NULL,
  `clieUF` VARCHAR(2) NOT NULL,
  `clieCidade` VARCHAR(45) NOT NULL,
  `clieCEP` VARCHAR(8) NOT NULL,
  `clieFone` VARCHAR(15) NOT NULL,
  `clieDataDeNascimento` DATE NOT NULL,
  `clieEmail` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`clieCPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `VendasPontoCom`.`CarrinhoDeCompras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VendasPontoCom`.`CarrinhoDeCompras` ;

CREATE TABLE IF NOT EXISTS `VendasPontoCom`.`CarrinhoDeCompras` (
  `carrClieCPF` VARCHAR(11) NOT NULL,
  `carrProdId` INT NOT NULL,
  `carrQtdeProduto` INT NOT NULL,
  `carrData` DATETIME NOT NULL,
  PRIMARY KEY (`carrClieCPF`, `carrProdId`),
  INDEX `fk_Clientes_has_Produtos_Produtos2_idx` (`carrProdId` ASC),
  INDEX `fk_Clientes_has_Produtos_Clientes1_idx` (`carrClieCPF` ASC),
  CONSTRAINT `fk_Clientes_has_Produtos_Clientes1`
    FOREIGN KEY (`carrClieCPF`)
    REFERENCES `VendasPontoCom`.`Clientes` (`clieCPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_has_Produtos_Produtos2`
    FOREIGN KEY (`carrProdId`)
    REFERENCES `VendasPontoCom`.`Produtos` (`prodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `VendasPontoCom`.`Compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VendasPontoCom`.`Compras` ;

CREATE TABLE IF NOT EXISTS `VendasPontoCom`.`Compras` (
  `compId` INT NOT NULL AUTO_INCREMENT,
  `compClieCPF` VARCHAR(11) NOT NULL,
  `compDt` DATETIME NOT NULL,
  PRIMARY KEY (`compId`),
  INDEX `idx_compClieCPF` (`compClieCPF` ASC) ,
  CONSTRAINT `fk_Compras_Clientes1`
    FOREIGN KEY (`compClieCPF`)
    REFERENCES `VendasPontoCom`.`Clientes` (`clieCPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendasPontoCom`.`ItensDasCompras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VendasPontoCom`.`ItensDasCompras` ;

CREATE TABLE IF NOT EXISTS `VendasPontoCom`.`ItensDasCompras` (
  `itemCompId` INT NOT NULL,
  `itemProdId` INT NOT NULL,
  `itemQtdeProduto` INT NOT NULL,
  PRIMARY KEY (`itemCompId`, `itemProdId`),
  INDEX `fk_table1_Produtos1_idx` (`itemProdId` ASC),
  CONSTRAINT `fk_table1_Compras1`
    FOREIGN KEY (`itemCompId`)
    REFERENCES `VendasPontoCom`.`Compras` (`compId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Produtos1`
    FOREIGN KEY (`itemProdId`)
    REFERENCES `VendasPontoCom`.`Produtos` (`prodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
