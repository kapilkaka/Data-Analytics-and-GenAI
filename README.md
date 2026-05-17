# Data Analytics and GenAI

A comprehensive repository for data analytics projects and generative AI applications, with a focus on healthcare management and predictive analytics.

## Projects

### Healthcare Management Capstone Project

This project leverages data analytics and machine learning to analyze patient healthcare data, with a specific focus on diabetic patient management and outcomes prediction.

#### Dataset: `diabetic_data.csv`

**Overview:**
- Contains comprehensive patient encounter records with clinical, demographic, and medical specialty information
- Includes patient demographics (age, gender, race)
- Hospital admission and discharge data
- Medical procedures and laboratory measurements
- Medication information and clinical outcomes

**Key Features:**
- `encounter_id`: Unique identifier for each hospital encounter
- `patient_nbr`: Patient identification number
- `race`: Patient ethnicity (Caucasian, African American, Other, Unknown)
- `gender`: Patient gender (Male, Female)
- `age`: Age group in 10-year intervals ([0-10), [10-20), etc.)
- `weight`: Patient weight
- `admission_type_id`: Type of hospital admission
- `discharge_disposition_id`: Discharge destination
- `admission_source_id`: Source of admission
- `time_in_hospital`: Length of hospital stay (in days)
- `medical_specialty`: Department/specialty that treated the patient
- `num_lab_procedures`: Number of laboratory procedures performed
- `num_procedures`: Number of non-laboratory procedures performed
- `num_medications`: Number of medications administered
- Laboratory measurements and medication indicators
- `readmitted`: Target variable indicating patient readmission status

#### Project Objectives

1. **Data Exploration & Cleaning**: Understand dataset structure, handle missing values, and identify data quality issues
2. **Exploratory Data Analysis (EDA)**: Visualize patterns, trends, and relationships in patient data
3. **Predictive Modeling**: Build machine learning models to predict patient readmission risk
4. **Feature Engineering**: Create meaningful features from raw clinical data
5. **Statistical Analysis**: Perform hypothesis testing and correlation analysis
6. **Healthcare Insights**: Generate actionable insights for hospital management and patient care improvement

#### Technologies & Tools

- **Languages**: Python, SQL, Jupyter Notebooks
- **Libraries**: 
  - Data Processing: Pandas, NumPy
  - Visualization: Matplotlib, Seaborn, Plotly
  - Machine Learning: Scikit-learn, XGBoost, LightGBM
  - Statistical Analysis: SciPy, Statsmodels
  - GenAI: LangChain, OpenAI (for advanced analytics)
- **Tools**: Git, Jupyter Lab, VSCode

#### Repository Structure

```
Data-Analytics-and-GenAI/
├── Healthcare-Management-Capstone-Project/
│   ├── README.md                          # Project documentation
│   ├── diabetic_data.csv                  # Main dataset
│   ├── notebooks/
│   │   ├── 01_eda.ipynb                   # Exploratory Data Analysis
│   │   ├── 02_data_cleaning.ipynb         # Data preprocessing and cleaning
│   │   ├── 03_feature_engineering.ipynb   # Feature creation and selection
│   │   └── 04_modeling.ipynb              # Machine learning models
│   ├── data/
│   │   ├── raw/                           # Original unprocessed data
│   │   └── processed/                     # Cleaned and processed data
│   ├── src/
│   │   ├── data_loader.py                 # Data loading utilities
│   │   ├── preprocessing.py               # Data cleaning functions
│   │   ├── feature_engineering.py         # Feature creation
│   │   └── models.py                      # Model definitions
│   ├── results/
│   │   ├── visualizations/                # EDA plots and charts
│   │   ├── model_results/                 # Model performance metrics
│   │   └── insights/                      # Generated reports and insights
│   └── requirements.txt                   # Project dependencies
```

#### Getting Started

**Prerequisites:**
- Python 3.8+
- pip or conda package manager
- Git

**Installation:**

```bash
# Clone the repository
git clone https://github.com/kapilkaka/Data-Analytics-and-GenAI.git

# Navigate to project directory
cd Data-Analytics-and-GenAI

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

**Running the Analysis:**

```bash
# Start Jupyter Lab
jupyter lab

# Navigate to Healthcare-Management-Capstone-Project/notebooks/
# Open and run notebooks in sequence:
# 1. 01_eda.ipynb
# 2. 02_data_cleaning.ipynb
# 3. 03_feature_engineering.ipynb
# 4. 04_modeling.ipynb
```

#### Key Findings & Insights

*(To be populated with analysis results)*

- Patient readmission patterns by demographics
- Impact of medical specialty on patient outcomes
- Correlation between procedures, medications, and readmission
- Model performance and predictive accuracy
- Recommendations for hospital management

#### Dataset Statistics

- **Total Records**: 100,000+ patient encounters
- **Time Period**: [To be confirmed from data]
- **Unique Patients**: [To be calculated]
- **Target Variable**: Readmission Status (Binary)
- **Features**: 50+ clinical and demographic variables

#### Predictive Modeling

**Models Implemented:**
- Logistic Regression (Baseline)
- Random Forest Classifier
- Gradient Boosting (XGBoost/LightGBM)
- Neural Networks (TensorFlow/Keras)

**Performance Metrics:**
- Accuracy, Precision, Recall, F1-Score
- ROC-AUC Score
- Confusion Matrix Analysis
- Feature Importance Rankings

#### Generative AI Applications

This repository also explores GenAI use cases including:
- Automated report generation from analysis results
- Natural language summaries of key findings
- Clinical decision support through LLMs
- Anomaly detection and explanation

#### Contributing

We welcome contributions! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit changes (`git commit -am 'Add new analysis'`)
4. Push to branch (`git push origin feature/improvement`)
5. Open a Pull Request

#### License

This project is licensed under the MIT License - see the LICENSE file for details.

#### Contact & Support

For questions or support regarding this project, please reach out to:
- **GitHub**: [@kapilkaka](https://github.com/kapilkaka)

#### Acknowledgments

- Dataset sourced from healthcare analytics research
- Thanks to the open-source community for the amazing tools and libraries

---

**Last Updated**: 2026-05-17

**Status**: 🚀 Active Development
