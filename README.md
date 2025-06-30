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
**Source of the Data:** [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) [accessed on 22/06/25]

**SQL Queries: **
1. [Data Combining](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Combining.sql)
2. [Data Exploration](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Exploration.sql)
3. [Data Cleaning](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Cleaning.sql)
4. [Data Analysis](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Analysis.sql)

**Tableu :**
	
 Click [here](https://public.tableau.com/views/GoogleDACapstoneCyclisticproject/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) to see the Dashboard

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

* Note that some columns have the same number of missing values, which may indicate that the missing information comes from the same rows
* for example, missing both the station's name and ID, or the latitude and longitude of the same ending station.
  
3. ride_id as the primary key must has distinct values. So, I need to check for duplicates.  

   ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Check%20Duplicates.png)

** Return:** There are no __duplicate__ rows in the data.  
   
4. All __ride_id__ values have length of 16. so, there's no need to clean it.
   ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/length%20of%20ride_id.png)
   * Icheck it by compare the total rows with the rows that have length of 16.
      
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
SQL Query: [Data Cleaning](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Cleaning.sql)  
First, I need to create new table with clean data. That way, I still have the raw data, in case something happen  
1. I will extract and convert day & month from DATETIME
2. Then, add day_of_week & month as a new collumn
3. Then, use Subquery & Join to Create new collumn: ride_length 
4. Remove All the rows that have missing values
5. Filter my data with WHERE
   
   _ride_length > 1 AND ride_length < 1440_
   * To excluded data that has Trips with duration less than a minute and
     longer than a day
7. Total 1.692.411 rows are removed in this step.

## Analyze data
SQL Query: [Data Analysis](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Data%20Analysis.sql)

The data is stored appropriately and is now prepared for analysis. I queried multiple relevant tables for the analysis and visualized them in Tableau.  
The analysis question is: How do annual members and casual riders use Cyclistic bikes differently?  

### Descriptive Statistic
Before Analyze it, lets conduct descriptive statistic to get a better sense of the data layout.
1. The mean of ride_length : 16.77 minutes
2. The max ride_length : 1439.83 minutes = 23 hours 59 minutes
3. Top 3 day_of_week

![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/mode%20of%20day_of_week.png)

5. Top 3 rideable_type
   
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/mode%20of%20rideable_type%20.png)
	
### Data Analysis
bikes types used by each type of riders (member & casual)

1.	Calculate **total trips/riders**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/member%20and%20casual%20riders.png) 
 
* The members make 63.87% of the total while remaining 36.13% constitutes casual riders

----------------------------------------------------
2.	member and casual riders are compared by the **type of bikes** they are using.

![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/bikes%20types%20used%20by%20each%20type%20of%20riders.png) 

![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/BkTypes_Rider.png)

In this table, we can see how bike types are distributed in each riders.

* **casual riders**: Most used bike is classic bike followed by the electric bike. electric scooter are used the least.
* **member riders**: Most used bike is classic bike followed by the electric bike. electric scooter are used the least.

--> So, in both cases: 
*	Most used bike is classic bike with 2.714.476 trips 
*	Followed by the electric bike with 1.406.741 trips 
* The least used is electric scooter with 46.940 trips 
 
--------------------------------------------

3.	Next, I analyze **the distribution of total trips** across months, weekdays, and hours of the day.
   
  **a.**	**Trips per Month :**
 
  •	QUERY: Since, the month is not in number format. To sort the months in     order from January to December, I use 'CASE Month WHEN…THEN…). 
 
  ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Code%20trip%20per%20month.png)

  Result:
  
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/total%20trips%20of%20each%20riders%20per%20month.png) 
 ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/Sum_trips_M.png)
 
When it comes to monthly trips, both casual and members exhibit comparable behavior:
* There are more trips in the spring and summer (Mar--Aug). 
* There are fewer in the winter (Dec--Feb).
* The gap between casuals and members is closest in the month of December in winter.

Peak Month for Each Rider
* For casual rider, the peak month is July. Then, followed by August & September. 
* For member rider, the peak month is September. Then, followed by  August & July.
  
  **b.	Trips per Day**

  * QUERY:	Since, the month is not in number format. To sort the months in   order from January to December, I use 'CASE Month WHEN…THEN…). 
 
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Code%20Trips%20per%20Day.png)

  Result:
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Trips%20per%20Day.png)  
 
 ![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/Sum_trips_Dy.png)

**Days of Week:** 
* casual riders make more journeys on the weekends.
* While members make more journeys on the weekdays. And it show a decline over the weekend in contrast to the other days of the week.
 
  **c.** **Trips per Hours**

  **Total Trips per Hours for Casual riders**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Trips%20per%20hour%20cs.png) 

   **Total Trips per Hours for member riders**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/Trips%20per%20hour%20mm.png)

![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/Sum_trips_Hr.png)

