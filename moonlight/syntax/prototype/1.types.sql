-- --------------------------------------------------------------------------------- --
-- 1. Syntax
-- --------------------------------------------------------------------------------- --

-- @brief type
type TypeName {
    field1: Type;
    field2: Type?;
    field3: ArrayOf<Type>;
};

primitives:
    String, Boolean, DateTime,
    Integer, Integer8, Integer16, Integer32, Integer64,
    Float, Float8, Float16, Float32, Float64

defaults:
    String: ""
    Boolean: false
    DateTime: now()
    Integer: 0
    Float: 0

-- --------------------------------------------------------------------------------- --
-- 2. Usage
-- --------------------------------------------------------------------------------- --

type Person {
    firstName: String;
    lastName: String;
    phone: String;
    email: String;
};

type Client inherits Person {
    creditLimit: Float;
    birthDate: DateTime;
    sex: String;
    incomeLevel: String;
};

type Region {
    name: String;
}

type Country {
    name: String;
    region: Region;
};

type Location {
    address: String;
    postCode: String;
    city: String;
    country: Country;
};

type Department {
    name: String;
    manager: Employee?;
    location: Location;
};

type Function {
    name: String;
    minSalary: Float;
    maxSalary: Float;
};

type Employee inherits Person {
    employmentDate: DateTime;
    manager: Employee?;
    salary: Float;
    function: Function;
    department: Department;
};

type Product {
    name: String;
    description: String;
    category: String;
    listPrice: Float;
};

type OrderedProduct {
    product: Product;
    price: Float;
    amount: Integer;
};

type Order {
    date: DateTime;
    shipped: Boolean;
    paymentType: String;
    client: Client;
    employee: Employee;
    products: ArrayOf<OrderedProduct>;
};

type FunctionsHistory {
    startDate: DateTime;
    endDate: DateTime;
    employee: Employee;
    function: Function;
    department: Department;
};
