/*
  VERSION 2 - CAPA BRONZE
  Ejecutar conectado a la base de datos dw_transporte.
  Esta capa conserva la estructura del origen Azure SQL, pero todos los
  campos de negocio se reciben como VARCHAR para admitir datos sucios.
  No incluye claves foraneas ni validaciones de negocio.
*/
SET NOCOUNT ON;
GO

IF DB_NAME() <> N'dw_transporte'
    THROW 51000, 'Conectese a la base de datos dw_transporte antes de ejecutar este script.', 1;
GO

IF SCHEMA_ID(N'bronze') IS NULL EXEC(N'CREATE SCHEMA bronze');
GO

IF OBJECT_ID(N'bronze.Rutas', N'U') IS NOT NULL
    THROW 51001, 'bronze.Rutas ya existe. Version 2 requiere una base limpia.', 1;
IF OBJECT_ID(N'bronze.Paradas', N'U') IS NOT NULL
    THROW 51002, 'bronze.Paradas ya existe. Version 2 requiere una base limpia.', 1;
IF OBJECT_ID(N'bronze.Vehiculos', N'U') IS NOT NULL
    THROW 51003, 'bronze.Vehiculos ya existe. Version 2 requiere una base limpia.', 1;
IF OBJECT_ID(N'bronze.Viajes', N'U') IS NOT NULL
    THROW 51004, 'bronze.Viajes ya existe. Version 2 requiere una base limpia.', 1;
IF OBJECT_ID(N'bronze.DemandaParadas', N'U') IS NOT NULL
    THROW 51005, 'bronze.DemandaParadas ya existe. Version 2 requiere una base limpia.', 1;
IF OBJECT_ID(N'bronze.Incidentes', N'U') IS NOT NULL
    THROW 51006, 'bronze.Incidentes ya existe. Version 2 requiere una base limpia.', 1;
IF OBJECT_ID(N'bronze.IncidenteRuta', N'U') IS NOT NULL
    THROW 51007, 'bronze.IncidenteRuta ya existe. Version 2 requiere una base limpia.', 1;
GO

CREATE TABLE bronze.Rutas (
    AnioFuente         VARCHAR(10)  NULL,
    RutaHistoricaId    VARCHAR(30)  NULL,
    CodigoRuta         VARCHAR(20)  NULL,
    NombreRuta         VARCHAR(120) NULL,
    Origen             VARCHAR(80)  NULL,
    Destino            VARCHAR(80)  NULL,
    VigenciaDesde      VARCHAR(30)  NULL,
    VigenciaHasta      VARCHAR(30)  NULL,
    Estado             VARCHAR(20)  NULL
);
GO

CREATE TABLE bronze.Paradas (
    AnioFuente         VARCHAR(10)  NULL,
    ParadaHistoricaId  VARCHAR(30)  NULL,
    CodigoPublicado    VARCHAR(20)  NULL,
    NombreParada       VARCHAR(120) NULL,
    Zona               VARCHAR(40)  NULL,
    Latitud            VARCHAR(30)  NULL,
    Longitud           VARCHAR(30)  NULL,
    VigenciaDesde      VARCHAR(30)  NULL,
    VigenciaHasta      VARCHAR(30)  NULL,
    Estado             VARCHAR(20)  NULL
);
GO

CREATE TABLE bronze.Vehiculos (
    AnioFuente          VARCHAR(10) NULL,
    VehiculoId          VARCHAR(20) NULL,
    Placa               VARCHAR(20) NULL,
    TipoVehiculo        VARCHAR(30) NULL,
    CapacidadEfectiva   VARCHAR(20) NULL,
    VigenciaDesde       VARCHAR(30) NULL,
    VigenciaHasta       VARCHAR(30) NULL,
    Estado              VARCHAR(20) NULL
);
GO

CREATE TABLE bronze.Viajes (
    AnioFuente            VARCHAR(10) NULL,
    ViajeId               VARCHAR(30) NULL,
    RutaHistoricaId       VARCHAR(30) NULL,
    VehiculoId            VARCHAR(20) NULL,
    FechaServicio         VARCHAR(30) NULL,
    HoraProgramada        VARCHAR(30) NULL,
    HoraSalida            VARCHAR(30) NULL,
    HoraLlegada           VARCHAR(30) NULL,
    ValidacionesTarjeta   VARCHAR(20) NULL,
    KmRecorridos          VARCHAR(30) NULL,
    EstadoViaje           VARCHAR(20) NULL
);
GO

CREATE TABLE bronze.DemandaParadas (
    AnioFuente             VARCHAR(10) NULL,
    DemandaId              VARCHAR(30) NULL,
    FechaServicio          VARCHAR(30) NULL,
    RutaHistoricaId        VARCHAR(30) NULL,
    ParadaHistoricaId      VARCHAR(30) NULL,
    Franja                 VARCHAR(20) NULL,
    ValidacionesTarjeta    VARCHAR(20) NULL,
    Descensos              VARCHAR(20) NULL,
    DemandaNoAtendida      VARCHAR(20) NULL,
    Metodo                 VARCHAR(30) NULL
);
GO

CREATE TABLE bronze.Incidentes (
    AnioFuente          VARCHAR(10)  NULL,
    IncidenteId         VARCHAR(30)  NULL,
    TipoIncidente       VARCHAR(30)  NULL,
    Severidad           VARCHAR(15)  NULL,
    FechaHoraInicio     VARCHAR(35)  NULL,
    FechaHoraFin        VARCHAR(35)  NULL,
    FechaHoraRegistro   VARCHAR(35)  NULL,
    VehiculoId          VARCHAR(20)  NULL,
    Descripcion         VARCHAR(200) NULL
);
GO

CREATE TABLE bronze.IncidenteRuta (
    AnioFuente        VARCHAR(10) NULL,
    IncidenteId       VARCHAR(30) NULL,
    RutaHistoricaId   VARCHAR(30) NULL,
    EsPrincipal       VARCHAR(10) NULL
);
GO
