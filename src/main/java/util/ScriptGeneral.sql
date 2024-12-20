CREATE DATABASE IF NOT EXISTS dbproyectojq;
USE dbproyectojq;

-- Tabla rol
CREATE TABLE IF NOT EXISTS rol (
    idRol INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla administrador
CREATE TABLE IF NOT EXISTS administrador (
    idUsuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(200) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL,
    url VARCHAR(600) NOT NULL,
    fechaRegistro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    idRol INT NOT NULL,
    FOREIGN KEY (idRol) REFERENCES rol(idRol)
);

-- Tabla categorias
CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla productos
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    imagen VARCHAR(255),
    id_categoria INT DEFAULT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- Tabla venta_cabecera
CREATE TABLE IF NOT EXISTS venta_cabecera (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    dni_comprador VARCHAR(15) NOT NULL,
    email_comprador VARCHAR(100) NOT NULL,
    fecha_venta DATETIME NOT NULL
);

-- Tabla venta_detalle
CREATE TABLE IF NOT EXISTS venta_detalle (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES venta_cabecera (id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos (id)
);

-- Inserciones para tabla roles
INSERT INTO rol (nombre) 
VALUES 
    ('ADMIN'), 
    ('OWNER');

-- Insertamos para tabla administradores
INSERT INTO administrador (nombre, apellido, correo, contrasena, url, idRol) 
VALUES 
    ('Carlos', 'Lopez', 'carlos.lopez@example.com', 'contrasena789', 'http://example.com', 1),
    ('Ana', 'Martinez', 'ana.martinez@example.com', 'contrasena101', 'http://example.com', 2),
    ('Luis', 'Fernandez', 'luis.fernandez@example.com', 'contrasena202', 'http://example.com', 1),
    ('Laura', 'Diaz', 'laura.diaz@example.com', 'contrasena303', 'http://example.com', 2),
    ('Pedro', 'Sanchez', 'pedro.sanchez@example.com', 'contrasena404', 'http://example.com', 1);

-- Inserciones para tabla categorias
INSERT INTO categorias (nombre)
VALUES 
    ('Pisco'),
    ('Whisky'),
    ('Vinos');

-- Inserciones para tabla productos
INSERT INTO productos (nombre, precio, stock, imagen, id_categoria)
VALUES
    -- Categoría 1: Pisco
    ('Pisco Vargas Puro', 220.00, 150, 'https://www.plazavea.com.pe/pisco-vargas-puro-botella-750ml/p', 1),
    ('Pisco Santiago Queirolo Quebranta', 250.00, 100, 'https://www.plazavea.com.pe/pisco-santiago-queirolo-quebranta-botella-750ml/p', 1),
    ('Pisco Vargas Puro 4L', 230.00, 120, 'https://www.plazavea.com.pe/pisco-puro-vargas-botella-4l/p', 1),
    ('Pisco Vargas Acholado', 270.00, 90, 'https://www.plazavea.com.pe/pisco-vargas-acholado-botella-750ml/p', 1),
    ('Pisco Santiago Queirolo Acholado', 240.00, 110, 'https://www.plazavea.com.pe/pisco-santiago-queirolo-acholado-botella-750ml/p', 1),
    ('Pisco Vargas Italia', 260.00, 80, 'https://www.plazavea.com.pe/pisco-vargas-italia-botella-750ml/p', 1),

    -- Categoría 2: Whisky
    ('Johnnie Walker Red Label', 450.00, 120, 'https://www.plazavea.com.pe/whisky-johnnie-walker-red-label-botella-750ml/p', 2),
    ('Something Special Clásico', 520.00, 150, 'https://www.plazavea.com.pe/whisky-something-special-botella-750ml/p', 2),
    ('Jack Daniels Old Nº 7', 750.00, 100, 'https://www.elcorteingles.es/supermercado/0110118722900141-jack-daniels-old-n-7-whisky-de-tennessee-botella-70-cl/', 2),
    ('Chivas Regal 12 años', 950.00, 80, 'https://www.plazavea.com.pe/whisky-chivas-regal-12-anos-botella-750ml/p', 2),
    ('Ballantines Finest', 800.00, 70, 'https://www.plazavea.com.pe/whisky-ballantines-finest-botella-750ml/p', 2),
    ('Jameson Irish Whiskey', 400.00, 180, 'https://www.plazavea.com.pe/whisky-jameson-botella-750ml/p', 2),

    -- Categoría 3: Vino
    ('Vino Tinto Reserva', 120.00, 50, 'https://www.plazavea.com.pe/vino-tinto-reserva-botella-750ml/p', 3),
    ('Vino Blanco Seco', 130.00, 80, 'https://www.plazavea.com.pe/vino-blanco-seco-botella-750ml/p', 3),
    ('Vino Rosé Dulce', 140.00, 60, 'https://www.plazavea.com.pe/vino-rose-dulce-botella-750ml/p', 3),
    ('Vino Espumante Brut', 150.00, 70, 'https://www.plazavea.com.pe/vino-espumante-brut-botella-750ml/p', 3),
    ('Vino Tinto Gran Reserva', 180.00, 40, 'https://www.plazavea.com.pe/vino-tinto-gran-reserva-botella-750ml/p', 3),
    ('Vino Blanco Afrutado', 135.00, 90, 'https://www.plazavea.com.pe/vino-blanco-afrutado-botella-750ml/p', 3);


DELIMITER $$

-- =======================================
-- Procedimientos para la Tabla Administrador
-- =======================================

-- Listar todos los administradores
CREATE PROCEDURE sp_listAdministrators()
BEGIN
    SELECT 
        a.idUsuario, 
        a.nombre, 
        a.apellido, 
        a.correo, 
        a.url, 
        a.fechaRegistro, 
        r.nombre AS rolNombre
    FROM administrador a
    JOIN rol r ON a.idRol = r.idRol;
END $$

-- Obtener un administrador por su ID
CREATE PROCEDURE sp_getAdministratorById(
    IN p_idUsuario INT
)
BEGIN
    SELECT 
        a.idUsuario, 
        a.nombre, 
        a.apellido, 
        a.correo, 
        a.contrasena, 
        a.url, 
        a.fechaRegistro, 
        a.idRol, 
        r.nombre AS rolNombre
    FROM administrador a
    JOIN rol r ON a.idRol = r.idRol
    WHERE a.idUsuario = p_idUsuario;
END $$

-- Listar administradores por rol
CREATE PROCEDURE sp_listAdministratorsByRole(
    IN p_rolNombre VARCHAR(50)
)
BEGIN
    SELECT 
        a.idUsuario, 
        a.nombre, 
        a.apellido, 
        a.correo, 
        a.url, 
        a.fechaRegistro, 
        r.nombre AS rolNombre
    FROM administrador a
    JOIN rol r ON a.idRol = r.idRol
    WHERE r.nombre = p_rolNombre;
END $$

-- Registrar un nuevo administrador
CREATE PROCEDURE sp_registerAdministrator(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(200),
    IN p_correo VARCHAR(100),
    IN p_contrasena VARCHAR(100),
    IN p_url VARCHAR(600),
    IN p_idRol INT
)
BEGIN
    INSERT INTO administrador (nombre, apellido, correo, contrasena, url, idRol)
    VALUES (p_nombre, p_apellido, p_correo, p_contrasena, p_url, p_idRol);
END $$

-- Actualizar un administrador existente
CREATE PROCEDURE sp_updateAdministrator(
    IN p_idUsuario INT,
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(200),
    IN p_correo VARCHAR(100),
    IN p_contrasena VARCHAR(100),
    IN p_url VARCHAR(600),
    IN p_idRol INT
)
BEGIN
    UPDATE administrador
    SET 
        nombre = p_nombre, 
        apellido = p_apellido, 
        correo = p_correo, 
        contrasena = p_contrasena, 
        url = p_url, 
        idRol = p_idRol
    WHERE idUsuario = p_idUsuario;
END $$

-- Eliminar un administrador
CREATE PROCEDURE sp_deleteAdministrator(
    IN p_idUsuario INT
)
BEGIN
    DELETE FROM administrador WHERE idUsuario = p_idUsuario;
END $$

-- =======================================
-- Procedimientos para la Tabla Rol
-- =======================================

-- Listar todos los roles
CREATE PROCEDURE sp_listRoles()
BEGIN
    SELECT idRol, nombre FROM rol;
END $$

-- Obtener un rol por su ID
CREATE PROCEDURE sp_getRoleById(
    IN p_idRol INT
)
BEGIN
    SELECT idRol, nombre 
    FROM rol 
    WHERE idRol = p_idRol;
END $$

DELIMITER ;


DELIMITER $$

-- =======================================
-- Procedimiento: Obtener Productos por Categoría
-- =======================================

CREATE PROCEDURE ObtenerProductosEnStockPorCategoria(
    IN categoriaID INT
)
BEGIN
    SELECT 
        p.id AS idProducto, 
        p.nombre AS nombreProducto, 
        p.precio, 
        p.id_categoria AS idCategoria, 
        c.nombre AS nombreCategoria, 
        p.imagen 
    FROM 
        productos p
    INNER JOIN 
        categorias c ON p.id_categoria = c.id_categoria
    WHERE 
        p.id_categoria = categoriaID
        AND p.stock > 0;
END $$

DELIMITER ;

