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



<br>

**Create Daily**

This pipline is scheduled to run every day 10 mins before midnight. When it runs, it execute the [transform.py](../src/transform.py) Python script. The script is fetching all the json files from the Cloud Storage bucket based on the provided `execution date`.

When pipeline is a scheduled job, the `execution date` is the current date. When pipeline is kicked off manually, user can enter a particular date as the `execution date`. This would be the backfill scenario.

![github create daily](./github_create_daily.png)

The downloaded json files will be aggregated together. A transformation process is applied to extract interesting fields and produces a new output object in csv format.

For each execution date, one single csv file will be created and uploaded back to Cloud Storage bucket under the `daily` prefix and paritioned by year, month and day.

![storage daily](./storage_daily.png)


<br>

## Mage Pipelines

Mage pipeline consists of total 5 blocks

**1. ingest from cloud storage** Data Loader

See [ingest from cloud storage](../mage/data-engineering-zoomcamp-2024-project/data_loaders/ingest_from_cloud_storage.py)


This data loader loads daily csv file from Cloud Storage bucket for the execution time. Execution time is provided by Mage and can be overrided during the [backfill](./backfill.md) process.


![mage block 1](./mage_block_1.png)


<br>

**2. cleaning and add transform** Transformer

See [cleaning and add transform](../mage/data-engineering-zoomcamp-2024-project/transformers/cleaning_and_add__transform.py)


Once the data is loaded into dataframe from the previous step, this transformer filters out rows which `temperature` field is null and adds 3 columns `date`, `hour` and `minute` using the value from `timestamp` column.

The transformed dataframe is then subject to the tests specified under `@test` block where we verify that the 3 new columns are non-null.


![mage block 2](./mage_block_2.png)


<br>

**3. remove duplicates** Transformer

See [remove duplicates](../mage/data-engineering-zoomcamp-2024-project/transformers/remove_duplicates.py)

The transformer is checking duplicate rows based on the combination of `stationId`, `date`, `hour` and `minute` columns and keeps the last record.

Under the `@test` block we verify that the output dataframe is non-null.


![mage block 3](./mage_block_3.png)

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



