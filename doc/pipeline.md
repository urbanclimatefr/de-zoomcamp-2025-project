# Data Pipeline

## Overview

This document describes the pipelines and triggers implemented for this project.

The end-to-end data batch processing pipeline consists of 4 pieces.

The first 2 pipeline pieces are created by using Kestra flows to set up the infrastructure and other 2 pieces are created by using Kestra flow to extract, transform and load the data into GCS and Bigquery, as well as having data quality check using dbt.


## Infrastructure pipelines

There are two Kestra flows created for this project.

**Create key value store in Kestra**

This workflow is designed to set key-value pairs in a key-value store, which can be used to store configuration data or secrets for a Google Cloud Platform (GCP) project.

<img width="536" alt="image" src="https://github.com/user-attachments/assets/9f2ca265-b2ba-4ab6-a814-fdd26d571b03" />


The key value store is in namespaces zoomcamp.

<img width="1217" alt="image" src="https://github.com/user-attachments/assets/21809b06-c4d9-4592-88f1-1b5a25fd5bc4" />


 **Set up in GCP**

 This workflow is designed to set up resources on Google Cloud Platform (GCP) using Kestra, an orchestration and scheduling platform
 
 <img width="400" alt="image" src="https://github.com/user-attachments/assets/080b7615-c89e-4e88-9784-8ab227b6cc82" />

<br>

<br>

## ETL with Kestra and data quality check with dbt

Kestra ETL workflow consists of total 9 blocks

**1. Scheduling**

<img width="272" alt="image" src="https://github.com/user-attachments/assets/9ae8f5ee-713b-4f69-9c7a-311e7e178c7c" />

This schedules the workflow to run ETL job every hour.


<br>

**2. Set label** 

This set the label for this workflow.

<img width="248" alt="image" src="https://github.com/user-attachments/assets/a250f04e-aaa0-4cc3-9af1-70909ffdb53c" />


<br>

**3. Fetch data**

<img width="470" alt="image" src="https://github.com/user-attachments/assets/27e46962-8072-4fc0-b5bf-3d216df4889f" />

This task fetches data by using HTTP Get method.

<br>


**4. Parse json/ Transform** 

This uses Python to run the transform script to change json output to csv output with desired columns: place, value, unit, recordTime.


<img width="512" alt="image" src="https://github.com/user-attachments/assets/2b47e045-06e2-4918-8cdc-ad9459d132bc" />


<br>



**5. Upload data to Google Cloud Storage (GCS)** 

<img width="365" alt="image" src="https://github.com/user-attachments/assets/0a1cca6a-233b-49dd-b167-8e119b261bbd" />

This task uploads the transformed csv data output to the GCS bucket.

<img width="1271" alt="image" src="https://github.com/user-attachments/assets/56a5c317-096a-43e8-9b88-b5aa25df487e" />



<br>

**6. Create weather table** 

<img width="510" alt="image" src="https://github.com/user-attachments/assets/65b020b2-51ba-457c-9ced-83b7dadd9913" />

This tasks creates weather table in Bigquery with the desired data schema.

<img width="1266" alt="image" src="https://github.com/user-attachments/assets/08bd2ce2-ee63-4f45-9ec8-dae1a4f8c8a5" />


<br>

**7. Load weather data** 

<img width="471" alt="image" src="https://github.com/user-attachments/assets/8001204d-6b46-4d56-a627-bff90d54e9f5" />

This task loads weather data from GCS to the created temporary weather table in BigQuery.

**8. Merge weather data** 

<img width="430" alt="image" src="https://github.com/user-attachments/assets/497fe2da-0dd2-4e0a-9eda-efe22c978f2d" />

This task merges temporary weather table to the final destination weather_table.

<img width="1258" alt="image" src="https://github.com/user-attachments/assets/ad8be7ef-d021-4629-9e12-25ebce4b2236" />

<br>

**9. Purge file** 

<img width="352" alt="image" src="https://github.com/user-attachments/assets/dc87a270-4eaf-4c2b-bb7a-0f19332e8d9b" />

This task purges temporary files after processing.

## dbt data quality check



