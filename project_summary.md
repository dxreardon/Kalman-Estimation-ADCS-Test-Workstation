You can combine them into one stronger project by making the **reaction wheel ADCS simulator** the “system under test,” the **multi-sensor Kalman tracking/fusion logic** the “estimation subsystem,” and the **Linux automated test workstation** the “verification and integration harness.”

The combined project becomes:

# Linux-Based ADCS Test Workstation with Multi-Sensor Kalman Estimation

## One-sentence version

Build a Linux/Python test workstation that runs a simulated spacecraft attitude-control system, injects noisy/asynchronous sensor data, estimates attitude with Kalman filtering, controls a reaction wheel, verifies performance requirements, and automatically generates plots, logs, and pass/fail reports.

This is much stronger than doing the three projects separately because it tells one engineering story:

> “I built a miniature GN&C integration and verification environment.”

That maps well to controls, GN&C, test, systems, simulation, and embedded-adjacent roles.

---

# 1) How the three projects fit together

## Project A: Reaction wheel ADCS simulator

This becomes the **plant / device under test**.

It provides:

* spacecraft attitude dynamics
* reaction wheel actuator model
* controller
* commanded attitude scenarios
* disturbance rejection scenarios
* truth-state output

Your earlier reaction-wheel template already frames this as a Raspberry Pi/Linux/Python project with attitude dynamics, reaction wheel torque command, noisy sensors, a controller, estimator, plots, and verification results. 

## Project B: Multi-sensor Kalman tracking

This becomes the **state estimation and sensor fusion layer**.

Instead of tracking a generic moving target in 2D, you apply the same concept to spacecraft attitude estimation.

It provides:

* gyro-like angular rate measurements
* coarse attitude sensor measurements
* optional star-tracker-like angle measurements
* sensor dropout
* sensor bias
* asynchronous update rates
* Kalman filter state estimation

Your state vector can be simple:

[
x =
\begin{bmatrix}
\theta \
\omega
\end{bmatrix}
]

Where:

* (\theta) = spacecraft attitude angle
* (\omega) = angular rate

## Project C: Linux automated test workstation

This becomes the **test harness / verification environment**.

It provides:

* one-command test execution
* configuration-driven test cases
* raw log capture
* parsed telemetry
* automated requirement checks
* generated plots
* generated reports
* regression-style test runs

That directly matches the Linux workstation project concept: connect to a DUT or simulated target, execute automated test scripts, capture and analyze data, check requirements, and generate repeatable pass/fail evidence. 

---

# 2) The unified architecture

Think of the project as four layers.

```text
┌──────────────────────────────────────────────┐
│ Linux Test Workstation / Verification Harness │
│ - runs scenarios                              │
│ - loads configs                               │
│ - captures logs                               │
│ - checks requirements                         │
│ - generates reports                           │
└──────────────────────────────────────────────┘
                    │
                    ▼
┌──────────────────────────────────────────────┐
│ Scenario Runner                              │
│ - command step                               │
│ - disturbance rejection                       │
│ - sensor dropout                              │
│ - biased gyro                                 │
│ - actuator saturation                         │
└──────────────────────────────────────────────┘
                    │
                    ▼
┌──────────────────────────────────────────────┐
│ ADCS Simulation                              │
│ - attitude dynamics                           │
│ - reaction wheel actuator                     │
│ - controller                                  │
│ - sensor models                               │
│ - estimator                                   │
└──────────────────────────────────────────────┘
                    │
                    ▼
┌──────────────────────────────────────────────┐
│ Evidence Products                            │
│ - CSV logs                                    │
│ - plots                                       │
│ - metrics                                     │
│ - pass/fail tables                            │
│ - final report                                │
└──────────────────────────────────────────────┘
```

The cleanest framing is:

> The simulator is the DUT.
> The Kalman filter is the onboard estimation logic.
> The Linux workstation is the ground-test and verification system.

---

# 3) Recommended combined file structure

