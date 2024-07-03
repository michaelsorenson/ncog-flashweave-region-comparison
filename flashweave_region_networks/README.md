# NCOG FlashWeave Region Comparison

This repo is built off of the [NCOG co-occurrence repo](https://github.com/michaelsorenson/NCOG_co_occurrence) and is dedicated to building separate FlashWeave co-occurrence networks for each of the regions in NCOG: Southern California Bight (SCB), Upwelling (Up), California Current (CC), and Offshore (Off), with an additional region, Northern Unlabeled (NU), for unlabeled points north of the 34th parallel.

## Data

The input data is the same as the input data for the [NCOG co-occurrence repo](https://github.com/michaelsorenson/NCOG_co_occurrence), but for simplicity, you only need the cleaned version of the 16S and 18S data as well as the ID mapping file (which maps Feature.IDs to simpler strings that work as IDs with FlashWeave), and the original input metadata file. The four files you need to copy over into the data folder, maintaining the same folder structure, are as follows (you can use the V9 cleaned files if you want to run the analysis with V9):

- data/input/NCOG_sample_log_DNA_stvx_meta_2014-2020_mod.tsv
- data/cleaned/NCOG_21_16sV4_redo2_filtered_asv_count_tax.tsv
- data/cleaned/NCOG_18sV4_filtered_asv_count_tax.tsv
- data/cleaned/NCOG_V4_id_map.tsv

## Prerequisites

- To run the notebooks, you must install the Python requirements using `pip install -r requirements.txt`.
- To run FlashWeave, you either need Julia installed locally or on a supercomputer with the FlashWeave package installed.
- To build circos plots, you can follow the same pipeline as specified in the [NCOG co-occurrence repo](https://github.com/michaelsorenson/NCOG_co_occurrence).

## 01_NCOG_FlashWeave_Regional_Network_Analysis.ipynb

- This notebook runs FlashWeave to generate a co-occurrence network for each region, i.e., the 16S and 18S OTU abundance tables are filtered to only those found in the region of interest, then a co-occurrence network is calculated from those abundance tables.
- Next, the notebook runs through some basic analyses, examining the network and community structure of each region.
