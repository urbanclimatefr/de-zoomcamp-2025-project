# Data Engineering Zoomcamp 2025 Project

## Overview

This [repository](https://github.com/urbanclimatefr/de-zoomcamp-2025-project) hosts the source code and documentation for the 2025 project of the [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp)'s project for 2025.

The README content is also accessible at  [https://github.com/urbanclimatefr/de-zoomcamp-2025-project](https://github.com/urbanclimatefr/de-zoomcamp-2025-project)

<br>

## Goal

The objective of this project is to develop an end-to-end batch data pipeline that includes ingestion, processing, transformation, persistence, and visualization. Utilizing data from the Hong Kong Observatory, users can access hourly temperature data through a Looker Studio report.

<br>

## Data Source

**Hong Kong Observatory**'s [API Web Service](https://data.gov.hk/en-data/dataset/hk-hko-rss-current-weather-report/resource/923a02ae-4a14-4a28-8a2b-1215d3dff08f), which offers various APIs for collecting real-time weather data.



<br>

## Data Collection

Rather than using pre-existing historical data, this project will gather data hourly and establish a batch processing pipeline to handle the data daily. The processed data will then be displayed in dashboards created using Google Cloud's Looker Studio.



<br>

## Data Visualization

The culmination of this project is a **Weather Report** Looker report.

The initial page of the report displays summary statistics, allowing users to filter by **Station** and/or **Date**.

The first dashboard on this page indicates the number of records collected for the chosen station and date.

The second dashboard presents the lowest, average, and highest temperatures for the selected station and date.

<br>
<img width="1177" alt="image" src="https://github.com/user-attachments/assets/1a99cb64-04d7-4b81-9c07-e28afbddbef9" />
<br>

The second page of the report illustrates the time series temperature data for the selected station and date range.

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

Before executing the pipeline, the necessary infrastructure must be provisioned.


**Docker Container Creation**

This involves building a local Kestra image and running Kestra and Postgres containers.


[Kestra](./doc/kestra.md)

<br>

## Lessons Learned

- Early decisions on data visualization help in defining the scope and the type of processing required for the pipeline. Starting from the desired end state and working backward is an effective strategy to maintain focus.

- Documentation can be as time-consuming as the development process itself.


