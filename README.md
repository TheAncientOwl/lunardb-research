# 🌙 LunarDB Project

## ✨ Research, documentation and prototypes

## 1. Storage format

```
- tables: SQL like table storage
- collections: MongoDB like collection of documents
- volatile: In RAM, stored either as tables or collections
```

## 2. Data Types

### 2.1. Primitives

```
- RID: Record ID
- String: for tables must specify max length.
          TODO: research how oracle/sql databases handle strings
- Boolean: true | false
- DateTime: TODO: research formats
- Integer: on 8, 16, 32, 64 bits
- Float: on 8, 16, 32, 64 bits. (TODO: Consider 8 and 16 bits...?)
```

### 2.2. Structures

```
ArrayOf<Type>

Example:
    type Type1 {
        ...
    }
    type Type2 {
        field1: integer
        field2: ArrayOf<Type1>
    }

Handle:
    - Tables: Create a table for field2 (of Type1) in which add Type2.RID as foregin key
    - Documents: Add the value to the list in the same document
```

### 2.3. User defined types

```
Combinations of primitives + structures + other user defined types

Example:
    type Type1 {
      field_1: Integer
      field_2: String
    }
    type Type2 {
      field_x: Float
      field_y: Type1
    }
    type Type3 {
        field_a: String;
        field_b: ArrayOf<Type2>
    }
```
