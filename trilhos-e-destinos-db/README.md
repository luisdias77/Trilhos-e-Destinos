# Trilhos e Destinos: Travel Agency Database System

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Grade](https://img.shields.io/badge/Final%20grade-16%2F20-success?style=for-the-badge)

Databases (Bases de Dados) course project, **BSc in Informatics Engineering, University of Minho (2025/2026)**. Built by a team of three, **graded 16/20**.

The project covers the full lifecycle of a relational database for a fictional travel agency, "Trilhos e Destinos", that wants to move from a purely in-person model to an interactive digital platform. Users can browse destinations, see photos and videos, and rate and comment on trips. The full 86-page report (in Portuguese) documents every stage.

## What was done

| Phase | Highlights |
| --- | --- |
| **System definition** | Context, motivation, objectives, feasibility, team and resources, execution plan (Gantt chart) |
| **Requirements** | Gathered through a meeting and a questionnaire, then documented and validated as description, control and manipulation requirements |
| **Conceptual model** | ER diagram with entities such as Employee, Client, Role, Trip, Comment and Content (specialised into photo, video and 3D), with relationships and attributes fully characterised |
| **Logical model** | Derived from the ER model and normalised up to **3NF**, then validated with user queries written in relational algebra (RelaX) |
| **Physical implementation** | MySQL schema built in MySQL Workbench, with UNIQUE constraints (e.g. NIF) and auto-generated IDs |
| **Security** | Role-based access control with three roles (Client, Employee, Manager), each with its own privileges |
| **SQL queries** | User requirements translated into SQL: managing trips, searching destinations, reading comments, adding content and registering bookings |
| **Indexing** | Indexes for the most frequent searches (by location, date range, client NIF, bookings per trip and per period) |
| **Programmability** | Stored procedures and functions (e.g. booking registration, client total spend, average trip rating) and a trigger that prevents a guide from being assigned to overlapping trips |
| **Data migration** | Python program that bulk-loads clients and trips from CSV files into MySQL |

## What's in this repository

- `sql/01_criacao_bd.sql`: database creation, all tables with their constraints, and the Client / Employee / Manager roles with their permissions
- `sql/02_consultas.sql`: example queries for the main requirements. It includes `DELETE` statements, so run it block by block
- `docs/Relatorio_Base_de_Dados.pdf`: the complete report (Portuguese), which also documents the indexes, procedures, functions, trigger and migration tool

## How to run

1. Install MySQL 8+ (or use MySQL Workbench).
2. Create the database and tables:

```
mysql -u root -p < sql/01_criacao_bd.sql
```

3. Open `sql/02_consultas.sql` and run the queries you want.

The sample users and passwords in `01_criacao_bd.sql` are for demonstration only.

## Known limitations

- Rating values are not range-checked at database level, so values outside the intended scale can still be inserted. A `CHECK` constraint would fix this.
- Client passwords are stored as plain text. A real system would store a salted hash.

## Tech stack

MySQL, MySQL Workbench, SQL (DDL, DML, roles and privileges), RelaX (relational algebra)
