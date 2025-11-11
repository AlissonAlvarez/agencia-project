CREATE DATABASE IF NOT EXISTS vision360;
USE vision360;

-- Tabla CLIENTES
CREATE TABLE CLIENTES (
  cliente_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre_empresa VARCHAR(100) NOT NULL,
  contacto_principal VARCHAR(100),
  email_contacto VARCHAR(100) UNIQUE,
  fecha_inicio_contrato DATE
);

-- Tabla EMPLEADOS
CREATE TABLE EMPLEADOS (
  empleado_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre_completo VARCHAR(100) NOT NULL,
  rol VARCHAR(50),
  salario DECIMAL(10,2),
  fecha_contratacion DATE
);

-- Tabla PROYECTOS
CREATE TABLE PROYECTOS (
  proyecto_id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  nombre_campana VARCHAR(150) NOT NULL,
  estado_proyecto VARCHAR(50),
  presupuesto_total DECIMAL(10,2),
  FOREIGN KEY (cliente_id) REFERENCES CLIENTES(cliente_id)
);

-- Tabla ASIGNACIONES_PROYECTO
CREATE TABLE ASIGNACIONES_PROYECTO (
  asignacion_id INT AUTO_INCREMENT PRIMARY KEY,
  proyecto_id INT NOT NULL,
  empleado_id INT NOT NULL,
  rol_en_proyecto VARCHAR(50),
  FOREIGN KEY (proyecto_id) REFERENCES PROYECTOS(proyecto_id),
  FOREIGN KEY (empleado_id) REFERENCES EMPLEADOS(empleado_id)
);

-- Tabla FACTURACION
CREATE TABLE FACTURACION (
  factura_id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  fecha_emision DATE NOT NULL,
  monto_total DECIMAL(10,2),
  estado_pago VARCHAR(50),
  FOREIGN KEY (cliente_id) REFERENCES CLIENTES(cliente_id)
);

-- Tabla PAGOS
CREATE TABLE PAGOS (
  pago_id INT AUTO_INCREMENT PRIMARY KEY,
  factura_id INT NOT NULL,
  fecha_pago DATETIME NOT NULL,
  monto_pagado DECIMAL(10,2) NOT NULL,
  metodo_pago VARCHAR(50),
  FOREIGN KEY (factura_id) REFERENCES FACTURACION(factura_id)
);

-- Tabla METRICAS
CREATE TABLE METRICAS (
  metrica_id INT AUTO_INCREMENT PRIMARY KEY,
  proyecto_id INT NOT NULL,
  fecha_registro DATE NOT NULL,
  tipo_metrica VARCHAR(50) NOT NULL,
  valor_numerico INT,
  FOREIGN KEY (proyecto_id) REFERENCES PROYECTOS(proyecto_id)
);

-- Tabla SERVICIOS
CREATE TABLE SERVICIOS (
  servicio_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre_servicio VARCHAR(100) NOT NULL,
  descripcion TEXT,
  costo_base DECIMAL(10,2)
);

-- Tabla SERVICIOS_POR_PROYECTO
CREATE TABLE SERVICIOS_POR_PROYECTO (
  relacion_id INT AUTO_INCREMENT PRIMARY KEY,
  proyecto_id INT NOT NULL,
  servicio_id INT NOT NULL,
  horas_estimadas INT,
  UNIQUE (proyecto_id, servicio_id),
  FOREIGN KEY (proyecto_id) REFERENCES PROYECTOS(proyecto_id),
  FOREIGN KEY (servicio_id) REFERENCES SERVICIOS(servicio_id)
);

-- Tabla TIPOS_DE_CAMPANA
CREATE TABLE TIPOS_DE_CAMPANA (
  tipo_campana_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre_tipo VARCHAR(100) NOT NULL,
  plataforma_principal VARCHAR(50),
  descripcion_tipo TEXT
);

-- Tabla PROMOCIONES
CREATE TABLE PROMOCIONES (
  promocion_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre_promocion VARCHAR(100) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  descuento DECIMAL(5,2),
  descripcion_corta TEXT
);

-- Tabla USUARIOS (para login y registro)
CREATE TABLE USUARIOS (
  usuario_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
