-- Version: 1.0

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema universidade
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema universidade
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universidade` DEFAULT CHARACTER SET utf8 ;
USE `universidade` ;

-- -----------------------------------------------------
-- Table `universidade`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`departamento` (
  `cod_departamento` INT NOT NULL,
  `nome_departamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_departamento`),
  UNIQUE INDEX `cod_departamento_UNIQUE` (`cod_departamento` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`professor` (
  `cod_professor` INT NOT NULL,
  `nome_professor` VARCHAR(45) NOT NULL,
  `sobrenome_professor` VARCHAR(45) NOT NULL,
  `status` TINYINT NOT NULL,
  `cod_departamento` INT NOT NULL,
  PRIMARY KEY (`cod_professor`),
  INDEX `cod_professor_idx` (`cod_departamento` ASC) VISIBLE,
  UNIQUE INDEX `cod_professor_UNIQUE` (`cod_professor` ASC) VISIBLE,
  CONSTRAINT `cod_professor`
    FOREIGN KEY (`cod_departamento`)
    REFERENCES `universidade`.`departamento` (`cod_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`curso` (
  `cod_curso` INT NOT NULL,
  `nome_curso` VARCHAR(45) NOT NULL,
  `cod_departamento` INT NOT NULL,
  PRIMARY KEY (`cod_curso`),
  INDEX `cod_departamento_idx` (`cod_departamento` ASC) VISIBLE,
  UNIQUE INDEX `cod_curso_UNIQUE` (`cod_curso` ASC) VISIBLE,
  CONSTRAINT `cod_departamento`
    FOREIGN KEY (`cod_departamento`)
    REFERENCES `universidade`.`departamento` (`cod_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`turma` (
  `cod_turma` INT NOT NULL,
  `num_alunos` INT NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NOT NULL,
  `cod_curso` INT NOT NULL,
  PRIMARY KEY (`cod_turma`),
  INDEX `cod_curso_idx` (`cod_curso` ASC) VISIBLE,
  UNIQUE INDEX `cod_turma_UNIQUE` (`cod_turma` ASC) VISIBLE,
  CONSTRAINT `cod_curso`
    FOREIGN KEY (`cod_curso`)
    REFERENCES `universidade`.`curso` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`disciplina` (
  `cod_disciplina` INT NOT NULL,
  `nome_disciplina` VARCHAR(45) NOT NULL,
  `descricao_disciplina` VARCHAR(60) NOT NULL,
  `carga_horaria` INT NOT NULL,
  `num_alunos_disciplina` INT NOT NULL,
  `cod_departamento` INT NOT NULL,
  PRIMARY KEY (`cod_disciplina`),
  UNIQUE INDEX `cod_disciplina_UNIQUE` (`cod_disciplina` ASC) VISIBLE,
  INDEX `cod_departamento_idx` (`cod_departamento` ASC) VISIBLE,
  CONSTRAINT `cod_departamento`
    FOREIGN KEY (`cod_departamento`)
    REFERENCES `universidade`.`departamento` (`cod_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`professor_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`professor_disciplina` (
  `cod_professor` INT NOT NULL,
  `cod_disciplina` INT NOT NULL,
  INDEX `cod_professor_idx` (`cod_professor` ASC) VISIBLE,
  INDEX `cod_disciplina_idx` (`cod_disciplina` ASC) VISIBLE,
  PRIMARY KEY (`cod_professor`, `cod_disciplina`),
  CONSTRAINT `cod_professor`
    FOREIGN KEY (`cod_professor`)
    REFERENCES `universidade`.`professor` (`cod_professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_disciplina`
    FOREIGN KEY (`cod_disciplina`)
    REFERENCES `universidade`.`disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`curso_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`curso_disciplina` (
  `cod_curso` INT NOT NULL,
  `cod_disciplina` INT NOT NULL,
  INDEX `cod_curso_idx` (`cod_curso` ASC) VISIBLE,
  INDEX `cod_disciplina_idx` (`cod_disciplina` ASC) VISIBLE,
  PRIMARY KEY (`cod_curso`, `cod_disciplina`),
  CONSTRAINT `cod_curso`
    FOREIGN KEY (`cod_curso`)
    REFERENCES `universidade`.`curso` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_disciplina`
    FOREIGN KEY (`cod_disciplina`)
    REFERENCES `universidade`.`disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`aluno` (
  `RA` INT NOT NULL,
  `nome_aluno` VARCHAR(45) NOT NULL,
  `sobrenome_aluno` VARCHAR(45) NOT NULL,
  `cpf_aluno` VARCHAR(14) NOT NULL,
  `sexo_aluno` VARCHAR(11) NOT NULL,
  `status_aluno` TINYINT NOT NULL,
  `cod_curso` INT NOT NULL,
  `cod_turma` INT NOT NULL,
  PRIMARY KEY (`RA`),
  UNIQUE INDEX `idaluno_UNIQUE` (`RA` ASC) VISIBLE,
  INDEX `cod_curso_idx` (`cod_curso` ASC) VISIBLE,
  INDEX `cod_turma_idx` (`cod_turma` ASC) VISIBLE,
  CONSTRAINT `cod_curso`
    FOREIGN KEY (`cod_curso`)
    REFERENCES `universidade`.`curso` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_turma`
    FOREIGN KEY (`cod_turma`)
    REFERENCES `universidade`.`turma` (`cod_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`aluno_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`aluno_disciplina` (
  `RA` INT NOT NULL,
  `cod_disciplina` INT NOT NULL,
  INDEX `RA_idx` (`RA` ASC) VISIBLE,
  INDEX `cod_disciplina_idx` (`cod_disciplina` ASC) VISIBLE,
  PRIMARY KEY (`RA`, `cod_disciplina`),
  CONSTRAINT `RA`
    FOREIGN KEY (`RA`)
    REFERENCES `universidade`.`aluno` (`RA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_disciplina`
    FOREIGN KEY (`cod_disciplina`)
    REFERENCES `universidade`.`disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`endereco_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`endereco_aluno` (
  `RA` INT NOT NULL,
  `logradouro` VARCHAR(60) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `uf` VARCHAR(30) NOT NULL,
  INDEX `RA_idx` (`RA` ASC) VISIBLE,
  PRIMARY KEY (`RA`),
  CONSTRAINT `RA`
    FOREIGN KEY (`RA`)
    REFERENCES `universidade`.`aluno` (`RA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`contato_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`contato_aluno` (
  `RA` INT NOT NULL,
  `telefone_aluno` VARCHAR(15) NOT NULL,
  `email_aluno` VARCHAR(45) NOT NULL,
  INDEX `RA_idx` (`RA` ASC) VISIBLE,
  PRIMARY KEY (`RA`),
  CONSTRAINT `RA`
    FOREIGN KEY (`RA`)
    REFERENCES `universidade`.`aluno` (`RA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`historico` (
  `cod_historico` INT NOT NULL,
  `media` FLOAT NOT NULL,
  `periodo_inicial` DATE NOT NULL,
  `periodo_final` DATE NOT NULL,
  `RA` INT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  UNIQUE INDEX `cod_historico_UNIQUE` (`cod_historico` ASC) VISIBLE,
  INDEX `RA_idx` (`RA` ASC) VISIBLE,
  CONSTRAINT `RA`
    FOREIGN KEY (`RA`)
    REFERENCES `universidade`.`aluno` (`RA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidade`.`disciplina_historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidade`.`disciplina_historico` (
  `cod_historico` INT NOT NULL,
  `cod_disciplina` INT NOT NULL,
  `nota` FLOAT NOT NULL,
  `frequencia` FLOAT NOT NULL,
  INDEX `cod_historico_idx` (`cod_historico` ASC) VISIBLE,
  INDEX `cod_disciplina_idx` (`cod_disciplina` ASC) VISIBLE,
  PRIMARY KEY (`cod_historico`, `cod_disciplina`),
  CONSTRAINT `cod_historico`
    FOREIGN KEY (`cod_historico`)
    REFERENCES `universidade`.`historico` (`cod_historico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_disciplina`
    FOREIGN KEY (`cod_disciplina`)
    REFERENCES `universidade`.`disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
