-- Tạo database
CREATE DATABASE 
    KinhDoanhTBMayTinh
ON (
    NAME = 'KinhDoanhTBMayTinh',
    FILENAME = 'D:\ChuyendeNganh\KinhDoanhTBMayTinh.mdf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10%
);
