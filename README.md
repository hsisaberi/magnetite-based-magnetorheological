# Application of Artificial Intelligence to Magnetite-Based Magnetorheological Fluids

This repository contains the data, code, and supplementary materials for the research article **"Application of Artificial Intelligence to Magnetite-Based Magnetorheological Fluids"**, authored by Hossein Saberi, Ehsan Esmaeilnezhad, and Hyoung Jin Choi.

The research presents a machine learning-based approach to model and predict the magnetorheological (MR) behavior of magnetite-based MR fluids, significantly reducing the need for costly and time-consuming laboratory experiments.

## Table of Contents

- [Abstract](#abstract)  
- [Features](#features)  
- [Usage](#usage)  
- [Data](#data)  
- [Models](#models)  
- [Results](#results)  
- [Citation](#citation)  
- [Acknowledgments](#acknowledgments)

---

## Abstract

Magnetorheological (MR) fluids are smart fluids that undergo reversible phase transitions under a magnetic field. This study leverages **Artificial Neural Networks (ANNs)**, including **Multilayer Perceptron (MLP)** and **Radial Basis Function (RBF)**, as well as **Adaptive Neuro-Fuzzy Inference Systems (ANFIS)** to predict shear stress behavior in MR fluids. The proposed models achieved high accuracy with minimal residual error, offering a cost-effective and efficient alternative to laboratory tests.

---

## Features

- **Models:** Implementation of MLP, RBF, and ANFIS for predictive modeling.
- **Data-Driven Insights:** Predictions based on key parameters:  
  - Magnetite nanoparticle concentration  
  - Silicone oil viscosity  
  - Magnetic field strength  
  - Shear rate  
- **Optimized Accuracy:** Models validated against laboratory data, demonstrating exceptional R² and RMSE values.  
- **Practical Application:** Avoids extensive experimental work by providing pre-trained models and equations.

---

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/username/repository.git
   cd repository
   ```

---

## Data

The dataset includes measurements of shear stress for nine MR fluid samples under varying conditions:
- **Magnetite nanoparticle concentrations:** 2%, 4%, 6%, 8%  
- **Silicone oil viscosities:** 100, 500, 1000 cP  
- **Magnetic field strengths:** 34, 68, 102, 137 kA/m  

**Note:** Ensure compliance with the terms of use specified by the data providers.

---

## Models

### Multilayer Perceptron (MLP)
- **R²:** 0.99625  
- **RMSE:** 0.00867  

### Radial Basis Function (RBF)
- **R²:** 0.99489  
- **RMSE:** 0.01078  

### Adaptive Neuro-Fuzzy Inference System (ANFIS)
- **R²:** 0.99379  
- **RMSE:** 0.01319  

Each model is optimized using statistical tools and validated with unseen data samples.

---

## Results

Key findings:
- The MLP model outperforms other methods in terms of accuracy and efficiency.
- Predictive equations derived from MLP weights and biases enable rapid shear stress estimation.  
- The proposed methods significantly reduce experimental costs.

![Performance Comparison](images/performance.png)

---

## Citation

If you use this repository, please cite the original article:  

**Saberi, H., Esmaeilnezhad, E., & Choi, H.J.** (2021). Application of artificial intelligence to magnetite-based magnetorheological fluids. *Journal of Industrial and Engineering Chemistry*. [DOI: 10.1016/j.jiec.2021.04.047](https://doi.org/10.1016/j.jiec.2021.04.047)

---

## Acknowledgments

This work was supported by:
- Korean National Research Foundation (Grant No. 2021R1A4A2001403).  

We thank all contributors for their invaluable support.
