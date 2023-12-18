-- --------------------------------------------------------------------------------- --
-- 1. Syntax
-- --------------------------------------------------------------------------------- --

-- @brief type
schema SchemaName {
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

schema Person {
    firstName: String;
    lastName: String;
    phone: String;
    email: String;
};

schema Client inherits Person {
    creditLimit: Float;
    birthDate: DateTime;
    sex: String;
    incomeLevel: String;
};

schema Region {
    name: String;
}

schema Country {
    name: String;
    region: Region;
};

schema Location {
    address: String;
    postCode: String;
    city: String;
    country: Country;
};

schema Department {
    name: String;
    manager: Employee?;
    location: Location;
};

schema Function {
    name: String;
    minSalary: Float;
    maxSalary: Float;
};

schema Employee inherits Person {
    employmentDate: DateTime;
    manager: Employee?;
    salary: Float;
    function: Function;
    department: Department;
};

schema Product {
    name: String;
    description: String;
    category: String;
    listPrice: Float;
};

schema OrderedProduct {
    product: Product;
    price: Float;
    amount: Integer;
};

schema Order {
    date: DateTime;
    shipped: Boolean;
    paymentType: String;
    client: Client;
    employee: Employee;
    products: ArrayOf<OrderedProduct>;
};

schema FunctionsHistory {
    startDate: DateTime;
    endDate: DateTime;
    employee: Employee;
    function: Function;
    department: Department;
};
