# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this module.

## Module Overview

The `accounting_and_budgeting-database` module manages database schema and data for the accounting and budgeting domain of the ERP system. This is a database-only module that uses Liquibase for schema migrations and provides Docker containerization for PostgreSQL database instances.

## Technology Stack

- **Database**: PostgreSQL
- **Migration Tool**: Liquibase 3.5.3
- **Container**: Docker
- **Package Manager**: npm
- **Testing**: Cucumber.js with BDD approach
- **Test Database**: pg-promise for database connections

## Project Structure

```
accounting_and_budgeting-database/
├── Dockerfile                    # Database container configuration
├── database_change_log.yml       # Liquibase main changelog
├── databasechangelog.csv        # Liquibase execution history
├── package.json                 # Node.js dependencies and scripts
├── sql/                         # Database initialization scripts
│   ├── 01-install-extensions.sql
│   ├── 02-create-database.sql
│   └── 03-initial-data.sql
└── features/                    # BDD test specifications
    ├── step_definitions/
    └── support/
```

## Build and Development Commands

### Database Operations
```bash
# Build database schema (offline)
npm run build:database

# Build Docker container
npm run build:docker

# Apply database changes to running database
npm run update_database

# Start database container
npm run start

# Push container to registry
npm run push

# Clean up build artifacts and containers
npm run clean
```

### Testing
```bash
# Run BDD tests for accounting database
npm test
```

## Development Workflow

### Database Schema Changes
1. **Create Liquibase Changeset**: Add new changesets to `database_change_log.yml`
2. **Test Offline**: Use `npm run build:database` to generate SQL and verify syntax
3. **Apply Changes**: Use `npm run update_database` to apply to development database
4. **Write Tests**: Create BDD scenarios in the `features/` directory
5. **Run Tests**: Execute `npm test` to validate database behavior

### Key Configuration Files

- **database_change_log.yml**: Main Liquibase changelog - all schema changes must be added here
- **Dockerfile**: Defines PostgreSQL container with initialization scripts
- **package.json**: Contains build scripts and test configuration

### Database Connection Details
- **Default Database**: invoice (as configured in update_database script)
- **Default Port**: 5432
- **Container Name**: accounting-and-budgeting_database

## Testing Standards

This module follows BDD (Behavior Driven Development) practices:

- **Test Framework**: Cucumber.js
- **Database Testing**: Direct PostgreSQL connections via pg-promise
- **Test Organization**: Features in `features/` directory with step definitions
- **Test Tags**: Use `@accounting_database` tag for test filtering

### Test Environment Setup
- Tests require a running PostgreSQL database
- Database connection configured in `features/support/config.js`
- Test data setup/cleanup managed through `hooks.js`

## Dependencies and Requirements

### Runtime Dependencies
- PostgreSQL database server
- Docker (for containerized deployment)
- Liquibase 3.5.3 (included in build)

### Development Dependencies
- Node.js and npm
- Cucumber.js testing framework
- Chai assertion library
- pg-promise for database connectivity

## Important Notes

- **No Unit Tests**: Database modules focus on integration testing through BDD scenarios
- **Schema Versioning**: All changes must go through Liquibase changesets
- **Container Focus**: This module is designed for containerized deployment
- **Domain Specific**: Contains only accounting and budgeting related database artifacts

## Docker Integration

The module produces a Docker container named `erpmicroservices/accounting-and-budgeting_database` that:
- Extends PostgreSQL base image
- Runs initialization scripts on startup
- Exposes standard PostgreSQL port (5432)
- Can be integrated into docker-compose configurations