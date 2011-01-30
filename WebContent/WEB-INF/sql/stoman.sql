SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
CREATE SCHEMA IF NOT EXISTS `stoman` DEFAULT CHARACTER SET latin1 ;
USE `mydb` ;
USE `stoman` ;

-- -----------------------------------------------------
-- Table `stoman`.`addresses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`addresses` (
  `address_id` INT(11) NOT NULL ,
  `street_name_1` VARCHAR(45) NULL DEFAULT NULL ,
  `street_name_2` VARCHAR(45) NULL DEFAULT NULL ,
  `area` VARCHAR(45) NULL DEFAULT NULL ,
  `city` VARCHAR(45) NULL DEFAULT NULL ,
  `zip` INT(11) NULL DEFAULT NULL ,
  `state` VARCHAR(45) NULL DEFAULT NULL ,
  `country` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`address_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`materials`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`materials` (
  `material_id` INT(11) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `sensitivity` INT(11) NULL DEFAULT NULL ,
  `importance` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`material_id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`purchase_orders`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`purchase_orders` (
  `purchase_order_id` INT(11) NOT NULL ,
  PRIMARY KEY (`purchase_order_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`users` (
  `user_id` INT(11) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `role` VARCHAR(45) NOT NULL ,
  `address_id` INT(11) NULL DEFAULT NULL ,
  `created_on` DATETIME NOT NULL ,
  PRIMARY KEY (`user_id`) ,
  INDEX `fk_addresses_users` (`address_id` ASC) ,
  CONSTRAINT `fk_addresses_users`
    FOREIGN KEY (`address_id` )
    REFERENCES `stoman`.`addresses` (`address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`vendors`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`vendors` (
  `vendor_id` INT(11) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `address_id` INT(11) NULL DEFAULT '1' ,
  PRIMARY KEY (`vendor_id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `fk_addresses_vendors` (`address_id` ASC) ,
  CONSTRAINT `fk_addresses_vendors`
    FOREIGN KEY (`address_id` )
    REFERENCES `stoman`.`addresses` (`address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`vendor_materials`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`vendor_materials` (
  `vendor_material_id` INT(11) NOT NULL ,
  `vendor_id` INT(11) NOT NULL ,
  `material_id` INT(11) NOT NULL ,
  `price_start_date` DATETIME NOT NULL ,
  `modified_date` DATETIME NOT NULL ,
  `modified_by` INT(11) NOT NULL ,
  `max_qty_per_order` INT(11) NULL DEFAULT '65535' ,
  PRIMARY KEY (`vendor_material_id`) ,
  INDEX `fk_materials_vendor_materials` (`material_id` ASC) ,
  INDEX `fk_vendors_vendor_materials` (`vendor_id` ASC) ,
  INDEX `fk_users_vendor_materials` (`modified_by` ASC) ,
  CONSTRAINT `fk_materials_vendor_materials`
    FOREIGN KEY (`material_id` )
    REFERENCES `stoman`.`materials` (`material_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_vendor_materials`
    FOREIGN KEY (`modified_by` )
    REFERENCES `stoman`.`users` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_vendor_materials`
    FOREIGN KEY (`vendor_id` )
    REFERENCES `stoman`.`vendors` (`vendor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`purchase_materials`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`purchase_materials` (
  `purchase_material_id` INT(11) NOT NULL ,
  `purchase_order_id` INT(11) NOT NULL ,
  `date` DATETIME NOT NULL ,
  `vendor_material_id` INT(11) NOT NULL ,
  `ordered_quantity` INT(11) NOT NULL ,
  `received_quantity` INT(11) NOT NULL ,
  `created_by` INT(11) NOT NULL ,
  `modified_by` INT(11) NULL DEFAULT NULL ,
  `modified_date` INT(11) NULL DEFAULT NULL ,
  `due_date` DATETIME NULL DEFAULT NULL ,
  `delievered_date` DATETIME NULL DEFAULT NULL ,
  `cancelled_date` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`purchase_material_id`) ,
  INDEX `fk_purshase_orders_purshase_order_materials` (`purchase_order_id` ASC) ,
  INDEX `fk_vendor_materials_purchase_order_materials` (`vendor_material_id` ASC) ,
  INDEX `fk_users_purchase_materials` (`modified_by` ASC) ,
  CONSTRAINT `fk_purshase_orders_purshase_order_materials`
    FOREIGN KEY (`purchase_order_id` )
    REFERENCES `stoman`.`purchase_orders` (`purchase_order_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_purchase_materials`
    FOREIGN KEY (`modified_by` )
    REFERENCES `stoman`.`users` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendor_materials_purchase_order_materials`
    FOREIGN KEY (`vendor_material_id` )
    REFERENCES `stoman`.`vendor_materials` (`vendor_material_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`purchase_order_monitors`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`purchase_order_monitors` (
  `purchase_order_monitor_id` INT(11) NOT NULL ,
  `purchase_material_id` INT(11) NOT NULL ,
  `received_date` DATETIME NOT NULL ,
  `received_quantity` INT(11) NOT NULL ,
  `modified_date` DATETIME NOT NULL ,
  `modified_by` INT(11) NOT NULL ,
  PRIMARY KEY (`purchase_order_monitor_id`) ,
  INDEX `fk_purchase_materials_purchase_order_monitors` (`purchase_material_id` ASC) ,
  INDEX `fk_users_purchase_order_monitors` (`modified_by` ASC) ,
  CONSTRAINT `fk_purchase_materials_purchase_order_monitors`
    FOREIGN KEY (`purchase_material_id` )
    REFERENCES `stoman`.`purchase_materials` (`purchase_material_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_purchase_order_monitors`
    FOREIGN KEY (`modified_by` )
    REFERENCES `stoman`.`users` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`rank_archives`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`rank_archives` (
  `rank_archive_id` INT(11) NOT NULL ,
  `vendor_id` INT(11) NOT NULL ,
  `rank` INT(11) NOT NULL ,
  `expired_date` VARCHAR(45) NOT NULL ,
  `modified_by` INT(11) NOT NULL ,
  PRIMARY KEY (`rank_archive_id`) ,
  INDEX `fk_vendors_rank_archives` (`vendor_id` ASC) ,
  INDEX `fk_users_rank_archives` (`modified_by` ASC) ,
  CONSTRAINT `fk_users_rank_archives`
    FOREIGN KEY (`modified_by` )
    REFERENCES `stoman`.`users` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_rank_archives`
    FOREIGN KEY (`vendor_id` )
    REFERENCES `stoman`.`vendors` (`vendor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`ranks`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`ranks` (
  `rank_id` INT(11) NOT NULL ,
  `vendor_id` INT(11) NOT NULL ,
  `rank` INT(11) NOT NULL ,
  `trust_level` VARCHAR(45) NULL DEFAULT NULL ,
  `modified_date` DATETIME NOT NULL ,
  `modified_by` INT(11) NOT NULL ,
  PRIMARY KEY (`rank_id`) ,
  UNIQUE INDEX `vendor_id_UNIQUE` (`vendor_id` ASC) ,
  INDEX `fk_vendors_ranks` (`vendor_id` ASC) ,
  INDEX `fk_users_ranks` (`modified_by` ASC) ,
  CONSTRAINT `fk_users_ranks`
    FOREIGN KEY (`modified_by` )
    REFERENCES `stoman`.`users` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_ranks`
    FOREIGN KEY (`vendor_id` )
    REFERENCES `stoman`.`vendors` (`vendor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stoman`.`vendor_material_archives`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stoman`.`vendor_material_archives` (
  `vendor_material_archive_id` INT(11) NOT NULL ,
  `vendor_id` INT(11) NOT NULL ,
  `material_id` INT(11) NOT NULL ,
  `price_start_date` DATETIME NULL DEFAULT NULL ,
  `price_end_date` DATETIME NULL DEFAULT NULL ,
  `modified_date` DATETIME NOT NULL ,
  `modified_by` INT(11) NOT NULL ,
  PRIMARY KEY (`vendor_material_archive_id`) ,
  INDEX `fk_vendors_vendor_material_archives` (`vendor_id` ASC) ,
  INDEX `fk_materials_vendor_material_archives` (`material_id` ASC) ,
  INDEX `fk_users_vendor_material_archives` (`modified_by` ASC) ,
  CONSTRAINT `fk_materials_vendor_material_archives`
    FOREIGN KEY (`material_id` )
    REFERENCES `stoman`.`materials` (`material_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_vendor_material_archives`
    FOREIGN KEY (`modified_by` )
    REFERENCES `stoman`.`users` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_vendor_material_archives`
    FOREIGN KEY (`vendor_id` )
    REFERENCES `stoman`.`vendors` (`vendor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
