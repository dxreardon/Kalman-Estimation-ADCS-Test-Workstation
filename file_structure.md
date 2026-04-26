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
