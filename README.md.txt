# CareLoop Clinics – No-Show Prediction Project

## Project Overview
This project analyzes clinic appointment data to understand patient no-shows and predict the likelihood of patients missing their appointments.

## Project Objectives
- Clean and prepare appointment datasets.
- Analyze appointment and clinic performance using MySQL.
- Build machine learning models to predict patient no-shows.
- Use Gemini AI to analyze patient follow-up notes.
- Generate insights and recommendations to reduce no-shows.

## Technologies Used
- Python
- Pandas and NumPy
- Scikit-learn
- MySQL
- Google Colab
- Gemini API
- Pydantic

## Project Tasks

### Part 1 – Data Cleaning
- Clean appointment data.
- Handle missing and invalid values.
- Remove duplicate records.
- Prepare cleaned datasets and rejected records.

### Part 2 – SQL Analysis
- Calculate no-show percentages by clinic.
- Analyze monthly no-show trends.
- Analyze booking lead times.
- Rank clinics within each city.

### Part 3 – Machine Learning
- Train Logistic Regression, Decision Tree and Random Forest models.
- Compare model performance.
- Evaluate accuracy, precision, recall and ROC-AUC.
- Generate patient no-show risk predictions.

### Part 4 – Generative AI
- Analyze follow-up notes using Gemini.
- Validate structured outputs using Pydantic.
- Generate reason categories and recommended actions.
- Combine AI results with cleaned appointment data.

## Project Outputs
- appointments_clean.csv
- clinics_enriched.csv
- rejected_rows.json
- load_data.sql
- 02_queries.sql
- notes_analysed.csv
- final_combined_results.csv

## How to Run
1. Open the completed Google Colab notebook.
2. Upload or provide the required original datasets.
3. Configure the Gemini API key using Colab Secrets.
4. Run the notebook cells in order.
5. Execute SQL queries in MySQL Workbench.

## Note
The Gemini API key is not included in this repository. Configure your own key securely before running the Generative AI section.