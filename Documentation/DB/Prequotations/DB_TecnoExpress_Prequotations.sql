-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TecnoExpress_Prequotations
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TecnoExpress_Prequotations
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TecnoExpress_Prequotations` DEFAULT CHARACTER SET utf8 ;
USE `TecnoExpress_Prequotations` ;

-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`CompaniesInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`CompaniesInfo` (
  `idCompanyInfo` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(100) NOT NULL,
  `typeId` VARCHAR(3) NOT NULL,
  `numberId` VARCHAR(20) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCompanyInfo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`InfoPersonal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`InfoPersonal` (
  `idInfoPersonal` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `lastName` VARCHAR(20) NOT NULL,
  `typeId` VARCHAR(3) NOT NULL,
  `numberId` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `CompaniesInfo_idCompanyInfo` INT NOT NULL,
  PRIMARY KEY (`idInfoPersonal`),
  INDEX `fk_InfoPersonal_CompaniesInfo1_idx` (`CompaniesInfo_idCompanyInfo` ASC) ,
  CONSTRAINT `fk_InfoPersonal_CompaniesInfo1`
    FOREIGN KEY (`CompaniesInfo_idCompanyInfo`)
    REFERENCES `TecnoExpress_Prequotations`.`CompaniesInfo` (`idCompanyInfo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`FinalCustomers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`FinalCustomers` (
  `idFinalCustomer` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(100) NOT NULL,
  `numberId` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idFinalCustomer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Headers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Headers` (
  `idHeader` INT NOT NULL AUTO_INCREMENT,
  `InfoPersonal_idInfoPersonal` INT NOT NULL,
  `FinalCustomers_idFinalCustomer` INT NOT NULL,
  PRIMARY KEY (`idHeader`),
  INDEX `fk_Headers_InfoPersonal1_idx` (`InfoPersonal_idInfoPersonal` ASC) ,
  INDEX `fk_Headers_FinalCustomers1_idx` (`FinalCustomers_idFinalCustomer` ASC) ,
  CONSTRAINT `fk_Headers_InfoPersonal1`
    FOREIGN KEY (`InfoPersonal_idInfoPersonal`)
    REFERENCES `TecnoExpress_Prequotations`.`InfoPersonal` (`idInfoPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Headers_FinalCustomers1`
    FOREIGN KEY (`FinalCustomers_idFinalCustomer`)
    REFERENCES `TecnoExpress_Prequotations`.`FinalCustomers` (`idFinalCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Services` (
  `idService` INT NOT NULL AUTO_INCREMENT,
  `item` VARCHAR(10) NOT NULL,
  `quantity` INT(3) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `unitValue` INT NOT NULL,
  PRIMARY KEY (`idService`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Discounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Discounts` (
  `idDiscount` INT NOT NULL AUTO_INCREMENT,
  `percent` INT(2) NOT NULL,
  `description` VARCHAR(100) NULL,
  `isSpecial` BIT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idDiscount`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Taxes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Taxes` (
  `idTax` INT NOT NULL AUTO_INCREMENT,
  `tax` VARCHAR(45) NOT NULL,
  `percent` INT(2) NOT NULL,
  `isGovernmental` BIT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idTax`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Bodies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Bodies` (
  `idBody` INT NOT NULL AUTO_INCREMENT,
  `Services_idService` INT NOT NULL,
  `subtotal` INT NOT NULL,
  `Taxes_idTax` INT NOT NULL,
  `Discounts_idDiscount` INT NOT NULL,
  `total` INT NOT NULL,
  PRIMARY KEY (`idBody`),
  INDEX `fk_Bodies_Services1_idx` (`Services_idService` ASC) ,
  INDEX `fk_Bodies_Discounts1_idx` (`Discounts_idDiscount` ASC) ,
  INDEX `fk_Bodies_Taxes1_idx` (`Taxes_idTax` ASC) ,
  CONSTRAINT `fk_Bodies_Services1`
    FOREIGN KEY (`Services_idService`)
    REFERENCES `TecnoExpress_Prequotations`.`Services` (`idService`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bodies_Discounts1`
    FOREIGN KEY (`Discounts_idDiscount`)
    REFERENCES `TecnoExpress_Prequotations`.`Discounts` (`idDiscount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bodies_Taxes1`
    FOREIGN KEY (`Taxes_idTax`)
    REFERENCES `TecnoExpress_Prequotations`.`Taxes` (`idTax`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`RequestsForm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`RequestsForm` (
  `idRequestForm` INT NOT NULL AUTO_INCREMENT,
  `request` VARCHAR(50) NOT NULL,
  `form` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idRequestForm`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Prequotations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Prequotations` (
  `idPrequotation` INT NOT NULL AUTO_INCREMENT,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` VARCHAR(20) NOT NULL,
  `Headers_idHeader` INT NOT NULL,
  `Bodies_idBody` INT NOT NULL,
  `conditions` TEXT NULL,
  `requirements` TEXT NULL,
  `RequestsForm_idRequestForm` INT NOT NULL,
  `isQuotation` BIT(1) NOT NULL,
  PRIMARY KEY (`idPrequotation`),
  INDEX `fk_Prequotations_Headers1_idx` (`Headers_idHeader` ASC) ,
  INDEX `fk_Prequotations_Bodies1_idx` (`Bodies_idBody` ASC) ,
  INDEX `fk_Prequotations_RequestsForm1_idx` (`RequestsForm_idRequestForm` ASC) ,
  CONSTRAINT `fk_Prequotations_Headers1`
    FOREIGN KEY (`Headers_idHeader`)
    REFERENCES `TecnoExpress_Prequotations`.`Headers` (`idHeader`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prequotations_Bodies1`
    FOREIGN KEY (`Bodies_idBody`)
    REFERENCES `TecnoExpress_Prequotations`.`Bodies` (`idBody`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prequotations_RequestsForm1`
    FOREIGN KEY (`RequestsForm_idRequestForm`)
    REFERENCES `TecnoExpress_Prequotations`.`RequestsForm` (`idRequestForm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`AuthorizingPersons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`AuthorizingPersons` (
  `idAuthorizingPerson` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `lastName` VARCHAR(20) NOT NULL,
  `role` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idAuthorizingPerson`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Prequotatios_has_AuthorizingPersons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Prequotatios_has_AuthorizingPersons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Prequotations_idPrequotation` INT NOT NULL,
  `AuthorizingPersons_idAuthorizingPerson` INT NOT NULL,
  `dateRequest` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateApproval` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateRealApproval` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prequotatios_has_AuthorizingPersons_AuthorizingPersons1_idx` (`AuthorizingPersons_idAuthorizingPerson` ASC) ,
  INDEX `fk_Prequotatios_has_AuthorizingPersons_Prequotations1_idx` (`Prequotations_idPrequotation` ASC) ,
  CONSTRAINT `fk_Prequotatios_has_AuthorizingPersons_AuthorizingPersons1`
    FOREIGN KEY (`AuthorizingPersons_idAuthorizingPerson`)
    REFERENCES `TecnoExpress_Prequotations`.`AuthorizingPersons` (`idAuthorizingPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prequotatios_has_AuthorizingPersons_Prequotations1`
    FOREIGN KEY (`Prequotations_idPrequotation`)
    REFERENCES `TecnoExpress_Prequotations`.`Prequotations` (`idPrequotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`TypesFiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`TypesFiles` (
  `idTypeFile` INT NOT NULL AUTO_INCREMENT,
  `typeFile` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`idTypeFile`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`UploadedFiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`UploadedFiles` (
  `idUploadedFile` INT NOT NULL AUTO_INCREMENT,
  `uploadName` VARCHAR(45) NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TypesFiles_idTypeFile` INT NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`idUploadedFile`),
  INDEX `fk_UploadFiles_TypesFiles1_idx` (`TypesFiles_idTypeFile` ASC) ,
  CONSTRAINT `fk_UploadFiles_TypesFiles1`
    FOREIGN KEY (`TypesFiles_idTypeFile`)
    REFERENCES `TecnoExpress_Prequotations`.`TypesFiles` (`idTypeFile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Plains`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Plains` (
  `idPlain` INT NOT NULL AUTO_INCREMENT,
  `plain` VARCHAR(45) NOT NULL,
  `UploadedFiles_idUploadedFile` INT NOT NULL,
  PRIMARY KEY (`idPlain`),
  INDEX `fk_Plains_UploadedFiles1_idx` (`UploadedFiles_idUploadedFile` ASC) ,
  CONSTRAINT `fk_Plains_UploadedFiles1`
    FOREIGN KEY (`UploadedFiles_idUploadedFile`)
    REFERENCES `TecnoExpress_Prequotations`.`UploadedFiles` (`idUploadedFile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`FilesDefault`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`FilesDefault` (
  `idFileDefault` INT NOT NULL AUTO_INCREMENT,
  `reference` TEXT NULL,
  `item` TEXT NULL,
  `quantity` TEXT NULL,
  `description` TEXT NULL,
  `unitValue` TEXT NULL,
  `totalValue` TEXT NULL,
  `additionalInfo` TEXT NULL,
  `UploadedFiles_idUploadedFile` INT NOT NULL,
  PRIMARY KEY (`idFileDefault`),
  INDEX `fk_FilesDefault_UploadedFiles1_idx` (`UploadedFiles_idUploadedFile` ASC) ,
  CONSTRAINT `fk_FilesDefault_UploadedFiles1`
    FOREIGN KEY (`UploadedFiles_idUploadedFile`)
    REFERENCES `TecnoExpress_Prequotations`.`UploadedFiles` (`idUploadedFile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Prequotations`.`Services_has_Prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Prequotations`.`Services_has_Prices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Services_idService` INT NOT NULL,
  `UploadedFiles_idUploadedFile` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Services_has_UploadedFiles_UploadedFiles1_idx` (`UploadedFiles_idUploadedFile` ASC) ,
  INDEX `fk_Services_has_UploadedFiles_Services1_idx` (`Services_idService` ASC) ,
  CONSTRAINT `fk_Services_has_UploadedFiles_Services1`
    FOREIGN KEY (`Services_idService`)
    REFERENCES `TecnoExpress_Prequotations`.`Services` (`idService`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Services_has_UploadedFiles_UploadedFiles1`
    FOREIGN KEY (`UploadedFiles_idUploadedFile`)
    REFERENCES `TecnoExpress_Prequotations`.`UploadedFiles` (`idUploadedFile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
