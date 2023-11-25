-- --------------------------------------------------------------------------------- --
-- 1. Syntax
-- --------------------------------------------------------------------------------- --

-- @brief create table|structure
--  Creates the table|structure based on given type.
--  If the type contains other custom types, 
-- creates tables for them and binds the field to the new table
-- 
create [volatile] table|structure StructureName based on TypeName binding [ 
    field from SomeOtherTableName,
];

-- @brief rebind
--   Rebinds the reference of StructureName::fieldName to OtherTable.
--   typeOf(fieldName) must be = typeOf(OtherTable)
-- @specifiers
--   clean -> after rebinding, delete the old structure.
-- 
[clean] rebind StructureName::fieldName to OtherTable;

-- @brief create tables|structures
-- @args set of types from which the DBMS will create tables.
-- @algorithm 
--   Create all tables and rebind them if fields of types are present.
-- Example:
--      type Type1 {
--          someField: String;
--          someOtherField: Integer;
--      };
--      type Type2 {
--          field1: String;
--          field2: Type1;
--      };
--      create tables from [ Type1, Type2 ] using format "%TypeName%Table";
--   Create tables Type1Table and Type2Table and rebind Type2Table::field2 to Type1Table.
-- 
create [volatile] tables|structures from [ 
    Type1, Type2, ..., TypeN
] using format "%TypeName%Structure";

-- --------------------------------------------------------------------------------- --
-- 2. Usage
-- --------------------------------------------------------------------------------- --

-- Approach 1: Create table and bind fields to coresponding tables at the same time
create table ClientsTable based on Client;
create table DepartmentsTable based on Department; -- also creates tables for Locations, Countries and Regions
create table FunctionsTable based on Function;
create table ProductsTable based on Product;

create table EmployeesTable based on Employee binding [
    function from FunctionsTable,
    department from DepartmentsTable,
];

create table OrdersTable based on Order binding [
    client from ClientsTable,
    employee from EmployeesTable,
    products::product from OrderedProduct
];

create table FunctionsHistoryTable based on FunctionsHistory [
    employee from EmployeesTable,
    function from FunctionsTable,
    department from DepartmentsTable
];

-- Approach 2: First create the tables then rebind the fields to corresponding tables
create table ClientsTable based on Client;
create table DepartmentsTable based on Department;
create table FunctionsTable based on Function;
create table EmployeesTable based on Employee;
create table ProductsTable based on Product;
create table OrdersTable based on Order;
create table FunctionsHistoryTable based on FunctionsHistoryTable;

clean rebind CountriesTable::region to RegionsTable;

clean rebind LocationsTable::country to CountriesTable;

clean rebind EmployeesTable::function to FunctionsTable;
clean rebind EmployeesTable::department to DepartmentsTable;

clean rebind OrdersTable::client to ClientsTable;
clean rebind OrdersTable::employee to EmployeesTable;
clean rebind OrdersTable::products::product to OrderedProduct;

clean rebind FunctionsHistoryTable::employee to EmployeesTable;
clean rebind FunctionsHistoryTable::function to FunctionsTable;
clean rebind FunctionsHistoryTable::department to DepartmentsTable;

-- Approach 3: Bulk create
create tables from [ 
    Client, Department, Function, Employee, 
    Product, Order, FunctionsHistoryTable
] using format "%TypeName%sTable";