```text
adcs_kalman_test_workstation/
│
├── README.md
├── requirements.txt
├── pyproject.toml
├── .gitignore
├── setup.sh
│
├── configs/
│   ├── default.yaml
│   ├── vehicle_params.yaml
│   ├── sensor_config.yaml
│   ├── estimator_config.yaml
│   ├── controller_config.yaml
│   ├── limits.yaml
│   ├── nominal_case.yaml
│   ├── dropout_case.yaml
│   ├── bias_case.yaml
│   ├── saturation_case.yaml
│   └── regression_suite.yaml
│
├── docs/
│   ├── project_overview.md
│   ├── system_architecture.md
│   ├── assumptions.md
│   ├── requirements.md
│   ├── verification_matrix.md
│   ├── dynamics_model.md
│   ├── sensor_models.md
│   ├── estimator_design.md
│   ├── controller_design.md
│   ├── test_plan.md
│   ├── troubleshooting_guide.md
│   ├── discrepancy_log.md
│   └── final_report.md
│
├── src/
│   ├── main.py
│   │
│   ├── workstation/
│   │   ├── test_runner.py
│   │   ├── regression_runner.py
│   │   ├── session_manager.py
│   │   ├── config_loader.py
│   │   └── run_archive.py
│   │
│   ├── dynamics/
│   │   ├── rigid_body_1d.py
│   │   ├── reaction_wheel.py
│   │   └── integrator.py
│   │
│   ├── sensors/
│   │   ├── sensor_base.py
│   │   ├── gyro_sensor.py
│   │   ├── attitude_sensor.py
│   │   ├── sensor_scheduler.py
│   │   ├── dropout_model.py
│   │   └── noise_models.py
│   │
│   ├── estimators/
│   │   ├── kalman_filter.py
│   │   ├── complementary_filter.py
│   │   └── estimator_base.py
│   │
│   ├── controllers/
│   │   ├── pd_controller.py
│   │   ├── pid_controller.py
│   │   └── saturation.py
│   │
│   ├── scenarios/
│   │   ├── command_step.py
│   │   ├── disturbance_rejection.py
│   │   ├── sensor_dropout_case.py
│   │   ├── gyro_bias_case.py
│   │   └── actuator_saturation_case.py
│   │
│   ├── analysis/
│   │   ├── compute_metrics.py
│   │   ├── requirement_checks.py
│   │   ├── plot_results.py
│   │   └── summarize_results.py
│   │
│   ├── reporting/
│   │   ├── generate_markdown_report.py
│   │   ├── export_csv_summary.py
│   │   └── build_final_report.py
│   │
│   └── utils/
│       ├── logger.py
│       ├── timestamping.py
│       ├── units.py
│       └── constants.py
│
├── tests/
│   ├── test_dynamics.py
│   ├── test_sensor_models.py
│   ├── test_kalman_filter.py
│   ├── test_controller.py
│   ├── test_requirement_checks.py
│   └── test_regression_runner.py
│
├── scripts/
│   ├── run_nominal.sh
│   ├── run_dropout_case.sh
│   ├── run_bias_case.sh
│   ├── run_saturation_case.sh
│   ├── run_regression.sh
│   └── clean_outputs.sh
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── archived_runs/
│
├── results/
│   ├── plots/
│   ├── tables/
│   ├── reports/
│   └── screenshots/
│
└── notebooks/
    └── exploratory_analysis.ipynb
```

This preserves the best structure from all three projects: separated dynamics, sensors, controllers, estimators, scenarios, analysis, reporting, configs, and evidence.

---

# 4) The actual simulation concept

## Minimum viable physical model

Start with a **1-axis spacecraft attitude model**:

[
J\ddot{\theta} = \tau_{rw} + \tau_d
]

Where:

* (J) = spacecraft rotational inertia
* (\theta) = attitude angle
* (\omega = \dot{\theta}) = angular rate
* (\tau_{rw}) = reaction wheel control torque
* (\tau_d) = disturbance torque

State:

[
x =
\begin{bmatrix}
\theta \
\omega
\end{bmatrix}
]

Discrete update:

[
\theta_{k+1} = \theta_k + \omega_k \Delta t
]

[
\omega_{k+1} = \omega_k + \frac{\tau}{J}\Delta t
]

This is enough for a weekend-scale project and aligns with the prior recommendation that a strong one-axis simulator is better than a messy three-axis version. 

---

# 5) Sensor fusion design

Use two or three simulated sensors.

## Sensor 1: gyro-like rate sensor

Measures angular rate:

[
z_{\omega} = \omega + b + n
]

Where:

* (b) = optional gyro bias
* (n) = random noise

Use it at a high rate, for example 50–100 Hz.

## Sensor 2: coarse attitude sensor

Measures angle:

[
z_{\theta} = \theta + n
]

Use it at a lower rate, for example 5–10 Hz.

## Sensor 3: optional star-tracker-like sensor

Measures attitude more accurately but less frequently.

Use it at 1 Hz or only in some scenarios.

This gives you a realistic multi-sensor fusion problem:

* fast noisy rate data
* slow cleaner attitude data
* optional dropout
* optional bias
* asynchronous measurements

That is much more compelling than a generic Kalman filter demo.

---

# 6) Kalman filter role

The Kalman filter estimates:

```text
theta_est
omega_est
```

from noisy sensor measurements.

You can run two modes:

