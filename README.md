# FT Markets

Technical exercise implementation for the FT Engineering iOS Tech Test.

This repository currently focuses on **Exercise 1: Retrieve and prepare the data**.

The UI portion will be completed separately during the paired programming session.

---

# Exercise 1

The application retrieves securities quote data from the FT Securities Quotes API for:

* FTSE 100
* S&P 500
* Euro/Dollar
* Pound/Dollar
* Brent Crude Oil

The API integration uses Swift concurrency (`async/await`) and a layered architecture focused on separation of concerns, scalability, and testability.

---

# Architecture

The project uses a layered architecture inspired by SOLID principles.

Application flow:

```text
UseCase
→ Repository
→ APIClient
```

## Responsibilities

### APIClient

Responsible for:

* Request construction
* Network execution
* Response validation
* JSON decoding

The networking layer was intentionally separated into focused collaborators to improve readability and testability.

### Repository

Responsible for:

* Fetching remote data
* Mapping DTOs into domain models

The repository layer isolates transport models from the rest of the application.

### UseCase

Responsible for:

* Coordinating business actions
* Providing a clean interface to consumers

---

# Networking

The networking layer uses:

* Swift concurrency (`async/await`)
* Dependency injection
* Protocol abstractions
* Structured error handling

The architecture also allows future enhancements such as:

* Authentication
* Caching
* Pagination
* Retry policies
* Offline persistence

without requiring major architectural changes.

---

# Progressive Enhancement

The implementation was intentionally designed to remain simple while still supporting future growth.

Examples include:

* Reusable networking infrastructure
* Protocol-based abstractions
* DTO → Domain model mapping
* Testable architecture boundaries

The goal was to avoid over-engineering while still allowing the project to scale cleanly if requirements evolve further.

# Error Handling

The project includes structured networking error handling for:

* Invalid responses
* HTTP status failures
* Decoding failures
* Network connectivity issues

---

# Testing

The project uses the modern Swift Testing framework.

Coverage includes:

* APIClient
* Repository mapping
* Use cases
* Error propagation
* JSON decoding
* Invalid and slow network scenarios

JSON fixtures are stored separately within the test bundle to validate decoding against realistic API responses.

---

# Design Decisions

## Optional Financial Values

Missing financial values from the API are intentionally preserved as `nil` rather than defaulting to zero.

For financial applications, missing data carries different meaning from an actual value of `0`.

---

