-- 0. TYPES
-- @see 1.types.sql

-- @note Semicolons are not required on single instructions.
--       They are used as separators when more than one query is provided

-- 1. CREATE
create [volatile] table|collection StructureName based on TypeName binding [ 
    field from SomeOtherTableName,
] [blended];

[clean] rebind StructureName::fieldName to OtherTable;

create [volatile] tables|collections from [ 
    Type1, Type2, ..., TypeN
] using format "%TypeName%Structure";

-- 2. DROP
drop structure Professors;
drop structure Professors cascade;

-- 3. MIGRATE
migrate structure Professors to NewSchema;
migrate structure Professors to NewSchema using [
    old_field1 => new_field1,
    old_field2 => new_field2
];

-- 4. TRUNCATE
truncate structure Professors;

-- 5. RENAME
rename structure|field|database from OldName to NewName;
rename structure|field|database from Structure.OldFieldName to Structure.NewFieldName;

-- 6. SELECT
select from StructureName
    if (rid = 11 or (rid >= 2 and 5 <= rid or some_field < 5000) or rid = 9  or rid = 120)
    fields [ field1, field2, ..., fieldx ]
    order by [ field1 asc, field2 desc, ..., field_z desc ];

select from StructureName::*arrayField*
    if ( conditions... )
    fields [ fields from arrayField..., StructureName::fields from StructureName ];

-- 7. INSERT
insert into Professors values [
    Professor {
        salary: 4000,
        Person {
            name: "Bob",
            birth_date: "09/10/1985",
            address: Address {
                street: "Some Street",
                number: 5
            }
        }
    },
    -- OR
    { 4500, { "Bob", "09/10/1985", { "Some Street", 5 } } },
    -- OR
    Professor {
        salary: 4000,
        rank: "HeadmasterSupreme", -- observe new field added dynamically
        Person {
            name: "Ultimate Bob",
            birth_date: "09/10/1985",
            address: Address {
                street: "Some Street",
                number: 5
            }
        }
    },
    -- OR
    Professor {
        salary: 4000,
        rank(String): "HeadmasterSupreme", -- observe new field added dynamically with data type
        Person {
            name: "Ultimate Bob",
            birth_date: "09/10/1985",
            address: Address {
                street: "Some Street",
                number: 5
            }
        }
    }
];

-- 8. UPDATE
update structure Professors 
    if (rid = 11 or (rid >= 2 and 5 <= rid or some_field < 5000) or rid = 9  or rid = 120)
    modify [
        field1 => field1 * 1.5 + 2,
        field2 => field3
    ]

-- 9. DELETE
delete from structure Professor
    if (rid = 11 or (rid >= 2 and 5 <= rid or some_field < 5000) or rid = 9  or rid = 120);

-- 10. LOCK
set concurrency on structure Professor on|off;

-- 12. GRANT
grant [ update, insert, ..., delete ]
    to UserName
    on StructureName;

-- 13. REVOKE
revoke [ update, insert, ..., delete ]
    from UserName
    on StructureName;

-- 14. COMMIT
commit;

-- 15. ROLLBACK
rollback;

-- 16. SAVEPOINT
savepoint;
savepoint SavepointName;

-- 17. INDEX
create unique index IndexName on StructureName;
create unique index IndexName on StructureName using [
    field1, field2, ..., fieldx
];

-- 18. DATABASE
database create|drop|backup DatabaseName 
    to disk "/home/user/lunardb-backup";

-- 19. VIEW
create view ViewName...
