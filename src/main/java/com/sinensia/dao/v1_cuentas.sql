CREATE TABLE IF NOT EXISTS `categoria` (
`categoriaId` int(11) NOT NULL AUTO_INCREMENT,
`nombre` varchar(14) NOT NULL,
`esIngreso` boolean NOT NULL,
PRIMARY KEY (`categoriaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `tramite` (
`tramiteId` int(11) NOT NULL AUTO_INCREMENT,
`valor` numeric(14, 5) NOT NULL,
`fecha` DATE,
`categoriaId` int NOT NULL,
PRIMARY KEY (`tramiteId`),
CONSTRAINT FK_CategoriaTramite FOREIGN KEY (categoriaId) REFERENCES categoria(categoriaId),
`concepto` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;