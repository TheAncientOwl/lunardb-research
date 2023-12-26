-- 0. TYPES
-- @see 1.types.sql

-- @note Semicolons are not required on single instructions.
--       They are used as separators when more than one query is provided

-- 1. CREATE
create [volatile] table|collection StructureName based on SchemaName binding [ 
    field from SomeOtherTableName,
] [blended];

rebind StructureName::fieldName to OtherTable [clean];

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
rename structure|field|database from Structure::OldFieldName to Structure::NewFieldName;

-- 6. SELECT
select from StructureName
    where (rid = 11 or (rid >= 2 and 5 <= rid or some_field < 5000) or rid = 9  or rid = 120)
    fields [ field1, field2, ..., fieldx ]
    order by [ field1 asc, field2 desc, ..., field_z desc ];

select from StructureName::*arrayField*
    where ( conditions... )
    fields [ fields from arrayField..., StructureName::fields from StructureName ];

-- 7. INSERT
insert into Professors objects [
    {
        "salary": "4000",
        "name": "Bob",
        "birth_date": "09/10/1985",
        "address": {
            "street": "Some Street",
            "number": "5"
        }
    }
    {
        "salary": "4000",
        "rank": "HeadmasterSupreme", -- observe new field added dynamically
        "name": "Ultimate Bob",
        "birth_date": "09/10/1985",
        "address": {
            "street": "Some Street",
            "number": "5"
        }
    }
    {
        "salary": "4000",
        "rank(String)": "HeadmasterSupreme", -- observe new field added dynamically with data type
        "name": "Ultimate Bob",
        "birth_date": "09/10/1985",
        "address": {
            "street": "Some Street",
            "number": "5"
        }
    }
];

-- 8. UPDATE
update structure Professors 
    where (rid = 11 or (rid >= 2 and 5 <= rid or some_field < 5000) or rid = 9  or rid = 120)
    modify [
        field1 => field1 * 1.5 + 2,
        field2 => field3
    ]

-- 9. DELETE
delete from structure Professors
    where (rid = 11 or (rid >= 2 and 5 <= rid or some_field < 5000) or rid = 9  or rid = 120);

-- 10. LOCK
set concurrency on structure Professor on|off;

-- 11. GRANT
grant [ update, insert, ..., delete ]
    to UserName
    on StructureName;

-- 12. REVOKE
revoke [ update, insert, ..., delete ]
    from UserName
    on StructureName;

-- 13. COMMIT
commit;

-- 14. ROLLBACK
rollback [hash];

-- 15. SAVEPOINT
savepoint [hash];

-- 16. INDEX
index StructureName [unique] [as IndexName];
index StructureName [unique] [as IndexName] using [
    field1, field2, ..., fieldx
];

-- 17. DATABASE
database create|drop|backup|use DatabaseName 
    to disk "/home/user/lunardb-backup";

-- 18. VIEW
view ViewName as select...
