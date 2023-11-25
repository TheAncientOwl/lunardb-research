-- --------------------------------------------------------------------------------- --
-- 1. Syntax
-- --------------------------------------------------------------------------------- --

-- @brief create table|document
--  Creates the table|document based on given type.
--  If the type contains other custom types, 
-- creates tables for them and binds the field to the new table
-- @param blended -> 
--  type Type1 {
--      someField1: String;
--      someField2: Integer;
--  };
--  type Type2 {
--      someOtherField: String;
--      type1Field: Type1;
--  };
--  create table Type2Table based on Type2 blended;
--  -> you will get a table which has this structure:
--      type Type2 {
--          someOtherField: String;
--          type1Field.someField1: String;
--          type1Field.someField2: Integer;
--      };
-- 
create [volatile] table|document StructureName based on TypeName binding [ 
    field from SomeOtherTableName,
] [blended];

-- @brief rebind
--   Rebinds the reference of StructureName::fieldName to OtherTable.
--   typeOf(fieldName) must be = typeOf(OtherTable)
-- @specifiers
--   clean -> after rebinding, delete the old structure.
-- 
[clean] rebind StructureName::fieldName to OtherTable;

-- @brief create tables|documents
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
create [volatile] tables|documents from [ 
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

-- --------------------------------------------------------------------------------- --
-- 3. Showcase
-- --------------------------------------------------------------------------------- --
type T1 {
    x: String;
    y: Integer;
    Z: Float;
};

create document T1_Document based on T1;
-- T1_Document
-- {
--     "x": "",
--     "y": 0,
--     "z": 0.0
-- }

create table T1_Table based on T1;
-- T1_Table
-- _________________________
-- | RID |  x  |  y  |  z  |
-- | ... | ... | ... | ... |
-- 

-- ---------------------------------------------------------------------
type T2 {
    a: String;
    b: String;
    c: T1;
};

create document T2_Document based on T2;
-- T2_Document
-- {
--     "a": "",
--     "b": "",
--     "c": {
--         "x": "",
--         "y": 0,
--         "z": 0.0
--     }
-- }

create table T2_Table based on T2;
-- T2_Table_c
-- _________________________
-- | RID |  x  |  y  |  z  |
-- | ... | ... | ... | ... |
-- 
-- T2_Table
-- _________________________
-- | RID |  a  |  b  |  c: T2_Table_c.rid  |
-- | ... | ... | ... |        ...          |
-- 

-- ---------------------------------------------------------------------
type T3 {
    k: Integer;
    l: String;
    m: ArrayOf<T2>;
};

create document T3_Document based on T3;
-- T3_Document
-- {
--     "k": 0,
--     "l": "",
--     "m": [
--         {
--             "a": "",
--             "b": "",
--             "c": {
--                 "x": "",
--                 "y": 0,
--                 "z": 0.0
--             }
--         },
--         ...   
--     ]
-- }

create table T3_Table based on T3;
-- T3_Table_m_c
-- _________________________
-- | RID |  x  |  y  |  z  |
-- | ... | ... | ... | ... |
-- 
-- T3_Table_m
-- _________________________
-- | RID |  x  |  y  |  c: T3_Table_m_c.rid  |
-- | ... | ... | ... |         ...           |
-- 
-- T3_Table
-- ____________________________________
-- | RID |  k  |  l  |   m -> array   |
-- | ... | ... | ... | JUST A CONCEPT |
-- 
-- T3_Table_m_array
-- _______________________________________
-- | RID | T3_Table.rid | T3_Table_m.rid |
-- | ... |      ...     |       ...      |
-- 

-- ---------------------------------------------------------------------
type T4 {
    k: Integer;
    l: String;
    m: ArrayOf<T3>;
};

create document T4_Document based on T4;
-- T4_Document
-- {
--     "k": 0,
--     "l": "",
--     "m": [
--         {
--             "k": 0,
--             "l": "",
--             "m": [
--                 {
--                     "a": "",
--                     "b": "",
--                     "c": {
--                         "x": "",
--                         "y": 0,
--                         "z": 0.0
--                     }
--                 },
--                 ...   
--             ]
--         }
--         ...
--     ]
-- }

create table T4_Table based on T4;
-- why...
