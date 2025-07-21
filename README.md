# CKC EEG–IMU MATLAB Scripts

This repository contains MATLAB scripts used for preprocessing inertial measurement unit (IMU) acceleration data and computing corticokinematic coherence (CKC) between EEG and IMU signals. These scripts were developed for the study described in:

**Zhao, S., Tu, L., Bao, Z., & Shou, X. (2025).**  
*A dataset of synchronized EEG and IMU recordings for proprioceptive function assessment.*  
[Figshare Dataset](https://doi.org/10.6084/m9.figshare.29606906.v2)

## Contents

- `acc_processing.m`: Processes raw IMU data (.txt) by applying low-pass filtering, spline interpolation to 500 Hz, and computing the Euclidean norm.
- `coherence_analysis.m`: Computes coherence between filtered acceleration signals and EEG channels using Welch’s method (`mscohere`).

## Requirements

- MATLAB R2023a or later
- EEGLAB toolbox (for ICA preprocessing, if applicable)
- Signal Processing Toolbox (for `mscohere`)
- Custom function: `lopass_butterworth` (not included in this repo)

## Usage

Update the file paths in each script to match your data directory before running.  
Run `acc_processing.m` to generate `acc_norm.txt`, then use it with `coherence_analysis.m` to compute CKC values.

## License

This project is licensed under the MIT License. See `LICENSE` for details.

## Citation

If you use these scripts, please cite the dataset:

> Zhao, S., Tu, L., Bao, Z., & Shou, X. (2025). A dataset of synchronized EEG and IMU recordings for proprioceptive function assessment. Figshare. https://doi.org/10.6084/m9.figshare.29606906.v2