## Mode 1: controller uses truth state

This is the debugging baseline.

```text
truth state → controller → reaction wheel torque
```

## Mode 2: controller uses estimated state

This is the real GN&C version.

```text
sensors → Kalman filter → estimated state → controller → reaction wheel torque
```

Then compare:

* no estimator
* raw measurements only
* Kalman-estimated state

This gives you a strong engineering discussion about estimator lag, noise rejection, controller stability, and tuning tradeoffs.

---

# 7) Controller design

Use a simple PD controller first:

[
\tau_{cmd} = K_p(\theta_{cmd} - \hat{\theta}) + K_d(0 - \hat{\omega})
]

Then apply saturation:

```python
tau_cmd = np.clip(tau_cmd, -max_torque, max_torque)
```

This is the right level of realism. Your earlier reaction-wheel project specifically identified actuator saturation as a valuable realism upgrade and off-nominal test case. 

---

# 8) What the Linux workstation does

The Linux workstation is not just a folder of scripts. It is the thing that makes this feel like a professional integration project.

It should:

1. Load a scenario config.
2. Run the simulation.
3. Capture truth, measurements, estimates, commands, and errors.
4. Save raw logs in a timestamped run folder.
5. Parse logs into processed data.
6. Compute metrics.
7. Check requirements.
8. Generate plots.
9. Generate a report.
10. Archive the run.

This directly reflects the test-workstation pattern: initialize, configure, stimulate, observe, log, check, summarize, and shut down. 

---

# 9) Example requirements

Use requirements that connect all three project themes.

| ID      | Requirement                                                                                     | Verification Method      |
| ------- | ----------------------------------------------------------------------------------------------- | ------------------------ |
| ADCS-R1 | The simulator shall model 1-axis spacecraft attitude dynamics with reaction wheel torque input. | Unit test + nominal run  |
| ADCS-R2 | The controller shall reduce a 10-degree initial attitude error to less than 1 degree.           | Scenario test            |
| ADCS-R3 | The closed-loop system shall settle within 5 seconds under nominal conditions.                  | Metric check             |
| ADCS-R4 | The actuator command shall remain within configured torque saturation limits.                   | Log check                |
| EST-R1  | The estimator shall estimate attitude and angular rate from noisy measurements.                 | Estimator test           |
| EST-R2  | The estimator shall maintain RMS attitude error below a defined threshold.                      | Metric check             |
| EST-R3  | The estimator shall continue operating during temporary attitude-sensor dropout.                | Dropout scenario         |
| TEST-R1 | The workstation shall execute a selected scenario from a configuration file.                    | Regression test          |
| TEST-R2 | The workstation shall archive raw logs for each run in a timestamped directory.                 | File inspection          |
| TEST-R3 | The workstation shall generate a human-readable report for each run.                            | Report check             |
| TEST-R4 | The workstation shall produce pass/fail results against defined limits.                         | Requirement-check module |

This is where the project becomes visibly systems-engineering-relevant.

---

# 10) Recommended scenarios

## Scenario 1: Nominal command step

Command the spacecraft from 0 degrees to 10 degrees.

Demonstrates:

* dynamics
* controller
* estimator
* settling time
* overshoot
* control effort

## Scenario 2: Disturbance rejection

Start at 0 degrees, inject a disturbance torque, and verify recovery.

Demonstrates:

* closed-loop stability
* control authority
* disturbance rejection

## Scenario 3: Sensor dropout

Temporarily remove the attitude sensor.

Demonstrates:

* estimator robustness
* dependence on gyro propagation
* recovery after measurement returns

## Scenario 4: Gyro bias

Add a small gyro bias.

Demonstrates:

* estimation error growth
* residual analysis
* tuning tradeoffs

## Scenario 5: Actuator saturation

Limit reaction wheel torque.

Demonstrates:

* realistic actuator constraints
* degraded settling time
* requirement failure or margin analysis

## Scenario 6: Regression suite

Run all scenarios automatically.

Demonstrates:

* Linux automation
* repeatable test execution
* report generation
* configuration-driven verification

---

# 11) Metrics to compute

At minimum, compute:

| Metric                        | Why it matters                 |
| ----------------------------- | ------------------------------ |
| Settling time                 | Controls performance           |
| Overshoot                     | Controller tuning quality      |
| Steady-state error            | Final pointing accuracy        |
| RMS attitude estimation error | Kalman filter performance      |
| RMS rate estimation error     | Gyro/rate estimation quality   |
| Max attitude error            | Worst-case performance         |
| Max torque command            | Actuator margin                |
| Time in saturation            | Actuator stress/limit behavior |
| Dropout recovery time         | Fault/off-nominal robustness   |
| Pass/fail status              | Verification evidence          |

