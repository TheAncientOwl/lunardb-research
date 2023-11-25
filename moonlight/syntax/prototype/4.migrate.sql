-- --------------------------------------------------------------------------------- --
-- 1. Syntax
-- --------------------------------------------------------------------------------- --

migrate structure StructureName to NewSchema;

migrate structure StructureName to NewSchema using [
    old_field1 => new_field1,
    old_field2 => new_field2
];

-- --------------------------------------------------------------------------------- --
-- 2. Usage
-- --------------------------------------------------------------------------------- --

type ClientV2 inherits Client {
    income: Float;
};

migrate structure ClientsTable to ClientV2 using [
    creditLimit => credit_limit;
];

-- What should happen with modified types?

type Dummy1 {
    field: String;
};

type Dummy2 {
    field: String;
};

type AlphaDummy {
    dummy1Field: Dummy1;
    dummy2Field: Dummy2;
};


type DummyGroup {
    members: ArrayOf<AlphaDummy>;
};

type Dummy2V2 {
    field: String;
}

create table AlphaDummies based on AlphaDummy;
create table DummyGroups based on DummyGroup;

