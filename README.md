# AgroSim Lab

[Version française](README.fr.md)

A MATLAB/Simulink virtual lab that models the volumetric water content of a soil layer and compares water management strategies, with a strong focus on **verification, validation and traceability**.

> **Disclaimer.** All parameters are **illustrative demonstration values**, not field measurements. This project is a testable dynamic model, not an operational agricultural decision tool.

## Why this project

Agriculture faces two opposite risks: excess water after heavy rain or flooding, and water deficit during dry periods. AgroSim Lab studies both with a simple, transparent model where every equation is understood, every assumption is documented and every behaviour is demonstrated by tests.

## Model in one line

```text
Zr * d(theta)/dt = Pe + I - ET - Dn - Dc - R
```

| Symbol | Meaning | Unit |
|---|---|---|
| theta | Volumetric water content | m3/m3 |
| Zr | Effective soil layer depth | mm |
| Pe | Infiltrated rainfall | mm/h |
| I | Irrigation | mm/h |
| ET | Evapotranspiration | mm/h |
| Dn / Dc | Natural / controlled drainage | mm/h |
| R | Surface runoff | mm/h |

## Scope

| Version | Content | Status |
|---|---|---|
| V1 | Single-state model, mass balance diagnostics, hysteresis control, 10 test scenarios | In progress |
| V2 | Runoff, flood input, sensitivity analysis, improved control | Planned |
| V3 | Multilayer model, noisy measurement, real weather data | Optional |

## Roadmap

| Milestone | Goal | Status |
|---|---|---|
| G0 | Repository setup and documentation baseline | Done when tag v0.0-setup exists |
| G1 | Executable model and first curves | Todo |
| G2 | Numerical verification report | Todo |
| G3 | Baseline controller tested | Todo |
| G4 | Reproducible strategy comparison | Todo |
| G5 | Reproducible validation campaign | Todo |
| G6 | Publishable v1.0.0 | Todo |

## Repository structure

```text
AgroSim-Lab/
├── docs/          specification, assumptions, architecture, V&V plan, risks
├── matlab/        parameters, scenarios, metrics, plotting scripts
├── simulink/      AgroSimLab.slx model
├── tests/         unit, integration and scenario tests
├── results/       generated figures
├── reports/       test and verification reports
└── captures/      screenshots used in the documentation
```

## Requirements

MATLAB and Simulink (base). Optional toolboxes: Simulink Test, Simulink Requirements, Simulink Design Verifier, Simulink Control Design, Model Predictive Control Toolbox, MATLAB Report Generator. The V1 must run with base MATLAB and Simulink.

## Getting started

Instructions will be added at milestone G1.

## Documentation

- [Technical specification (French)](docs/cahier_des_charges.md)
- [Model assumptions](docs/model_assumptions.md)
- [Risk register](docs/risk_register.md)
- [Work log](docs/worklog.md)

## License

MIT. See [LICENSE](LICENSE).