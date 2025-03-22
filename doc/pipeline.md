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


**4. store to big query** Data Exporter

See [store to big query](../mage/data-engineering-zoomcamp-2024-project/data_exporters/store_to_big_query.py)


This data exporter uploads the dataframe to BigQuery dataset called `project_dataset` and table `weather_data`.


![mage block 4](./mage_block_4.png)

<br>

![bigquery table](./bigquery_table.png)

<br>


**5. read back from bigquery and assert no dupes** Data Loader

See [quality check](../mage/data-engineering-zoomcamp-2024-project/data_loaders/read_back_from_bigquery_and_assert_no_dupes.py)


This data loader performs quality check by reading data from BigQuery table and make sure there is no duplicate rows in the table based on the same unique criteria described in **remove duplicates** transformer.


![mage block 5](./mage_block_5.png)


<br>

## Mage Pipeline Trigger

A daily scheduled trigger is created to execute the pipeline. Trigger can also be triggered manually.


![mage trigger](./mage_trigger.png)



