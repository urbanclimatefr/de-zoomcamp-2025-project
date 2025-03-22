# Data Engineering Zoomcamp 2025 Project

## Overview

This [repository](https://github.com/urbanclimatefr/de-zoomcamp-2025-project) contains the source code and documentation for the [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp)'s project for 2025.

The content in the README is also available on [https://github.com/urbanclimatefr/de-zoomcamp-2025-project](https://github.com/urbanclimatefr/de-zoomcamp-2025-project)

<br>

## Goal

The goal of this project is to create a solution which consists an end-to-end batch data ingestion, processing, transformation, persistence and visualization pipeline. With data ingested from Hong Kong Observatory, user will be able to view the hourly temperature data in the report provided by Looker Studio.


<br>

## Data Source

**Hong Kong Observatory**'s [API Web Service](https://data.gov.hk/en-data/dataset/hk-hko-rss-current-weather-report/resource/923a02ae-4a14-4a28-8a2b-1215d3dff08f) provides various APIs where we can use to collect real time weather data.

A list of office ids were previously obtained and hard-coded in the data collection Python script (see [weather_data_load.py](./src/weather_data_loader.py))

For each office, we retrieve a list of weather station ids and for each station the Python script makes an API call to obtain current weather data.

<br>

## Data Collection

Instead of using existing historical data, this project is going to collect data on an hourly basis and build a batch processing pipeline to process them on a daily basis. At the end, data is presented in dashboards built by Google Cloud's Looker Studio.



<br>

## Data Visualization

The final result is a **Weather Reports** Looker report.

The first page of the report shows the summary statistics. User can select either or both **Station ID** and **Date**.

The first dashboard in this page shows the number of records collected for the selected station and date.

The second dashboard shows the lowest, average and highest temperature for the selected station and date.

<br>
<img width="1177" alt="image" src="https://github.com/user-attachments/assets/1a99cb64-04d7-4b81-9c07-e28afbddbef9" />
<br>

Second page of the report shows the time series temperate data for the selected station and the date range.

<br>
<img width="1181" alt="image" src="https://github.com/user-attachments/assets/e2ab7d8c-ac92-4dcf-9bff-f65a9315e794" />

<br>


## Flowchart

<br>

![data flow](./doc/flowchart.svg)

<br>

## Data Pipelines

<br>

See [data pipelines](./doc/pipeline.md)

<br>



## Prerequisites

Before we can execute the pipeline, we would first provision the infrastructure.


**Docker Container Creation**

This includes building local Kestra image as well as running Kestra and Postgres containers.


[Kestra](./doc/kestra.md)

<br>

## Lessons Learned

- Deciding on data visualization earlier helps narrowing down the scope and the kind of processing needed for the pipeline. Working backward from the target end state is a useful way to keep things in check.
- Documentation would probably takes as much time as development.



