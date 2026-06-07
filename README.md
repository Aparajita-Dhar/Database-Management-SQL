# Database Management Systems & Relational Architecture in SQL

This repository serves as an academic archive demonstrating database design methodologies and relational query optimization. It chronicles the transition from conceptual schemas to structural database implementation, table constraints configuration, and complex query executions.

## 📂 Design Architecture Index

### 1. SQL Data Types & Operators Overview
Every attribute in a relational database must possess a defined data type to control storage allocation and domain constraints.
* **Data Types:** * `INT` / `INTEGER`: Standard numeric values for identifiers or counts.
  * `VARCHAR(N)`: Variable-length character strings (allocates memory dynamically up to limit `N`).
  * `DECIMAL(P, S)`: Exact numerical values where `P` is precision (total digits) and `S` is scale (digits after decimal).
  * `DATE`: Stores calendar dates (YYYY-MM-DD).
* **Operators:** Includes Arithmetic (`+`, `-`, `*`, `/`), Comparison (`=`, `!=`, `<`, `>`, `<=`, `>=`), and Logical (`AND`, `OR`, `NOT`).

### 2. Conceptual Design via Entity-Relationship (ER) Modeling
Before writing DDL code, system models are visually mapped out using Entity-Relationship Diagrams to avoid redundancy.

* **Entities:** Real-world objects that exist independently (represented as Rectangles, e.g., `Student`, `Course`).
* **Attributes:** Properties or traits describing an entity (represented as Ovals, e.g., `StudentID`, `CourseName`).
* **Keys:** The *Primary Key* uniquely identifies an instance of an entity (represented with Underlined text, e.g., `StudentID`).
* **Relationships:** How entities interact or connect with one another (represented as Diamonds, e.g., a Student *Enrolls* in a Course).
* **Cardinalities:** Defines the numerical constraints of the relationship. Common mappings include:
  * One-to-One (1:1)
  * One-to-Many (1:M) (e.g., One `Department` offers Many `Courses`)
  * Many-to-Many (M:N) (e.g., Many `Students` enroll in Many `Courses`)

### 3. Converting ER Models to Relational Schemas
To map an abstract ER Diagram into actual SQL database engine tables, strict relational conversion rules are followed:
* **Strong Entities:** Convert directly into individual tables; the Primary Key maps to the table's Primary Key.
* **Attributes:** Map directly to table columns with appropriate data types.
* **1:M Relationships:** The Primary Key from the "One" side is duplicated and embedded into the "Many" side table as a *Foreign Key* to establish the link.
* **M:N Relationships:** Cannot be mapped directly using columns. They require the creation of an entirely new bridge table (Associative Entity) containing the Primary Keys of both participating entities combined as a composite key.

---

## 💾 SQL Scripts Progress Index
* **`01_schema_and_queries.sql`**
  * Implements explicit database generation instructions, controls constraint systems (`PRIMARY KEY`, `FOREIGN KEY`, `CHECK`), maps relational logic matrices (`EXISTS`, `ALL`, `UNION`), clusters aggregated outputs (`GROUP BY`, `HAVING`), and establishes isolated storage masks using virtual `VIEWS`.

### Phase 2: DDL Implementations & Advanced Queries
*(The script files below contain the complete implementation of this structural schema.)*
