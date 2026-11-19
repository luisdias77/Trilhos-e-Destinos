# Trilhos e Destinos: Travel Agency Database System

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Grade](https://img.shields.io/badge/Final%20grade-16%2F20-success?style=for-the-badge)

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
| **Population and sizing** | Database populated with sample data, plus initial storage estimate and yearly growth rate |
| **SQL and indexing** | User queries translated to SQL, and indexes created for the most frequent searches (by location, date range, client NIF, bookings per trip and per period) |
| **Programmability** | Stored procedures, functions and a trigger (below) |
| **Data migration** | Python program that bulk-loads clients and trips from CSV files into MySQL |

## Stored routines and triggers

- `AdicionarFuncionarioComTelemovel`: inserts an employee and their phone number inside a **transaction**, rolling back if either insert fails
- `RegistarReserva`: registers a booking, timestamping it on the server with `NOW()`
- `ObterTotalGastoCliente`: returns a client's total spend, useful for customer profiling
- `ObterMediaAvaliacaoViagem`: returns the average rating of a trip
- `VerificarDisponibilidadeGuia` (trigger): blocks assigning a guide to overlapping trips, raising an error on conflict

## Data migration tool

A Python script using `mysql.connector` reads CSV files and inserts clients and trips, the two most volatile and highest-volume entities, which would come from partners or advertising campaigns.

## Known limitations

Rating values are not range-checked at database level, so values outside the intended scale can still be inserted. A `CHECK` constraint would fix this.

## Tech stack

MySQL, MySQL Workbench, SQL (DDL, DML, roles, indexes, procedures, functions, triggers), Python, RelaX (relational algebra)

## Report

The complete report (Portuguese) is available in [`Relatorio_Base_de_Dados.pdf`](./Relatorio_Base_de_Dados.pdf).
