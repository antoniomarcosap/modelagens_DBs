-- Version: 1.0

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fabrica_picoles
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fabrica_picoles
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fabrica_picoles` DEFAULT CHARACTER SET utf8 ;
USE `fabrica_picoles` ;

-- -----------------------------------------------------
-- Table `fabrica_picoles`.`sabores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`sabores` (
  `id_sabores` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_sabores`),
  UNIQUE INDEX `id_sabores_UNIQUE` (`id_sabores` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`tipos_embalagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`tipos_embalagem` (
  `id_tipo_emabalagem` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_tipo_emabalagem`),
  UNIQUE INDEX `id_tipo_emabalagem_UNIQUE` (`id_tipo_emabalagem` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`tipos_picoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`tipos_picoles` (
  `id_tipo_picoles` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_tipo_picoles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`picoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`picoles` (
  `id_picoles` INT NOT NULL AUTO_INCREMENT,
  `preco` DECIMAL(4,2) NOT NULL,
  `id_sabor` INT NOT NULL,
  `id_tipo_embalagem` INT NOT NULL,
  `id_tipo_picole` INT NOT NULL,
  PRIMARY KEY (`id_picoles`),
  INDEX `fk_picoles_1_idx` (`id_sabor` ASC) VISIBLE,
  INDEX `fk_picoles_2_idx` (`id_tipo_embalagem` ASC) VISIBLE,
  INDEX `fk_picoles_3_idx` (`id_tipo_picole` ASC) VISIBLE,
  UNIQUE INDEX `id_picoles_UNIQUE` (`id_picoles` ASC) VISIBLE,
  CONSTRAINT `fk_picoles_1`
    FOREIGN KEY (`id_sabor`)
    REFERENCES `fabrica_picoles`.`sabores` (`id_sabores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picoles_2`
    FOREIGN KEY (`id_tipo_embalagem`)
    REFERENCES `fabrica_picoles`.`tipos_embalagem` (`id_tipo_emabalagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picoles_3`
    FOREIGN KEY (`id_tipo_picole`)
    REFERENCES `fabrica_picoles`.`tipos_picoles` (`id_tipo_picoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`ingredientes` (
  `id_ingredientes` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_ingredientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`ingredientes_picole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`ingredientes_picole` (
  `id_ingredientes_picole` INT NOT NULL AUTO_INCREMENT,
  `id_ingredientes` INT NOT NULL,
  `id_picole` INT NOT NULL,
  PRIMARY KEY (`id_ingredientes_picole`),
  INDEX `fk_ingredientes_picole_1_idx` (`id_ingredientes` ASC) VISIBLE,
  INDEX `fk_ingredientes_picole_2_idx` (`id_picole` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_picole_1`
    FOREIGN KEY (`id_ingredientes`)
    REFERENCES `fabrica_picoles`.`ingredientes` (`id_ingredientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_picole_2`
    FOREIGN KEY (`id_picole`)
    REFERENCES `fabrica_picoles`.`picoles` (`id_picoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`aditivos_nutritivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`aditivos_nutritivos` (
  `id_aditivos_nutritivos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `formula_quimica` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_aditivos_nutritivos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`aditivos_nutritivos_picole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`aditivos_nutritivos_picole` (
  `id_aditivos_nutritivos_picole` INT NOT NULL AUTO_INCREMENT,
  `id_aditivo_nutritivo` INT NOT NULL,
  `id_picole` INT NOT NULL,
  PRIMARY KEY (`id_aditivos_nutritivos_picole`),
  INDEX `fk_aditivos_nutritivos_picole_1_idx` (`id_aditivo_nutritivo` ASC) VISIBLE,
  INDEX `fk_aditivos_nutritivos_picole_2_idx` (`id_picole` ASC) VISIBLE,
  CONSTRAINT `fk_aditivos_nutritivos_picole_1`
    FOREIGN KEY (`id_aditivo_nutritivo`)
    REFERENCES `fabrica_picoles`.`aditivos_nutritivos` (`id_aditivos_nutritivos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aditivos_nutritivos_picole_2`
    FOREIGN KEY (`id_picole`)
    REFERENCES `fabrica_picoles`.`picoles` (`id_picoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`conservantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`conservantes` (
  `id_conservantes` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_conservantes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`conservantes_picoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`conservantes_picoles` (
  `id_conservantes_picoles` INT NOT NULL AUTO_INCREMENT,
  `id_conservante` INT NOT NULL,
  `id_picole` INT NOT NULL,
  PRIMARY KEY (`id_conservantes_picoles`),
  INDEX `fk_conservantes_picoles_1_idx` (`id_conservante` ASC) VISIBLE,
  INDEX `fk_conservantes_picoles_2_idx` (`id_picole` ASC) VISIBLE,
  CONSTRAINT `fk_conservantes_picoles_1`
    FOREIGN KEY (`id_conservante`)
    REFERENCES `fabrica_picoles`.`conservantes` (`id_conservantes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conservantes_picoles_2`
    FOREIGN KEY (`id_picole`)
    REFERENCES `fabrica_picoles`.`picoles` (`id_picoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`lotes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`lotes` (
  `id_lotes` INT NOT NULL AUTO_INCREMENT,
  `id_tipo_picole` INT NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id_lotes`),
  INDEX `fk_lotes_1_idx` (`id_tipo_picole` ASC) VISIBLE,
  CONSTRAINT `fk_lotes_1`
    FOREIGN KEY (`id_tipo_picole`)
    REFERENCES `fabrica_picoles`.`tipos_picoles` (`id_tipo_picoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`revendedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`revendedores` (
  `id_revendedores` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(14) NOT NULL,
  `razao_social` VARCHAR(50) NOT NULL,
  `contato` VARCHAR(50) NOT NULL,
  `revendedorcol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_revendedores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`notas_fiscais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`notas_fiscais` (
  `id_notas_fiscais` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `numero_serie` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(80) NOT NULL,
  `id_revendedor` INT NOT NULL,
  PRIMARY KEY (`id_notas_fiscais`),
  INDEX `fk_notas_fiscais_1_idx` (`id_revendedor` ASC) VISIBLE,
  CONSTRAINT `fk_notas_fiscais_1`
    FOREIGN KEY (`id_revendedor`)
    REFERENCES `fabrica_picoles`.`revendedores` (`id_revendedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`lotes_nota_fiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`lotes_nota_fiscal` (
  `id_lotes_nota_fiscal` INT NOT NULL AUTO_INCREMENT,
  `id_lote` INT NOT NULL,
  `id_nota_fiscal` INT NOT NULL,
  PRIMARY KEY (`id_lotes_nota_fiscal`),
  INDEX `fk_lotes_nota_fiscal_1_idx` (`id_lote` ASC) VISIBLE,
  INDEX `fk_lotes_nota_fiscal_2_idx` (`id_nota_fiscal` ASC) VISIBLE,
  CONSTRAINT `fk_lotes_nota_fiscal_1`
    FOREIGN KEY (`id_lote`)
    REFERENCES `fabrica_picoles`.`lotes` (`id_lotes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lotes_nota_fiscal_2`
    FOREIGN KEY (`id_nota_fiscal`)
    REFERENCES `fabrica_picoles`.`notas_fiscais` (`id_notas_fiscais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
