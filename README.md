# Industrial Machine Predictive Maintenance

## 📌 Project Overview

This project focuses on analyzing industrial machine data to identify machine health patterns, failure risks, Remaining Useful Life (RUL), and maintenance-related insights.

It is being developed as an end-to-end analytics project and will be extended step-by-step with **Python EDA → MySQL/SQL → Power BI**, with Machine Learning as a future extension.

## 🎯 Project Objectives

- Understand industrial machine sensor data
- Clean and validate the dataset
- Perform Exploratory Data Analysis (EDA)
- Analyze machine failure patterns
- Analyze Remaining Useful Life (RUL)
- Identify high-risk machines
- Generate business and maintenance insights
- Perform SQL-based analysis using MySQL
- Build an interactive Power BI dashboard

## 🗂️ Project Structure

```text
industrial-machine-predictive-maintenance/
│
├── README.md
├── data/
│   └── predictive_maintenance_v3.csv
├── notebooks/
│   └── Industrial_Machine_Predictive_Maintenance_EDA.ipynb
├── sql/
├── powerbi/
├── ml/
└── images/
```

## 🔄 Project Roadmap

### Part 1 — Python EDA ✅

**Tools:** Python, NumPy, Pandas, Matplotlib, Seaborn, Jupyter Notebook

### EDA Process Completed

1. Business Understanding
2. Dataset Understanding
3. Data Loading
4. Data Inspection
5. Data Cleaning
6. Missing Value Analysis
7. Duplicate Analysis
8. Data Validation
9. Outlier Analysis
10. Univariate Analysis
11. Bivariate Analysis
12. Failure Analysis
13. RUL & Maintenance Analysis
14. Correlation Analysis
15. Machine-Level Risk Analysis
16. Key Insights & Business Recommendations

### Part 2 — MySQL / SQL 🔜

Planned work:

- Database and table creation
- Data import
- Filtering and aggregation
- GROUP BY and CASE
- JOINs
- Subqueries and CTEs
- Window functions
- Machine failure analysis
- RUL analysis
- Maintenance analysis
- High-risk machine identification

### Part 3 — Power BI 🔜

Planned dashboard areas:

- Machine Overview
- Failure Analysis
- Machine Risk
- RUL Monitoring
- Sensor Analysis
- Maintenance Insights
- Repair Cost Analysis

### Part 4 — Machine Learning 🔜

Future extensions may include:

- Failure prediction
- Risk classification
- RUL prediction
- Model evaluation

## 📁 Dataset

The dataset contains industrial machine readings including:

- Timestamp
- Machine ID
- Machine Type
- Vibration
- Motor Temperature
- Current
- Pressure
- RPM
- Operating Mode
- Hours Since Maintenance
- Ambient Temperature
- RUL
- Failure Within 24 Hours
- Failure Type
- Estimated Repair Cost

## 🔍 Key EDA Findings

- Motor temperature has a positive association with failure within 24 hours.
- Vibration has a positive association with failure within 24 hours.
- Current, vibration, pressure, and RPM show strong positive correlations with each other.
- Hours since maintenance has a negative relationship with RUL.
- RUL has a negative association with failure within 24 hours.
- Machine-level analysis helps identify machines requiring higher maintenance attention.

> **Note:** Correlation indicates association and does not necessarily imply causation.

## 💼 Business Value

The project demonstrates how machine data can be transformed into actionable maintenance insights.

It can help maintenance teams:

- Prioritize high-risk machines
- Monitor machine health indicators
- Identify potential failure patterns
- Track remaining useful life
- Support preventive maintenance decisions
- Understand maintenance and repair cost patterns

## 🛠️ Technologies

| Area | Technology |
|---|---|
| Programming | Python |
| Data Analysis | Pandas, NumPy |
| Visualization | Matplotlib, Seaborn |
| Notebook | Jupyter Notebook |
| Database | MySQL |
| SQL Analysis | SQL |
| Dashboard | Power BI |
| Version Control | Git & GitHub |
| Future | Machine Learning |

## 📈 Project Status

| Component | Status |
|---|---|
| Dataset | ✅ Completed |
| Python Data Cleaning | ✅ Completed |
| Python EDA | ✅ Completed |
| Machine Risk Analysis | ✅ Completed |
| Key Insights | ✅ Completed |
| MySQL / SQL | 🔜 Planned |
| Power BI Dashboard | 🔜 Planned |
| Machine Learning | 🔜 Future |

## 👨‍💻 Author

**Rupesh Patil**

A practical portfolio project demonstrating skills in **Python Data Analytics, SQL, Power BI, and Industrial Machine Data Analysis**.
