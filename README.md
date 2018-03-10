Information about the Public Sample Beiwe Dataset
================
Last Update: 09 March, 2018

-   [Introduction](#introduction)
    -   [About the data release](#about-the-data-release)
    -   [Getting the data](#getting-the-data)
    -   [Citations](#citations)
    -   [License](#license)
    -   [Funding](#funding)
-   [About the data](#about-the-data)
    -   [Anonymization](#anonymization)
    -   [Study settings](#study-settings)
-   [Sample plots](#sample-plots)

Introduction
============

About the data release
----------------------

The [Beiwe Research Platform](https://www.hsph.harvard.edu/onnela-lab/beiwe-research-platform/) collects high-density data from a variety of smartphone sensors including GPS, WiFi, Bluetooth, and accelerometer. To learn more about Beiwe, check out the [Onnela Lab](https://www.hsph.harvard.edu/onnela-lab/beiwe-research-platform/) page, the [paper introducing the platform](https://mental.jmir.org/2016/2/e16/), or the [Beiwe wiki](http://wiki.beiwe.org/).

In order to help current and potential collaborators understand the structure and format of Beiwe data, we are making our personal data available to the public. The hope is that access to real data will allow researchers to (1) facilitate coding and debugging for ETL, data ingestion, and other parts of their pipeline before data is collected, (2) create functions to help inspect raw data, and (3) test new methods or functions on real data.

Getting the data
----------------

Due to size limitations, this repository does not contain the data. To get the data, please [download it from Zenodo](https://zenodo.org/record/1188879). This repository contains information about the data, and we will add example notebooks of manipulating the data here. The original, raw release will always remain the same at the [Zenodo](https://zenodo.org/record/1188879) page.

Citations
---------

The Digital Object Identifier of this dataset is [`10.5281/zenodo.1188879`](https://zenodo.org/record/1188879). When using these data, please cite the dataset as

> Kiang, Mathew, Lorme, Jeanette, & Onnela, Jukka-Pekka. (2018). Public Sample Beiwe Dataset (Version 0.1) \[Data set\]. Zenodo. <http://doi.org/10.5281/zenodo.1188879>

When referring to the Beiwe Research Platform or how these data were collected, please cite the [JMIR-Mental Health paper](https://mental.jmir.org/2016/2/e16/) as:

> Torous J, Kiang MV, Lorme J, Onnela JP, New Tools for New Research in Psychiatry: A Scalable and Customizable Platform to Empower Data Driven Smartphone Research, JMIR Ment Health 2016;3(2):e16. URL: <https://mental.jmir.org/2016/2/e16>, DOI: 10.2196/mental.5165

License
-------

This work (both code and data) is licensed under a [Creative Commons Attribution Share-Alike 4.0 License (CC-BY-SA-4.0)](https://creativecommons.org/licenses/by-sa/4.0/legalcode).

Funding
-------

Development of the Beiwe Research Platform and data analysis pipeline was enabled by National Institute of Health Director’s New Innovator Award to Dr. [JP Onnela](https://www.hsph.harvard.edu/onnela-lab/) (DP2MH103909).

About the data
==============

The original data come from 3 people using 5 different study settings of various durations and starting/ending dates.

Anonymization
-------------

In [the public release dataset](https://zenodo.org/record/1188879), all audio files have been removed (but users that collected audio files will still have an `audio_recordings` folder). Further, some GPS data have been anonymized by creating a bounding box around sensitive areas. Any observation within the bounding polygon is replaced anonymized by using last observation carried forward and adding a small amount of Gaussian noise.

Study settings
--------------

Researchers may specify different data collection parameters for every study. The Beiwe app collects accelerometer, Bluetooth, call, GPS, gyroscope, magnetometer, power state, proximity, text, and WiFi data whenever possible or specified. Not all sensors are available on all phones. Call, power state, and text data were collected when events occurred, which, in these test data, was relatively infrequently. See the [official Beiwe documentation](http://wiki.beiwe.org/) for more details.

This table shows the study settings for each of the public-use studies. All durations are in seconds. The sensors are accelerometer ("Accel."), GPS, gyroscope ("Gyro."), magnetometer ("Mag."), DeviceMotion ("DM"; iOS devices only), Bluetooth ("BT"), and WiFi. Bluetooth is parameterized as amount of time spent on (logging nearby Bluetooth devices) out of a total amount of time. WiFi is parameterized as the frequency at which WiFi networks should be logged. All other sensors are parameterized as amount of time on and off.

<table style="width:100%;">
<colgroup>
<col width="15%" />
<col width="5%" />
<col width="11%" />
<col width="11%" />
<col width="8%" />
<col width="7%" />
<col width="7%" />
<col width="7%" />
<col width="6%" />
<col width="7%" />
<col width="8%" />
</colgroup>
<thead>
<tr class="header">
<th>Study ID</th>
<th>Users (n)</th>
<th>First file timestamp</th>
<th>Last file timestamp</th>
<th>Accel. (on/off)</th>
<th>GPS (on/off)</th>
<th>Gyro. (on/off)</th>
<th>Mag. (on/off)</th>
<th>DM (on/off)</th>
<th>BT (on/total)</th>
<th>WiFi (log freq)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>onnela_lab_gps_testing</code></td>
<td>1</td>
<td><code>2016-01-26 19_00_00</code></td>
<td><code>2016-02-04 14_00_00</code></td>
<td>10/10</td>
<td>7140/60</td>
<td>60/600</td>
<td>60/600</td>
<td>60/600</td>
<td>60/300</td>
<td>300</td>
</tr>
<tr class="even">
<td><code>onnela_lab_ios_test1</code></td>
<td>1</td>
<td><code>2016-06-03 19_00_00</code></td>
<td><code>2016-06-04 16_00_00</code></td>
<td>10/900</td>
<td>60/1200</td>
<td>60/1200</td>
<td>60/600</td>
<td>60/600</td>
<td>60/300</td>
<td>300</td>
</tr>
<tr class="odd">
<td><code>onnela_lab_ios_test2</code></td>
<td>2</td>
<td><code>2016-06-07 18_00_00</code></td>
<td><code>2016-06-08 00_00_00</code></td>
<td>10/10</td>
<td>60/600</td>
<td>60/600</td>
<td>60/600</td>
<td>60/600</td>
<td>60/300</td>
<td>300</td>
</tr>
<tr class="even">
<td><code>onnela_lab_test1</code></td>
<td>1</td>
<td><code>2016-10-17 19_00_00</code></td>
<td><code>2017-02-13 13_00_00</code></td>
<td>10/1250</td>
<td>60/1200</td>
<td>60/1200</td>
<td>60/1200</td>
<td>60/1200</td>
<td>60/300</td>
<td>300</td>
</tr>
<tr class="odd">
<td><code>passive_data_high_sampling</code></td>
<td>1</td>
<td><code>2016-05-30 08_00_00</code></td>
<td><code>2016-08-25 07_00_00</code></td>
<td>600/60</td>
<td>7140/60</td>
<td>60/600</td>
<td>60/600</td>
<td>60/600</td>
<td>60/300</td>
<td>10</td>
</tr>
</tbody>
</table>

Sample plots
============

``` r
## Code can be found in "./code/plotting_hourly_heatmap_study1.R"
knitr::include_graphics("./plots/hourly_heatmap.jpg")
```

<img src="./plots/hourly_heatmap.jpg" width="2400" />

Similarly, we can aggregate over time and show heatmap of all GPS points on a map of Chicago.

``` r
## Code can be found in "./code/plotting_chicago_data.R"
knitr::include_graphics("./plots/chicago_map.jpg")
```

<img src="./plots/chicago_map.jpg" width="1500" />