These metrics let you avoid the weak version of the project: “I made plots.”
Instead, you can say: “I verified requirements.”

---

# 12) Best build order

Do not build everything at once.

## Phase 1: Build the plant

Implement:

* 1-axis dynamics
* reaction wheel torque input
* numerical integration
* truth-state logging

Deliverable:

* open-loop simulation plot

## Phase 2: Add controller

Implement:

* PD controller
* command step
* torque saturation

Deliverable:

* closed-loop attitude response plot

## Phase 3: Add sensors

Implement:

* noisy angle sensor
* noisy rate sensor
* asynchronous update rates

Deliverable:

* truth vs noisy measurements plot

## Phase 4: Add Kalman filter

Implement:

* state estimate
* covariance tracking
* measurement updates

Deliverable:

* truth vs measurement vs estimate plot

## Phase 5: Put estimator in the loop

Change controller input from truth state to estimated state.

Deliverable:

* comparison of truth-feedback control vs estimator-feedback control

## Phase 6: Add Linux test harness

Implement:

* config loading
* one-command runs
* timestamped output folders
* raw logs
* processed results

Deliverable:

```bash
./scripts/run_nominal.sh
```

## Phase 7: Add verification

Implement:

* requirement checks
* metrics
* pass/fail summary
* generated report

Deliverable:

* markdown or PDF-style run report

## Phase 8: Add off-nominal scenarios

Implement:

* dropout
* bias
* saturation
* disturbance

Deliverable:

```bash
./scripts/run_regression.sh
```

---

# 13) Strong minimum viable version

The smallest version worth doing:

* 1-axis attitude model
* reaction wheel torque input
* PD controller
* noisy angle sensor
* noisy rate sensor
* Kalman filter estimating angle and rate
* one nominal command-step case
* one disturbance-rejection case
* one sensor-dropout case
* one-command Linux run script
* CSV logs
* plots
* pass/fail requirements
* short final report

That is already a strong portfolio project.

---

# 14) Stronger version

Add these only after the minimum version works:

* asynchronous sensor rates
* gyro bias
* actuator saturation
* Monte Carlo noise runs
* 3-axis architecture scaffold
* simulated serial/TCP interface between workstation and simulator
* report generator that produces a full run summary
* comparison between complementary filter and Kalman filter
* automated regression suite

The simulated serial/TCP interface is especially useful if you want the project to look more like hardware-in-the-loop testing. The simulator can behave like a DUT, and the Linux workstation can communicate with it through an interface abstraction instead of directly importing functions.

---

# 15) Best final project title options

Strongest:

> Linux-Based ADCS Verification Workstation with Kalman Sensor Fusion

More GN&C-focused:

> Reaction Wheel Attitude Control Simulator with Multi-Sensor Kalman Estimation

More test/integration-focused:

> Automated GN&C Test Workstation for Reaction Wheel Attitude Control Verification

More resume-friendly:

> Python/Linux GN&C Simulation and Verification Harness for Reaction Wheel Attitude Control

My recommendation:

# Automated GN&C Test Workstation for Reaction Wheel Attitude Control with Kalman Sensor Fusion

That title captures all three projects without sounding bloated.

---

# 16) Resume bullet version

Use something like this:

> Developed a Python/Linux GN&C test workstation that simulated single-axis spacecraft attitude dynamics with a reaction-wheel actuator, fused noisy asynchronous attitude/rate sensor measurements using a Kalman filter, executed automated nominal and off-nominal test scenarios, and generated timestamped logs, plots, metrics, and pass/fail verification reports.

A more technical version:

> Built a configuration-driven ADCS simulation and verification harness in Python, including rigid-body attitude dynamics, reaction wheel torque saturation, noisy gyro/attitude sensor models, Kalman state estimation, PD control, automated regression scenarios, RMS error analysis, settling-time checks, and reproducible Linux-based test reports.

A shorter version:

> Created a Linux-based automated test harness for a reaction-wheel attitude-control simulation with Kalman sensor fusion, requirements verification, and generated evidence reports.

---

# 17) Interview story

The best way to explain it:

> “I wanted to avoid building three disconnected portfolio demos, so I combined them into one miniature GN&C integration environment. The simulated spacecraft ADCS was the system under test. The Kalman filter estimated attitude and rate from noisy asynchronous sensors. The Linux workstation ran configured scenarios, captured logs, computed metrics, checked requirements, and generated reports. That let me demonstrate controls, estimation, Python, Linux automation, requirements verification, and technical documentation in one coherent project.”

That is the real value: it sounds like something an engineer would actually build.
