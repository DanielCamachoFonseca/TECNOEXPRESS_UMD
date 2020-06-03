-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TecnoExpress_Users
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TecnoExpress_Users
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TecnoExpress_Users` DEFAULT CHARACTER SET utf8 ;
USE `TecnoExpress_Users` ;

-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`IdTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`IdTypes` (
  `idType` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(5) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Phones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Phones` (
  `idPhone` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(5) NOT NULL,
  `number` VARCHAR(15) NOT NULL,
  `ext` VARCHAR(5) NULL,
  `type` VARCHAR(10) NULL,
  PRIMARY KEY (`idPhone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`InfoUsers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`InfoUsers` (
  `idInfoUser` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  `secondName` VARCHAR(20) NULL,
  `lastName` VARCHAR(40) NOT NULL,
  `secondLastName` VARCHAR(20) NOT NULL,
  `IdTypes_idType` INT NOT NULL,
  `numberId` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `Phones_idPhone` INT NOT NULL,
  PRIMARY KEY (`idInfoUser`),
  INDEX `fk_InfoUsers_IdTypes1_idx` (`IdTypes_idType` ASC) ,
  INDEX `fk_InfoUsers_Phones1_idx` (`Phones_idPhone` ASC) ,
  CONSTRAINT `fk_InfoUsers_IdTypes1`
    FOREIGN KEY (`IdTypes_idType`)
    REFERENCES `TecnoExpress_Users`.`IdTypes` (`idType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InfoUsers_Phones1`
    FOREIGN KEY (`Phones_idPhone`)
    REFERENCES `TecnoExpress_Users`.`Phones` (`idPhone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`UserGroups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`UserGroups` (
  `idUserGroup` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `visible` BIT(1) NOT NULL,
  PRIMARY KEY (`idUserGroup`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Roles` (
  `idRole` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(20) NOT NULL,
  `visible` BIT(1) NOT NULL,
  `UserGroups_idUserGroup` INT NOT NULL,
  PRIMARY KEY (`idRole`),
  INDEX `fk_Roles_UserGroups1_idx` (`UserGroups_idUserGroup` ASC) ,
  CONSTRAINT `fk_Roles_UserGroups1`
    FOREIGN KEY (`UserGroups_idUserGroup`)
    REFERENCES `TecnoExpress_Users`.`UserGroups` (`idUserGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Users` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(20) NOT NULL,
  `password` VARCHAR(64) NOT NULL,
  `token` VARCHAR(64) NOT NULL,
  `InfoUsers_idInfoUser` INT NOT NULL,
  `Roles_idRole` INT NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `userName_UNIQUE` (`userName` ASC) ,
  INDEX `fk_Users_InfoUsers1_idx` (`InfoUsers_idInfoUser` ASC) ,
  INDEX `fk_Users_Roles1_idx` (`Roles_idRole` ASC) ,
  CONSTRAINT `fk_Users_InfoUsers1`
    FOREIGN KEY (`InfoUsers_idInfoUser`)
    REFERENCES `TecnoExpress_Users`.`InfoUsers` (`idInfoUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_Roles1`
    FOREIGN KEY (`Roles_idRole`)
    REFERENCES `TecnoExpress_Users`.`Roles` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Permissions` (
  `idPermission` INT NOT NULL AUTO_INCREMENT,
  `typePermission` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPermission`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Menus` (
  `idMenu` INT NOT NULL AUTO_INCREMENT,
  `menu` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `url` VARCHAR(100) NOT NULL,
  `order` INT(3) NOT NULL,
  PRIMARY KEY (`idMenu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Submenus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Submenus` (
  `idSubmenu` INT NOT NULL AUTO_INCREMENT,
  `Menus_idMenu` INT NOT NULL,
  `submenu` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `url` VARCHAR(100) NOT NULL,
  `order` INT(3) NOT NULL,
  PRIMARY KEY (`idSubmenu`),
  INDEX `fk_Submenus_Menus1_idx` (`Menus_idMenu` ASC) ,
  CONSTRAINT `fk_Submenus_Menus1`
    FOREIGN KEY (`Menus_idMenu`)
    REFERENCES `TecnoExpress_Users`.`Menus` (`idMenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`ExchageTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`ExchageTypes` (
  `idExchageType` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`idExchageType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Logs` (
  `idLog` INT NOT NULL AUTO_INCREMENT,
  `module` VARCHAR(100) NOT NULL,
  `previousRecord` TEXT NULL,
  `newRecord` TEXT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ExchageTypes_idExchageType` INT NOT NULL,
  `previousRecordJSON` JSON NULL,
  `newRecordJSON` JSON NULL,
  PRIMARY KEY (`idLog`),
  INDEX `fk_Logs_ExchageTypes1_idx` (`ExchageTypes_idExchageType` ASC) ,
  CONSTRAINT `fk_Logs_ExchageTypes1`
    FOREIGN KEY (`ExchageTypes_idExchageType`)
    REFERENCES `TecnoExpress_Users`.`ExchageTypes` (`idExchageType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Users_has_Logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Users_has_Logs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Users_idUser` INT NOT NULL,
  `Logs_idLog` INT NOT NULL,
  INDEX `fk_Users_has_Logs_Logs1_idx` (`Logs_idLog` ASC) ,
  INDEX `fk_Users_has_Logs_Users1_idx` (`Users_idUser` ASC) ,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Users_has_Logs_Users1`
    FOREIGN KEY (`Users_idUser`)
    REFERENCES `TecnoExpress_Users`.`Users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Logs_Logs1`
    FOREIGN KEY (`Logs_idLog`)
    REFERENCES `TecnoExpress_Users`.`Logs` (`idLog`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Modules` (
  `idModule` INT NOT NULL AUTO_INCREMENT,
  `module` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idModule`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Reports` (
  `idReport` INT NOT NULL AUTO_INCREMENT,
  `report` VARCHAR(100) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `Modules_idModule` INT NOT NULL,
  PRIMARY KEY (`idReport`),
  INDEX `fk_Reports_Modules1_idx` (`Modules_idModule` ASC) ,
  CONSTRAINT `fk_Reports_Modules1`
    FOREIGN KEY (`Modules_idModule`)
    REFERENCES `TecnoExpress_Users`.`Modules` (`idModule`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Users_has_Reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Users_has_Reports` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Users_idUser` INT NOT NULL,
  `Reports_idReport` INT NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_Users_has_Reports_Reports1_idx` (`Reports_idReport` ASC) ,
  INDEX `fk_Users_has_Reports_Users1_idx` (`Users_idUser` ASC) ,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Users_has_Reports_Users1`
    FOREIGN KEY (`Users_idUser`)
    REFERENCES `TecnoExpress_Users`.`Users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Reports_Reports1`
    FOREIGN KEY (`Reports_idReport`)
    REFERENCES `TecnoExpress_Users`.`Reports` (`idReport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Tasks` (
  `idTask` INT NOT NULL AUTO_INCREMENT,
  `purpose` TEXT NOT NULL,
  `dateStay` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateSolution` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `task` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTask`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Surveys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Surveys` (
  `idSurvey` INT NOT NULL,
  `Homeworks_idHomework` INT NOT NULL,
  `serviceScore` INT NOT NULL,
  `attentionScore` INT NOT NULL,
  `efficiencyScore` INT NOT NULL,
  PRIMARY KEY (`idSurvey`),
  INDEX `fk_Surveys_Homeworks1_idx` (`Homeworks_idHomework` ASC) ,
  CONSTRAINT `fk_Surveys_Homeworks1`
    FOREIGN KEY (`Homeworks_idHomework`)
    REFERENCES `TecnoExpress_Users`.`Tasks` (`idTask`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`Users_has_Tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`Users_has_Tasks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Users_idUser` INT NOT NULL,
  `Tasks_idTask` INT NOT NULL,
  `Boards_idBoard` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Users_has_Tasks_Tasks1_idx` (`Tasks_idTask` ASC) ,
  INDEX `fk_Users_has_Tasks_Users1_idx` (`Users_idUser` ASC) ,
  CONSTRAINT `fk_Users_has_Tasks_Users1`
    FOREIGN KEY (`Users_idUser`)
    REFERENCES `TecnoExpress_Users`.`Users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Tasks_Tasks1`
    FOREIGN KEY (`Tasks_idTask`)
    REFERENCES `TecnoExpress_Users`.`Tasks` (`idTask`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`UserGroups_has_Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`UserGroups_has_Permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `UserGroups_idUserGroup` INT NOT NULL,
  `Permissions_idPermission` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_UserGroups_has_Permissions_Permissions1_idx` (`Permissions_idPermission` ASC) ,
  INDEX `fk_UserGroups_has_Permissions_UserGroups1_idx` (`UserGroups_idUserGroup` ASC) ,
  CONSTRAINT `fk_UserGroups_has_Permissions_UserGroups1`
    FOREIGN KEY (`UserGroups_idUserGroup`)
    REFERENCES `TecnoExpress_Users`.`UserGroups` (`idUserGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserGroups_has_Permissions_Permissions1`
    FOREIGN KEY (`Permissions_idPermission`)
    REFERENCES `TecnoExpress_Users`.`Permissions` (`idPermission`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Users`.`UserGroups_has_Submenus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Users`.`UserGroups_has_Submenus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `UserGroups_idUserGroup` INT NOT NULL,
  `Submenus_idSubmenu` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_UserGroups_has_Submenus_Submenus1_idx` (`Submenus_idSubmenu` ASC) ,
  INDEX `fk_UserGroups_has_Submenus_UserGroups1_idx` (`UserGroups_idUserGroup` ASC) ,
  CONSTRAINT `fk_UserGroups_has_Submenus_UserGroups1`
    FOREIGN KEY (`UserGroups_idUserGroup`)
    REFERENCES `TecnoExpress_Users`.`UserGroups` (`idUserGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserGroups_has_Submenus_Submenus1`
    FOREIGN KEY (`Submenus_idSubmenu`)
    REFERENCES `TecnoExpress_Users`.`Submenus` (`idSubmenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
