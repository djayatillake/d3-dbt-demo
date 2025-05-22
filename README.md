# D3 DBT Demo

This monorepo contains both a dbt project and a Cube.js semantic layer that works together to provide a modern data stack.

## Project Structure

```
d3-dbt-demo/
├── dbt/                 # dbt project for data transformations
│   ├── models/         # dbt models (staging, intermediate, mart)
│   ├── seeds/          # CSV seed files with sample data
│   └── dbt_project.yml # dbt project configuration
├── cube/               # Cube.js project
│   ├── schema/         # Cube.js schema definitions (cubes)
│   └── schema/views/   # Cube.js views
└── package.json       # Root package.json with workspace configuration
```

## Setup

1. Install dependencies:
```bash
npm install
```

2. Configure your database connection in both projects:
   - For dbt: Create a `profiles.yml` file
   - For Cube.js: Create a `.env` file with database credentials

## Usage

1. Run dbt transformations:
```bash
npm run dbt-run
```

2. Start Cube.js development server:
```bash
npm start
```

The Cube.js server will automatically pick up the tables created by dbt and use them in its semantic layer.
