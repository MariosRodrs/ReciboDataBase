-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Recibo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Recibo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Recibo` DEFAULT CHARACTER SET latin1 ;
-- -----------------------------------------------------
-- Schema recibo
-- -----------------------------------------------------
USE `Recibo` ;

-- -----------------------------------------------------
-- Table `Recibo`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recibo`.`pessoa` (
  `idpessoa` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `documento` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idpessoa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Recibo`.`recibo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recibo`.`recibo` (
  `idrecibo` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` INT(11) NOT NULL,
  `dataEmissao` DATETIME NOT NULL,
  `valor` DOUBLE NOT NULL,
  `prestador` INT(11) NOT NULL,
  `emitente` INT(11) NOT NULL,
  `referencia` INT(11) NOT NULL,
  PRIMARY KEY (`idrecibo`),
  UNIQUE INDEX `idrecibo_UNIQUE` (`idrecibo` ASC),
  INDEX `emitente_fk_idx` (`emitente` ASC),
  INDEX `prestador_fk_idx` (`prestador` ASC),
  CONSTRAINT `emitente_fk`
    FOREIGN KEY (`emitente`)
    REFERENCES `Recibo`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prestador_fk`
    FOREIGN KEY (`prestador`)
    REFERENCES `Recibo`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Recibo`.`uf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recibo`.`uf` (
  `idUf` INT(11) NOT NULL AUTO_INCREMENT,
  `sigla` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`idUf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Recibo`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recibo`.`cidade` (
  `idCidade` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `uf_id` INT(11) NOT NULL,
  PRIMARY KEY (`idCidade`),
  INDEX `uf_fk_idx` (`uf_id` ASC),
  CONSTRAINT `uf_fk`
    FOREIGN KEY (`uf_id`)
    REFERENCES `Recibo`.`uf` (`idUf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Recibo`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recibo`.`endereco` (
  `idEndereco` INT(11) NOT NULL,
  `tipoLogradouro` VARCHAR(15) NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(5) NOT NULL,
  `complemento` VARCHAR(50) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `tipo` INT(11) NOT NULL,
  `pessoa_id` INT(11) NOT NULL,
  `cidade_id` INT(11) NOT NULL,
  PRIMARY KEY (`idEndereco`),
  INDEX `cidade_fk_idx` (`cidade_id` ASC),
  INDEX `pessoa_fk_idx` (`pessoa_id` ASC),
  CONSTRAINT `pessoa_fk`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `Recibo`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cidade_fk`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `Recibo`.`cidade` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Recibo`.`referencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recibo`.`referencia` (
  `idreferencia` INT(11) NOT NULL AUTO_INCREMENT,
  `servico` VARCHAR(150) NOT NULL,
  `produto` VARCHAR(150) NOT NULL,
  `recibo` INT(11) NOT NULL,
  PRIMARY KEY (`idreferencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Recibo`.`recibo_has_referencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recibo`.`recibo_has_referencia` (
  `recibo_idrecibo` INT(11) NOT NULL,
  `referencia_idreferencia` INT(11) NOT NULL,
  PRIMARY KEY (`recibo_idrecibo`, `referencia_idreferencia`),
  INDEX `fk_recibo_has_referencia_referencia1_idx` (`referencia_idreferencia` ASC),
  INDEX `fk_recibo_has_referencia_recibo1_idx` (`recibo_idrecibo` ASC),
  CONSTRAINT `fk_recibo_has_referencia_recibo1`
    FOREIGN KEY (`recibo_idrecibo`)
    REFERENCES `Recibo`.`recibo` (`idrecibo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recibo_has_referencia_referencia1`
    FOREIGN KEY (`referencia_idreferencia`)
    REFERENCES `Recibo`.`referencia` (`idreferencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
