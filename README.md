# ADCS Kalman Test Workstation

A Python/Linux GN&C simulation and verification workstation for a reaction-wheel spacecraft attitude-control system with multi-sensor Kalman state estimation.

## 1. Project Purpose

This project demonstrates an integrated engineering workflow for:

- spacecraft attitude dynamics simulation
- reaction wheel control
- noisy sensor modeling
- Kalman state estimation
- closed-loop attitude control
- automated scenario execution
- requirement verification
- logging, plotting, and report generation

The project is intentionally structured like a miniature GN&C integration and test environment rather than a single simulation script.

## 2. System Concept

The simulated system represents a single-axis spacecraft attitude-control loop.

The core loop is:

```text
truth dynamics
    ↓
sensor models
    ↓
state estimator
    ↓
controller
    ↓
reaction wheel torque command
    ↓
truth dynamics
