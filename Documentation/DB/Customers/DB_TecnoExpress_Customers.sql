-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TecnoExpress_Customers
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TecnoExpress_Customers
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TecnoExpress_Customers` DEFAULT CHARACTER SET utf8 ;
USE `TecnoExpress_Customers` ;

-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Customers` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `tradeName` VARCHAR(120) NOT NULL,
  `typeId` VARCHAR(3) NOT NULL,
  `numberId` VARCHAR(12) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`idCustomer`),
  UNIQUE INDEX `tradeName_UNIQUE` (`tradeName` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Countries` (
  `idCountry` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(10) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCountry`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Departments` (
  `idDepartment` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(10) NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  `Countries_idCountry` INT NOT NULL,
  PRIMARY KEY (`idDepartment`),
  INDEX `fk_Departments_Countries1_idx` (`Countries_idCountry` ASC) ,
  CONSTRAINT `fk_Departments_Countries1`
    FOREIGN KEY (`Countries_idCountry`)
    REFERENCES `TecnoExpress_Customers`.`Countries` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Cities` (
  `idCity` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `Departments_idDepartment` INT NOT NULL,
  PRIMARY KEY (`idCity`),
  INDEX `fk_Cities_Departments1_idx` (`Departments_idDepartment` ASC) ,
  CONSTRAINT `fk_Cities_Departments1`
    FOREIGN KEY (`Departments_idDepartment`)
    REFERENCES `TecnoExpress_Customers`.`Departments` (`idDepartment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Branches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Branches` (
  `idBranch` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(120) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `principal` BINARY(1) NOT NULL,
  `Cities_idCity` INT NOT NULL,
  PRIMARY KEY (`idBranch`),
  INDEX `fk_Branches_Cities1_idx` (`Cities_idCity` ASC) ,
  CONSTRAINT `fk_Branches_Cities1`
    FOREIGN KEY (`Cities_idCity`)
    REFERENCES `TecnoExpress_Customers`.`Cities` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Customers_has_Branches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Customers_has_Branches` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Customers_idCustomer` INT NOT NULL,
  `Branches_idBranch` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Customers_has_Branches_Branches1_idx` (`Branches_idBranch` ASC) ,
  INDEX `fk_Customers_has_Branches_Customers1_idx` (`Customers_idCustomer` ASC) ,
  CONSTRAINT `fk_Customers_has_Branches_Customers1`
    FOREIGN KEY (`Customers_idCustomer`)
    REFERENCES `TecnoExpress_Customers`.`Customers` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_has_Branches_Branches1`
    FOREIGN KEY (`Branches_idBranch`)
    REFERENCES `TecnoExpress_Customers`.`Branches` (`idBranch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`InfoContacts_has_Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`InfoContacts_has_Customers` (
  `InfoContacts_idInfoContact` INT NOT NULL,
  `Customers_idCustomer` INT NOT NULL,
  PRIMARY KEY (`InfoContacts_idInfoContact`, `Customers_idCustomer`),
  INDEX `fk_InfoContacts_has_Customers_Customers1_idx` (`Customers_idCustomer` ASC) ,
  CONSTRAINT `fk_InfoContacts_has_Customers_Customers1`
    FOREIGN KEY (`Customers_idCustomer`)
    REFERENCES `TecnoExpress_Customers`.`Customers` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Customers_has_InfoContacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Customers_has_InfoContacts` (
  `Customers_idCustomer` INT NOT NULL,
  `InfoContacts_idInfoContact` INT NOT NULL,
  PRIMARY KEY (`Customers_idCustomer`, `InfoContacts_idInfoContact`),
  INDEX `fk_Customers_has_InfoContacts_Customers1_idx` (`Customers_idCustomer` ASC) ,
  CONSTRAINT `fk_Customers_has_InfoContacts_Customers1`
    FOREIGN KEY (`Customers_idCustomer`)
    REFERENCES `TecnoExpress_Customers`.`Customers` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Divisions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Divisions` (
  `idDivision` INT NOT NULL AUTO_INCREMENT,
  `division` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDivision`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Positions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Positions` (
  `idPosition` INT NOT NULL AUTO_INCREMENT,
  `position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPosition`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Positions_has_Divisions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Positions_has_Divisions` (
  `Positions_idPosition` INT NOT NULL,
  `Divisions_idDivision` INT NOT NULL,
  PRIMARY KEY (`Positions_idPosition`, `Divisions_idDivision`),
  INDEX `fk_Positions_has_Divisions_Divisions1_idx` (`Divisions_idDivision` ASC) ,
  INDEX `fk_Positions_has_Divisions_Positions1_idx` (`Positions_idPosition` ASC) ,
  CONSTRAINT `fk_Positions_has_Divisions_Positions1`
    FOREIGN KEY (`Positions_idPosition`)
    REFERENCES `TecnoExpress_Customers`.`Positions` (`idPosition`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Positions_has_Divisions_Divisions1`
    FOREIGN KEY (`Divisions_idDivision`)
    REFERENCES `TecnoExpress_Customers`.`Divisions` (`idDivision`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Divisions_has_Positions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Divisions_has_Positions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Divisions_idDivision` INT NOT NULL,
  `Positions_idPosition` INT NOT NULL,
  `state` BINARY(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Divisions_has_Positions_Positions1_idx` (`Positions_idPosition` ASC) ,
  INDEX `fk_Divisions_has_Positions_Divisions1_idx` (`Divisions_idDivision` ASC) ,
  CONSTRAINT `fk_Divisions_has_Positions_Divisions1`
    FOREIGN KEY (`Divisions_idDivision`)
    REFERENCES `TecnoExpress_Customers`.`Divisions` (`idDivision`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Divisions_has_Positions_Positions1`
    FOREIGN KEY (`Positions_idPosition`)
    REFERENCES `TecnoExpress_Customers`.`Positions` (`idPosition`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Phones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Phones` (
  `idPhone` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(15) NULL,
  `ext` VARCHAR(5) NULL,
  PRIMARY KEY (`idPhone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`CustomersContacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`CustomersContacts` (
  `idCustomerContact` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `Divisions_has_Positions_id` INT NOT NULL,
  PRIMARY KEY (`idCustomerContact`),
  INDEX `fk_CustomersContacts_Divisions_has_Positions1_idx` (`Divisions_has_Positions_id` ASC) ,
  CONSTRAINT `fk_CustomersContacts_Divisions_has_Positions1`
    FOREIGN KEY (`Divisions_has_Positions_id`)
    REFERENCES `TecnoExpress_Customers`.`Divisions_has_Positions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`InfoContacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`InfoContacts` (
  `idInfoContact` INT NOT NULL AUTO_INCREMENT,
  `Phones_idPhone` INT NOT NULL,
  `CustomersContacts_idCustomerContact` INT NOT NULL,
  PRIMARY KEY (`idInfoContact`),
  INDEX `fk_InfoContacts_Phones1_idx` (`Phones_idPhone` ASC) ,
  INDEX `fk_InfoContacts_CustomersContacts1_idx` (`CustomersContacts_idCustomerContact` ASC) ,
  CONSTRAINT `fk_InfoContacts_Phones1`
    FOREIGN KEY (`Phones_idPhone`)
    REFERENCES `TecnoExpress_Customers`.`Phones` (`idPhone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InfoContacts_CustomersContacts1`
    FOREIGN KEY (`CustomersContacts_idCustomerContact`)
    REFERENCES `TecnoExpress_Customers`.`CustomersContacts` (`idCustomerContact`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Addresses` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(100) NOT NULL,
  `additional` VARCHAR(100) NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`InfoContacts_has_InfoContacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`InfoContacts_has_InfoContacts` (
  `InfoContacts_idtable1` INT NOT NULL,
  `InfoContacts_idtable11` INT NOT NULL,
  PRIMARY KEY (`InfoContacts_idtable1`, `InfoContacts_idtable11`),
  INDEX `fk_InfoContacts_has_InfoContacts_InfoContacts2_idx` (`InfoContacts_idtable11` ASC) ,
  INDEX `fk_InfoContacts_has_InfoContacts_InfoContacts1_idx` (`InfoContacts_idtable1` ASC) ,
  CONSTRAINT `fk_InfoContacts_has_InfoContacts_InfoContacts1`
    FOREIGN KEY (`InfoContacts_idtable1`)
    REFERENCES `TecnoExpress_Customers`.`InfoContacts` (`idInfoContact`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InfoContacts_has_InfoContacts_InfoContacts2`
    FOREIGN KEY (`InfoContacts_idtable11`)
    REFERENCES `TecnoExpress_Customers`.`InfoContacts` (`idInfoContact`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Branches_has_InfoContacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Branches_has_InfoContacts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Branches_idBranch` INT NOT NULL,
  `InfoContacts_idInfoContact` INT NOT NULL,
  `Addresses_idAddress` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Branches_has_InfoContacts_InfoContacts1_idx` (`InfoContacts_idInfoContact` ASC) ,
  INDEX `fk_Branches_has_InfoContacts_Branches1_idx` (`Branches_idBranch` ASC) ,
  INDEX `fk_Branches_has_InfoContacts_Addresses1_idx` (`Addresses_idAddress` ASC) ,
  CONSTRAINT `fk_Branches_has_InfoContacts_Branches1`
    FOREIGN KEY (`Branches_idBranch`)
    REFERENCES `TecnoExpress_Customers`.`Branches` (`idBranch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Branches_has_InfoContacts_InfoContacts1`
    FOREIGN KEY (`InfoContacts_idInfoContact`)
    REFERENCES `TecnoExpress_Customers`.`InfoContacts` (`idInfoContact`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Branches_has_InfoContacts_Addresses1`
    FOREIGN KEY (`Addresses_idAddress`)
    REFERENCES `TecnoExpress_Customers`.`Addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Diagnostics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Diagnostics` (
  `idDiagnostic` INT NOT NULL AUTO_INCREMENT,
  `reference` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDiagnostic`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Customers_has_Diagnostics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Customers_has_Diagnostics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Customers_idCustomer` INT NOT NULL,
  `Diagnostics_idDiagnostic` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Customers_has_Diagnostics_Diagnostics1_idx` (`Diagnostics_idDiagnostic` ASC) ,
  INDEX `fk_Customers_has_Diagnostics_Customers1_idx` (`Customers_idCustomer` ASC) ,
  CONSTRAINT `fk_Customers_has_Diagnostics_Customers1`
    FOREIGN KEY (`Customers_idCustomer`)
    REFERENCES `TecnoExpress_Customers`.`Customers` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_has_Diagnostics_Diagnostics1`
    FOREIGN KEY (`Diagnostics_idDiagnostic`)
    REFERENCES `TecnoExpress_Customers`.`Diagnostics` (`idDiagnostic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Parts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Parts` (
  `idPart` INT NOT NULL AUTO_INCREMENT,
  `part` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPart`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Customers`.`Diagnostics_has_Repairs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Customers`.`Diagnostics_has_Repairs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Diagnostics_idDiagnostic` INT NOT NULL,
  `Repairs_idRepair` INT NOT NULL,
  `price` INT NOT NULL,
  `dateRepair` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateDelivery` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_Diagnostics_has_Repairs_Repairs1_idx` (`Repairs_idRepair` ASC) ,
  INDEX `fk_Diagnostics_has_Repairs_Diagnostics1_idx` (`Diagnostics_idDiagnostic` ASC) ,
  CONSTRAINT `fk_Diagnostics_has_Repairs_Diagnostics1`
    FOREIGN KEY (`Diagnostics_idDiagnostic`)
    REFERENCES `TecnoExpress_Customers`.`Diagnostics` (`idDiagnostic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Diagnostics_has_Repairs_Repairs1`
    FOREIGN KEY (`Repairs_idRepair`)
    REFERENCES `TecnoExpress_Customers`.`Parts` (`idPart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