**Hours of the Day:** 
* The members shows 2 peaks throughout the day in terms of number of trips. One is early in the morning at around 6 AM to 8 AM and other is in the evening at around 4 PM to 6 PM
* while number of trips for casual riders increase consistently over the day till evening (4 AM - 5 PM) and then decrease afterwards (above 5 PM).  
 
#### SUMMARY of total Trip per Month / Day / Hour 
Conclusion based on the previous result:
 * member riders may be using bikes for commuting to and from the work in the week days
 * while casual riders are using bikes throughout the day, more frequently over the weekends for leisure purposes.
 * Both riders are most active in summer and spring.
 
---------------------------------------------------------

4.	Then, **Avg ride durations** are analyzed to uncover behavioral differences between casual and member riders.
   
Here's the result

**average ride duration per month**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/AVG%20ride%20duration.png)
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/Avg_DurMon.png)

**average ride duration per day**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/AVG%20ride%20duration%20per%20day.png) 
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/Avg_DurDy.png)

**average ride duration per hour for casual riders**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/AVG%20ride%20duration%20per%20hour%20cs.png) 

**average ride duration per hour for member riders**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/AVG%20ride%20duration%20per%20hour%20mm.png) 

![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/Avg_DurHr.png)

casual riders tend to cycle longer than members do on average. 
* Overall avg ride duration for casual riders: 24 minutes
* Overall avg ride duration for member riders: 14 minutes

The length of the average journey for members doesn't change throughout the year, week, or day.
* The range of the avg ride duration for member riders is always 10-14 minutes.
  
However, there are variations in how long casual riders cycle. 
* In the spring and summer, on weekends, and from 9 am to 3 pm during the day, they travel greater distances.
* From 2 - 4 AM, they also have brief trips. 
  
These insights suggest that **casual riders tend to take longer trips—about twice as long—but ride less often compared to members.**

* Their trips are typically longer on weekends, during non-commuting hours (9 am to 3 pm), and in the spring and summer months, indicating that they likely ride for **leisure or recreational purposes** rather than daily commuting.

----------------------------
5. Analyze **the locations of starting and ending stations**
   
To further understand the differences in casual and member riders.

* Stations with the most trips are considered using filters to draw out the following conclusions.  
 
You can download "the locations of starting and ending stations data" as an Excel file [here](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/starting%20%26%20ending%20station%20locations%20(1).xlsx)

**starting stations**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/start_loc.png)

**ending stations**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/End_Loc.png)

**Insights:**

Casual riders have frequently started their trips from the stations in vicinity of parks, Paved trail / greenway, Commercial area.

while members have begun their journeys from stations close to universities, residential areas, restaurants, hospitals, schools, factories, train stations,and parks.

Similar trend can be observed in ending station locations. 
* Casual riders end their journay near parks, Paved trail / greenway, Commercial area, and other recreational sites.
* while, member riders end their trips close to factories, universities, train stations, residential and greenway.
* So this proves that  casual riders primarily use bikes for recreational purposes, while members depend on them for daily commute.  

## Share data 

**Dashboard 1: Rider Overview & Usage Volume**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/Dashboard%201.png)

**Dashboard 2: Ride Duration & Station Analysis**
![image](https://github.com/Zidna-IM/Cyclistic-Google-capstone-project/blob/main/Cyclistic-Project/DViz/Dashboard%202%20(1).png)

### Summary of Analysis :

**Casual Riders**
* "Riders tend to prefer using bikes all day long, especially on weekends during the summer and spring, primarily for leisure activities
* Travel twice as long (24-30 minutes)  but less frequently than member riders.
* Start and end their journeys near parks, Paved trail / greenway, Commercial area and other recreational sites.
  
**Member Riders**
* Prefer riding bikes on weekdays during commute hours (6-8 am / 4-6 pm) in summer and spring.
* Travel more frequently but with shorter rides (approximately half the duration of casual riders’ trips(10-14 minutes).
* Start and end their trips close to factories, universities, train stations, residential and greenway.

## Act on the data with Recommendation
By understanding the behavior of casual and member riders, marketing strategies can be created to encourage casual riders to switch to membership.

**Recommendations:**

1. Marketing campaigns conducted during peak casual usage times (weekends, June--September) at recreational locations popular among casual riders (Park, Greenway & commercial area).

2. Casual riders tend to use their bikes to go to recreational locations. 
* So, place many check point in many popular recreational locations among casual riders.
* The more check points they reach, the more likely they are to get a big discount voucher or more free pass.

3. Casual riders travel twice as long (24-30 minutes) but less frequently. The jump from a single ride to an annual membership might seem too big.

So, Offer them : 
* **A short-term pass** (e.g., 1-month or 2-month or 3-month).
* **Annual membership with weekly version**. Provide more cheap price for casual riders
  
* It will give them unlimited & longer rides with low price. 


  
  
