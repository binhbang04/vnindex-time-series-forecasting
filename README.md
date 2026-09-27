# VN-Index Time Series Forecasting

## Overview
Time series analysis and forecasting of the **VN-Index** (Vietnam Stock Market Index) using econometric models in **Stata**. The project examines the relationship between VN-Index returns and macroeconomic indicators including USD/VND exchange rate, gold prices, and oil prices.

## Dataset
- **VNINDEX.dta** — Monthly time series data containing:
  - `VNINDEX`: VN-Index daily change (%)
  - `USD_VND`: USD/VND exchange rate change (%)
  - `FED`: Federal Reserve interest rate
  - `AUD`: Gold price change (%)
  - `WTI`: Oil price change (%)

## Methodology

### 1. Stationarity Testing
- Augmented Dickey-Fuller (ADF) test
- Correlogram analysis (ACF/PACF)
- White noise tests

### 2. ARMA / ARIMA Models
- Model identification via ACF/PACF
- ARIMA(1,0,1), ARIMA(3,0,1), ARIMA(1,0,2) estimation
- Automatic ARIMA selection (`arimaauto`)

### 3. ARCH-GARCH Models
- ARCH-LM test for heteroskedasticity
- ARCH(1), ARCH(2), ARCH(3) estimation
- Multivariate GARCH (CCC specification)

### 4. VAR Model (Vector Autoregression)
- Lag selection using information criteria (AIC, BIC, HQIC)
- VAR estimation with VNINDEX, USD_VND, AUD, WTI
- Granger causality test
- Impulse Response Function (IRF) analysis
- Residual diagnostics (autocorrelation, normality, stability)

### 5. VECM (Vector Error Correction Model)
- Johansen cointegration rank test (`vecrank`)
- VECM estimation
- Residual diagnostics

## Tech Stack
- **Stata** (econometric analysis)
- Time series commands: `arima`, `arch`, `var`, `vec`, `dfuller`, `varsoc`, `irf`

## Project Structure
```
├── analysis.do              # Data cleaning & variable renaming
├── run_analysis.do          # Full analysis pipeline
├── VNINDEX.dta              # Dataset (Stata format)
├── report_vnindex.pdf       # Detailed report
├── .gitignore
└── README.md
```

## How to Run
1. Open **Stata**
2. Load the dataset: `use "VNINDEX.dta"`
3. Run the analysis: `do "run_analysis.do"`
