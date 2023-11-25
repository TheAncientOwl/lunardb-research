-- <TYPES_DEMO>
type Address {
    street: String;
    number: Integer;
}

type Exam {
    name: String;
    date: DateTime;
    grade: Float;
}

type Person {
    name: String;
    year: Integer;
    birth_date: DateTime;
    address: Address;
}

type Student inherits Person {
    some_field: String;
    exams: ArrayOf<Exam>;
}

type Professor inherits Person {
    salary: Float;
}
-- </TYPES_DEMO>

-- <SELECT_DEMO>
select from Professors
    if (salary > 4000) then
    fields [ name, birth_date, salary ];

select from Students
    if (exams.grade < 5 and lower(exams.name) like "*_advanced") then
    fields [ name, year, exams.grade, exams.name ];

select from Students::exams
    if (grade < 5) then
    fields [ name, date, grade, Students.some_field, Students.name, Students.birth_date ];

-- </SELECT_DEMO>
