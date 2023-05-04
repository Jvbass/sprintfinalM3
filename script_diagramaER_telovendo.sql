/*								EVALUACION FINAL MODULO 3
							     “Te lo vendo” – Sprint
						Desarrollo Final del Módulo Bases de datos.
            
Nombres: Jorge Moraga C., Gustavo Ruiz S., Juan Pino C., Harold Klapp

	Script construido a partir del diagrama ER:
*/

-- A partir del diagrama, debemos construir un script que cree tablas de acuerdo a las entidades e ingrese datos.

/* El siguiente codigo fue generado desde el diagrama ER por la funcionalidad Forward Engineering practicada en clases.*/

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema telovendo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema telovendo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `telovendo` DEFAULT CHARACTER SET utf8mb4 ; -- cambiamos el charset por defecto utf8 por utf8mb4
USE `telovendo` ;

-- -----------------------------------------------------
-- Table `telovendo`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`Clientes` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) CHARACTER SET 'utf8mb4' NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `telovendo`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`proveedores` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_representante_legal` VARCHAR(45) NOT NULL,
  `nombre_corporativo` VARCHAR(45) NOT NULL,
  `nombre_contacto` VARCHAR(255) NOT NULL,
  `correo_electronico` VARCHAR(50) NOT NULL,
  `categoria_productos` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `telovendo`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `stock` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_producto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `telovendo`.`telefonos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`telefonos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(12) NOT NULL,
  `numero_contacto` VARCHAR(15) NOT NULL,
  `proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `proveedor_id_idx` (`proveedor_id` ASC) VISIBLE,
  CONSTRAINT `proveedor_id`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `telovendo`.`proveedores` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `telovendo`.`producto_proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`producto_proveedores` (
  `id_producto_proveedor` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `id_proveedor` INT NOT NULL,
  PRIMARY KEY (`id_producto_proveedor`),
  INDEX `id_proiducto_idx` (`id_producto` ASC) VISIBLE,
  INDEX `id_proveedores_idx` (`id_proveedor` ASC) VISIBLE,
  CONSTRAINT `id_proiducto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `telovendo`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_proveedores`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `telovendo`.`proveedores` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

