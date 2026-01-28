Ab Initio-Style ETL Platform – End-to-End CI/CD POC
📌 Overview

This repository demonstrates a real-world enterprise ETL platform POC, inspired by Ab Initio orchestration concepts, implemented using open-source tools and GitHub Actions.

The goal of this POC is to show how:

Ab Initio-style graphs and interfaces can be versioned in Git

ETL components can be built, validated, tested, scanned, containerized, and promoted

CI/CD pipelines can enforce quality gates, environment gates, and approvals

The same ETL component can be executed in DEV / UAT / PROD-like environments

All of this can be achieved using only free tools
🔑 Key Concepts Implemented
1️⃣ Ab Initio-Style Contracts

interface.yml defines inputs, outputs, schema

Go ETL code validates schema at runtime

Prevents schema drift (backward compatibility checks)

2️⃣ Orchestration (No Transformation in Graphs)

orchestrator.air represents flow control

Actual transformations are implemented in Go

Mirrors real Ab Initio usage

3️⃣ CI/CD Gating

DEV: build, test, schema validation

UAT: image promotion + smoke test

PROD: manual approval + immutable release

4️⃣ SonarQube Integration

Static analysis for:

Go

Shell scripts

Gradle

Enforced Quality Gates

Pipeline fails automatically if gate fails

5️⃣ Versioning & Rollback

Docker images tagged with:

Environment (dev, uat, prod)

Git SHA

Semantic version

Rollback = redeploy previous tag (no rebuild)

🔄 CI/CD Workflow (Summary)
DEV Stage

Pre-build validation

Run ETL locally

Build TAR artifact

Run Go unit tests

Sonar scan + Quality Gate

Build & push DEV Docker image

UAT Stage

Pull DEV image

Run UAT smoke test

Promote image → *-uat

PROD Stage

Manual approval (GitHub Environment)

Promote image → *-prod

Immutable release

PROD Runtime

Manual or scheduled execution

Docker-based ETL run

▶️ How to Run Locally
Run ETL locally
go run transforms/user_aggregate.go

Run full pipeline logic
chmod +x runtime/master_pipeline.sh
./runtime/master_pipeline.sh

🧪 Testing Strategy

Unit Tests: Go (*_test.go)

Schema Validation: Runtime enforcement via interface.yml

Backward Compatibility: CI script

Quality Gate: SonarCloud

Smoke Tests: Docker runtime execution
