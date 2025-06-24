# Google Data Analytics Capstone: Cyclistic project
  
## Introduction
**Scenario:** I am a junior data analyst at a fictional bike-share 
company in Chicago, Cyclistic. 

In this project, I will carry out various real-world tasks. To address important business questions, I will follow the stages of the data analysis process: ask, prepare, process, analyze, share, and act. 

### Table of content 
1. [Background of Cyclistic Project](#background-of-cyclistic-project)
2. [Ask Questions and Define the Goal](#ask-questions-and-define-the-goal)
3. [Prepare the data for analysis](#prepare-the-data-for-analysis)
4. [Process data by cleaning and checking it](#process-data-by-cleaning-and-checking-it)
5. [Analyze data](#analyze-data)
6. [Share data](#share-data)
7. [Act on the data with Recommendation](#act-on-the-data-with-recommendation)

### Quick links:
Source of the Data: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) [accessed on 22/06/25]

SQL Queries: 
1. [Data Combining](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Combining.sql)
2. [Data Exploration](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Exploration.sql)

Tableu :

## Background of Cyclistic Project 
Cyclistic is a bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.   

### casual riders & annual members
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. 
* Customers who purchase single-ride or full-day passes are referred to as casual riders.
* Customers who purchase annual memberships are Cyclistic members.  
  
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno (the director of marketing and my manager) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.  

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.  

## Ask Questions and Define the Goal

### Business Goal 
Design marketing strategies to convert casual riders to annual members.

### Key Business Questions
Three questions will guide the future marketing program:  
1. How do annual members and casual riders use Cyclistic bikes differently?  
2. Why would casual riders buy Cyclistic annual memberships?  
3. How can Cyclistic use digital media to influence casual riders to become members?  

Moreno has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

## Prepare the data for analysis 

### Data Source
Using Cyclistic’s historical trip data to analyze and identify trends from January 2024 to December 2024 which can be downloaded from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html).

The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement). This is public data that can be used to explore how different customer types are using Cyclistic bikes.  

### Data Organization
There are 12 files with naming convention of YYYYMM-divvy-tripdata and each file includes information for each month, such as the ride & station id, bike type, start & end time, start & end station, start & end location, and whether the rider is a annual member or not. 

The corresponding column names are ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.

## Process data by cleaning and checking it 

SQL BigQuery is used to combine 12 datasets from each month into one dataset and clean it.
### Consideration for Choosing Tools
* Cyclistic is a large dataset that has more than 5.6 million rows.
* So, it is crucial to use SQL BigQuery which is designed to efficiently handle and manage large-scale data.
* In the other hand, Excel isn't suitable for the Cyclistic dataset because it can't handle more than 1 million rows. 
### Combining the Data
SQL Query: [Data Combining](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Combining.sql) 

Step:
1. 12 csv files are uploaded as tables in the dataset '2024_Cyclistic'.
2. Then, Merge all 12 tables & Create "combined_data" table that containing 5,860,568 rows of data for the entire year. 

### Data Exploration
SQL Query: [Data Exploration](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Exploration.sql)

To know what kind of data that needed to be clean, I am familiarizing myself with the dataset

**Observations :**
1. The table below shows that all column names already has the right data types. In this data, The __ride_id__ column is the primary key.  

   ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/data%20types%20of%20all%20columns.png)  

2. Identify number of __null values__ in each column.  
   
   ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/number%20of%20null%20values%20in%20all%20columns.png)

* Note that some columns have same number of missing values. This may be due to missing information in the same row i.e. station's name and id for the same station and latitude and longitude for the same ending station.
  
3. ride_id as the primary key must has distinct values. So, I need to check for duplicates.  

   ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Check%20Duplicates.png)

** Return:** There are no __duplicate__ rows in the data.  
   
4. All __ride_id__ values have length of 16. so, there's no need to clean it.
   ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/length%20of%20ride_id.png)
   * We check it by compare the total rows with the rows that have length of 16.
      
6. There are 3 unique types of bikes(__rideable_type__) in Cyslistic data.

   ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/3%20unique%20types%20of%20bikes.png)

7. The __started_at__ and __ended_at__ shows start and end time of the trip in YYYY-MM-DD hh:mm:ss UTC format.
8. Group It based on the total trip duration:
   * 7596 rows trips which has duration longer than a day 
   * 132644 trips having less than a minute duration or having end time
     earlier than start time, I need to remove them. 
     
10. Total of 1073951 rows have both __start_station_name__ and __start_station_id__ missing which needs to be removed.
11. Total of 1104653 rows have both __end_station_name__ and __end_station_id__ missing which needs to be removed.
12. Total of 7232 rows have both __end_lat__ and __end_lng__ missing which needs to be removed.
13. Identify & Calculate each type of member riders :
    * 2151658 member riders
    * 3708910 casual riders
14. The start_station_id and end_station_id columns should be removed, as they do not contribute meaningful insights to the current analysis. While the longitude and latitude columns may not be directly used in the analysis, they can still be useful for map visualizations.

### Data Cleaning
SQL Query: [Data Cleaning]( )  
1. All the rows having missing values are deleted.  
2. 3 more columns ride_length for duration of the trip, day_of_week and month are added.  
3. Trips with duration less than a minute and longer than a day are excluded.
4. Total 1,375,912 rows are removed in this step.


  
