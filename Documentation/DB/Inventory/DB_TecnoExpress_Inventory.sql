-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TecnoExpress_Inventory
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TecnoExpress_Inventory
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TecnoExpress_Inventory` DEFAULT CHARACTER SET utf8 ;
USE `TecnoExpress_Inventory` ;

-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Trademarks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Trademarks` (
  `idTrademark` INT NOT NULL AUTO_INCREMENT,
  `trademark` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idTrademark`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Categories` (
  `idCategory` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `state` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Products` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `reference` VARCHAR(45) NOT NULL,
  `product` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `salePrice` INT NOT NULL,
  `purchasePrice` INT NOT NULL,
  `Trademarks_idTrademark` INT NOT NULL,
  `state` BIT(1) NOT NULL,
  `weight` DOUBLE NULL,
  `localIdentifier` VARCHAR(45) NOT NULL,
  `localDescription` VARCHAR(45) NOT NULL,
  `Categories_idCategory` INT NOT NULL,
  PRIMARY KEY (`idProduct`),
  INDEX `fk_Products_Trademarks1_idx` (`Trademarks_idTrademark` ASC) ,
  INDEX `fk_Products_Categories1_idx` (`Categories_idCategory` ASC) ,
  CONSTRAINT `fk_Products_Trademarks1`
    FOREIGN KEY (`Trademarks_idTrademark`)
    REFERENCES `TecnoExpress_Inventory`.`Trademarks` (`idTrademark`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_Categories1`
    FOREIGN KEY (`Categories_idCategory`)
    REFERENCES `TecnoExpress_Inventory`.`Categories` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Stock` (
  `idStock` INT NOT NULL AUTO_INCREMENT,
  `MinimuAmount` INT NOT NULL,
  `actualAmount` INT NOT NULL,
  `Products_idProduct` INT NOT NULL,
  PRIMARY KEY (`idStock`),
  INDEX `fk_Stock_Products1_idx` (`Products_idProduct` ASC) ,
  CONSTRAINT `fk_Stock_Products1`
    FOREIGN KEY (`Products_idProduct`)
    REFERENCES `TecnoExpress_Inventory`.`Products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Suppliers` (
  `idSupplier` INT NOT NULL AUTO_INCREMENT,
  `tradeName` VARCHAR(120) NOT NULL,
  `typeId` VARCHAR(3) NOT NULL,
  `numberId` VARCHAR(12) NOT NULL,
  `description` TEXT NULL,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSupplier`),
  UNIQUE INDEX `tradeName_UNIQUE` (`tradeName` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`PurchaseOrders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`PurchaseOrders` (
  `idPurchaseOrder` INT NOT NULL AUTO_INCREMENT,
  `Suppliers_idSupplier` INT NOT NULL,
  `datePurchase` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` BIT(1) NOT NULL,
  `description` TEXT NULL,
  `dateStockEntry` TIMESTAMP NULL,
  `descriptionStockEntry` TEXT NULL,
  `stateStockEntry` VARCHAR(45) NULL,
  PRIMARY KEY (`idPurchaseOrder`),
  INDEX `fk_PurchaseOrders_Suppliers1_idx` (`Suppliers_idSupplier` ASC) ,
  CONSTRAINT `fk_PurchaseOrders_Suppliers1`
    FOREIGN KEY (`Suppliers_idSupplier`)
    REFERENCES `TecnoExpress_Inventory`.`Suppliers` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`PositionsSuppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`PositionsSuppliers` (
  `idPositionSupplier` INT NOT NULL AUTO_INCREMENT,
  `position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPositionSupplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`DivisionsSuppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`DivisionsSuppliers` (
  `idDivisionsSupplier` INT NOT NULL AUTO_INCREMENT,
  `division` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDivisionsSupplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Divisions_has_Positions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Divisions_has_Positions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `DivisionsSuppliers_idDivisionsSupplier` INT NOT NULL,
  `PositionsSuppliers_idPositionSupplier` INT NOT NULL,
  `state` BIT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Divisions_has_Positions_PositionsSuppliers1_idx` (`PositionsSuppliers_idPositionSupplier` ASC) ,
  INDEX `fk_Divisions_has_Positions_DivisionsSuppliers1_idx` (`DivisionsSuppliers_idDivisionsSupplier` ASC) ,
  CONSTRAINT `fk_Divisions_has_Positions_PositionsSuppliers1`
    FOREIGN KEY (`PositionsSuppliers_idPositionSupplier`)
    REFERENCES `TecnoExpress_Inventory`.`PositionsSuppliers` (`idPositionSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Divisions_has_Positions_DivisionsSuppliers1`
    FOREIGN KEY (`DivisionsSuppliers_idDivisionsSupplier`)
    REFERENCES `TecnoExpress_Inventory`.`DivisionsSuppliers` (`idDivisionsSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`ContactsSupplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`ContactsSupplier` (
  `idContactSupplier` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `lastName` VARCHAR(20) NOT NULL,
  `numberId` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idContactSupplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Phones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Phones` (
  `idPhone` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(15) NOT NULL,
  `ext` VARCHAR(5) NULL,
  `mobile` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPhone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Addresses` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(100) NOT NULL,
  `additional` VARCHAR(100) NULL,
  `country` VARCHAR(45) NOT NULL,
  `deparment` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`InfoContactsSupplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`InfoContactsSupplier` (
  `idInfoContactSupplier` INT NOT NULL AUTO_INCREMENT,
  `Divisions_has_Positions_id` INT NOT NULL,
  `ContactsSupplier_idContactSupplier` INT NOT NULL,
  `Phones_idPhone` INT NOT NULL,
  `Addresses_idAddress` INT NOT NULL,
  PRIMARY KEY (`idInfoContactSupplier`),
  INDEX `fk_InfoContactsSupplier_Divisions_has_Positions1_idx` (`Divisions_has_Positions_id` ASC) ,
  INDEX `fk_InfoContactsSupplier_ContactsSupplier1_idx` (`ContactsSupplier_idContactSupplier` ASC) ,
  INDEX `fk_InfoContactsSupplier_Phones1_idx` (`Phones_idPhone` ASC) ,
  INDEX `fk_InfoContactsSupplier_Addresses1_idx` (`Addresses_idAddress` ASC) ,
  CONSTRAINT `fk_InfoContactsSupplier_Divisions_has_Positions1`
    FOREIGN KEY (`Divisions_has_Positions_id`)
    REFERENCES `TecnoExpress_Inventory`.`Divisions_has_Positions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InfoContactsSupplier_ContactsSupplier1`
    FOREIGN KEY (`ContactsSupplier_idContactSupplier`)
    REFERENCES `TecnoExpress_Inventory`.`ContactsSupplier` (`idContactSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InfoContactsSupplier_Phones1`
    FOREIGN KEY (`Phones_idPhone`)
    REFERENCES `TecnoExpress_Inventory`.`Phones` (`idPhone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InfoContactsSupplier_Addresses1`
    FOREIGN KEY (`Addresses_idAddress`)
    REFERENCES `TecnoExpress_Inventory`.`Addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Inventory_has_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Inventory_has_Products` (
  `Inventory_idInventory` INT NOT NULL,
  `Products_idProduct` INT NOT NULL,
  PRIMARY KEY (`Inventory_idInventory`, `Products_idProduct`),
  INDEX `fk_Inventory_has_Products_Products1_idx` (`Products_idProduct` ASC) ,
  CONSTRAINT `fk_Inventory_has_Products_Products1`
    FOREIGN KEY (`Products_idProduct`)
    REFERENCES `TecnoExpress_Inventory`.`Products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Dispatches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Dispatches` (
  `idDispatch` INT NOT NULL AUTO_INCREMENT,
  `reference` VARCHAR(45) NOT NULL,
  `dateDispatch` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idCustomer` INT NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idDispatch`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`Suppliers_has_InfoContactsSupplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`Suppliers_has_InfoContactsSupplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Suppliers_idSupplier` INT NOT NULL,
  `InfoContactsSupplier_idInfoContactSupplier` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Suppliers_has_InfoContactsSupplier_InfoContactsSupplier1_idx` (`InfoContactsSupplier_idInfoContactSupplier` ASC) ,
  INDEX `fk_Suppliers_has_InfoContactsSupplier_Suppliers1_idx` (`Suppliers_idSupplier` ASC) ,
  CONSTRAINT `fk_Suppliers_has_InfoContactsSupplier_Suppliers1`
    FOREIGN KEY (`Suppliers_idSupplier`)
    REFERENCES `TecnoExpress_Inventory`.`Suppliers` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Suppliers_has_InfoContactsSupplier_InfoContactsSupplier1`
    FOREIGN KEY (`InfoContactsSupplier_idInfoContactSupplier`)
    REFERENCES `TecnoExpress_Inventory`.`InfoContactsSupplier` (`idInfoContactSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`PurchaseOrders_has_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`PurchaseOrders_has_Products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `PurchaseOrders_idPurchaseOrder` INT NOT NULL,
  `Products_idProduct` INT NOT NULL,
  `orderUnits` INT NOT NULL,
  INDEX `fk_PurchaseOrders_has_Products_Products1_idx` (`Products_idProduct` ASC) ,
  PRIMARY KEY (`id`),
  INDEX `fk_PurchaseOrders_has_Products_PurchaseOrders1_idx` (`PurchaseOrders_idPurchaseOrder` ASC) ,
  CONSTRAINT `fk_PurchaseOrders_has_Products_Products1`
    FOREIGN KEY (`Products_idProduct`)
    REFERENCES `TecnoExpress_Inventory`.`Products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PurchaseOrders_has_Products_PurchaseOrders1`
    FOREIGN KEY (`PurchaseOrders_idPurchaseOrder`)
    REFERENCES `TecnoExpress_Inventory`.`PurchaseOrders` (`idPurchaseOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TecnoExpress_Inventory`.`PurchaseOrders_has_Dispatches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TecnoExpress_Inventory`.`PurchaseOrders_has_Dispatches` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `PurchaseOrders_idPurchaseOrder` INT NOT NULL,
  `Dispatches_idDispatch` INT NOT NULL,
  INDEX `fk_PurchaseOrders_has_Dispatches_Dispatches1_idx` (`Dispatches_idDispatch` ASC) ,
  INDEX `fk_PurchaseOrders_has_Dispatches_PurchaseOrders1_idx` (`PurchaseOrders_idPurchaseOrder` ASC) ,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_PurchaseOrders_has_Dispatches_PurchaseOrders1`
    FOREIGN KEY (`PurchaseOrders_idPurchaseOrder`)
    REFERENCES `TecnoExpress_Inventory`.`PurchaseOrders` (`idPurchaseOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PurchaseOrders_has_Dispatches_Dispatches1`
    FOREIGN KEY (`Dispatches_idDispatch`)
    REFERENCES `TecnoExpress_Inventory`.`Dispatches` (`idDispatch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
