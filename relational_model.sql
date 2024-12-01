- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pais` (
`idPais` INT NOT NULL,
`nmPais` VARCHAR(45) NOT NULL,
PRIMARY KEY (`idPais`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Gravadora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gravadora` (
`idGravadora` INT NOT NULL,
`nmGravadora` VARCHAR(45) NOT NULL,
`idPaisOrigem` INT NOT NULL,
PRIMARY KEY (`idGravadora`),
INDEX `fk_Gravadora_Pais_idx` (`idPaisOrigem` ASC) VISIBLE,
CONSTRAINT `fk_Gravadora_Pais`
    FOREIGN KEY (`idPaisOrigem`)
    REFERENCES `mydb`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`GeneroMusical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GeneroMusical` (
`idGeneroMusical` INT NOT NULL,
`descGeneroMusical` VARCHAR(45) NOT NULL,
PRIMARY KEY (`idGeneroMusical`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Album` (
`idAlbum` INT NOT NULL,
`nmAlbum` VARCHAR(45) NOT NULL,
PRIMARY KEY (`idAlbum`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Musica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Musica` (
`idMusica` INT NOT NULL,
`nmMusica` VARCHAR(45) NOT NULL,
`durancao` INT NOT NULL,
`idCategoria` INT NOT NULL,
`Album_idAlbum` INT NOT NULL,
PRIMARY KEY (`idMusica`),
INDEX `fk_Musica_Categoria1_idx` (`idCategoria` ASC) VISIBLE,
INDEX `fk_Musica_Album1_idx` (`Album_idAlbum` ASC) VISIBLE,
CONSTRAINT `fk_Musica_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `mydb`.`GeneroMusical` (`idGeneroMusical`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_Musica_Album1`
    FOREIGN KEY (`Album_idAlbum`)
    REFERENCES `mydb`.`Album` (`idAlbum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contrato` (
`idContrato` INT NOT NULL,
`dtInicio` DATETIME NOT NULL,
`dfFim` DATETIME NULL,
`idMusica` INT NOT NULL,
`idGravadora` INT NOT NULL,
PRIMARY KEY (`idContrato`),
INDEX `fk_Contrato_Musica1_idx` (`idMusica` ASC) VISIBLE,
INDEX `fk_Contrato_Gravadora1_idx` (`idGravadora` ASC) VISIBLE,
CONSTRAINT `fk_Contrato_Musica1`
    FOREIGN KEY (`idMusica`)
    REFERENCES `mydb`.`Musica` (`idMusica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_Contrato_Gravadora1`
    FOREIGN KEY (`idGravadora`)
    REFERENCES `mydb`.`Gravadora` (`idGravadora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Artista` (
`idArtista` INT NOT NULL,
`nmArtista` VARCHAR(45) NOT NULL,
PRIMARY KEY (`idArtista`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genero` (
`idGenero` INT NOT NULL,
`descGenero` VARCHAR(45) NULL,
PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
`idUsuario` INT NOT NULL,
`cpf` VARCHAR(11) NOT NULL,
`nmUsuario` VARCHAR(45) NOT NULL,
`dtNascimento` DATETIME NOT NULL,
`email` VARCHAR(45) NOT NULL,
`dtInscricao` VARCHAR(45) NOT NULL,
`idPais` INT NOT NULL,
`idGenero` INT NOT NULL,
PRIMARY KEY (`idUsuario`),
INDEX `fk_Usuario_Pais1_idx` (`idPais` ASC) VISIBLE,
INDEX `fk_Usuario_Genero1_idx` (`idGenero` ASC) VISIBLE,
CONSTRAINT `fk_Usuario_Pais1`
    FOREIGN KEY (`idPais`)
    REFERENCES `mydb`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_Usuario_Genero1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `mydb`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Execucao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Execucao` (
`idExecucap` INT NOT NULL,
`dtExecucao` VARCHAR(45) NOT NULL,
`idMusica` INT NOT NULL,
`Usuario_idUsuario` INT NOT NULL,
PRIMARY KEY (`idExecucap`),
INDEX `fk_Execucao_Musica1_idx` (`idMusica` ASC) VISIBLE,
INDEX `fk_Execucao_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
CONSTRAINT `fk_Execucao_Musica1`
    FOREIGN KEY (`idMusica`)
    REFERENCES `mydb`.`Musica` (`idMusica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_Execucao_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`BandeiraCartao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BandeiraCartao` (
`idBandeiraCartao` INT NOT NULL,
`descBandeira` VARCHAR(45) NOT NULL,
PRIMARY KEY (`idBandeiraCartao`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`TipoAssinatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoAssinatura` (
`idTipoAssinatura` INT NOT NULL,
`descAssinatura` VARCHAR(45) NOT NULL,
`vlrVigente` DECIMAL(6,2) NOT NULL,
PRIMARY KEY (`idTipoAssinatura`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Assinatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Assinatura` (
`idAssinatura` INT NOT NULL,
`dtInicio` DATETIME NOT NULL,
`dtFim` DATETIME NULL,
`numCartao` VARCHAR(16) NOT NULL,
`dtCobrancao` DATETIME NOT NULL,
`BandeiraCartao_idBandeiraCartao` INT NOT NULL,
`TipoAssinatura_idTipoAssinatura` INT NOT NULL,
`Usuario_idUsuario` INT NOT NULL,
PRIMARY KEY (`idAssinatura`),
INDEX `fk_Assinatura_BandeiraCartao1_idx` (`BandeiraCartao_idBandeiraCartao` ASC) VISIBLE,
INDEX `fk_Assinatura_TipoAssinatura1_idx` (`TipoAssinatura_idTipoAssinatura` ASC) VISIBLE,
INDEX `fk_Assinatura_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
CONSTRAINT `fk_Assinatura_BandeiraCartao1`
    FOREIGN KEY (`BandeiraCartao_idBandeiraCartao`)
    REFERENCES `mydb`.`BandeiraCartao` (`idBandeiraCartao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_Assinatura_TipoAssinatura1`
    FOREIGN KEY (`TipoAssinatura_idTipoAssinatura`)
    REFERENCES `mydb`.`TipoAssinatura` (`idTipoAssinatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_Assinatura_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
`idPagamento` INT NOT NULL,
`dtPagamento` DATETIME NOT NULL,
`vlrPago` DECIMAL(6,2) NOT NULL,
`Assinatura_idAssinatura` INT NOT NULL,
PRIMARY KEY (`idPagamento`),
INDEX `fk_Pagamento_Assinatura1_idx` (`Assinatura_idAssinatura` ASC) VISIBLE,
CONSTRAINT `fk_Pagamento_Assinatura1`
    FOREIGN KEY (`Assinatura_idAssinatura`)
    REFERENCES `mydb`.`Assinatura` (`idAssinatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`TipoRoyalty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoRoyalty` (
`idTipoRoyaltie` INT NOT NULL,
`descTipoRoyaltie` VARCHAR(45) NOT NULL,
PRIMARY KEY (`idTipoRoyaltie`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`Royalty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Royalty` (
`idRoyalties` INT NOT NULL,
`mesReferencia` INT NOT NULL,
`dtPagamento` DATETIME NOT NULL,
`vlrPago` DECIMAL(8,2) NOT NULL,
`Musica_idMusica` INT NOT NULL,
`idTipoRoyaltie` INT NOT NULL,
PRIMARY KEY (`idRoyalties`),
INDEX `fk_Royalties_Musica1_idx` (`Musica_idMusica` ASC) VISIBLE,
INDEX `fk_Royalty_TipoRoyalty1_idx` (`idTipoRoyaltie` ASC) VISIBLE,
CONSTRAINT `fk_Royalties_Musica1`
    FOREIGN KEY (`Musica_idMusica`)
    REFERENCES `mydb`.`Musica` (`idMusica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_Royalty_TipoRoyalty1`
    FOREIGN KEY (`idTipoRoyaltie`)
    REFERENCES `mydb`.`TipoRoyalty` (`idTipoRoyaltie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`ArtistaMusica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ArtistaMusica` (
`idArtista` INT NOT NULL,
`idMusica` INT NOT NULL,
`principal` CHAR(1) NOT NULL,
PRIMARY KEY (`idArtista`, `idMusica`),
INDEX `fk_ArtistaMusica_Musica1_idx` (`idMusica` ASC) VISIBLE,
CONSTRAINT `fk_ArtistaMusica_Artista1`
    FOREIGN KEY (`idArtista`)
    REFERENCES `mydb`.`Artista` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_ArtistaMusica_Musica1`
    FOREIGN KEY (`idMusica`)
    REFERENCES `mydb`.`Musica` (`idMusica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;