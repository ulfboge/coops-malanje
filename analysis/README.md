# Cooperatives of Malanje Analysis

This directory contains tools for analyzing and visualizing data about cooperatives in Malanje Province.

## Setup Options

### Option 1: Google Colab (Recommended)
1. Open the notebook in Google Colab: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/KAYA-Global/coops-malanje/blob/main/analysis/cooperatives_analysis.ipynb)
2. The notebook will automatically install required packages
3. Mount your Google Drive when prompted
4. Upload your data file or use the sample data

### Option 2: Local Installation
1. Clone the repository:
```bash
git clone https://github.com/KAYA-Global/coops-malanje.git
cd coops-malanje/analysis
```

2. Install the required Python packages:
```bash
pip install -r requirements.txt
```

3. Start Jupyter Notebook:
```bash
jupyter notebook
```

4. Open `cooperatives_analysis.ipynb`

## Features

### Interactive Visualizations
- Cooperative distribution by municipality
- Legal status distribution
- Gender participation analysis
- Resource allocation patterns

### PDF Report Generation
The notebook includes functionality to generate a printer-friendly PDF report containing:
- Summary statistics
- Detailed tables
- Key findings
- Recommendations

## Output Files

The analysis generates the following outputs:
- `output/figures/`: Directory containing generated visualizations
- `output/reports/cooperatives_report.pdf`: Generated PDF report

In Google Colab, files are saved to your Google Drive and can be downloaded as a zip file.

## Data Sources

The analysis uses data from:
- Cooperative database
- Geographic information
- Member statistics

## Customization

You can modify the following aspects:
1. Data loading: Update the `load_cooperatives_data()` function to connect to your actual data source
2. Visualizations: Adjust parameters in the visualization cells
3. Report content: Modify the `create_pdf_report()` function to include additional sections

## Requirements

- Python 3.8 or higher
- Jupyter Notebook or Google Colab
- Required packages listed in `requirements.txt`

## Contributing

To contribute to this project:
1. Fork the repository
2. Create a new branch for your changes
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 