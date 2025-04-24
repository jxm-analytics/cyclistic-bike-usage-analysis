# Cyclistic Bike Usage Case Study

This case study explores how annual members and casual riders use Cyclistic’s bike-share system differently. By analyzing over 5 million ride records, the project identifies key behavioral patterns to support a targeted digital marketing strategy aimed at increasing annual memberships.

**Tools:** SQL, Excel, Tableau  
**Skills:** Data cleaning, customer segmentation, trend analysis, marketing insights

---

## Table of Contents

- [Business Task](#business-task)
- [Data Source and Preparation](#data-source-and-preparation)
- [Data Cleaning and Processing](#data-cleaning-and-processing)
- [Analysis and Visualization](#analysis-and-visualization)
- [Key Findings](#key-findings)
- [Recommendations](#recommendations)
- [Tools and Skills Used](#tools-and-skills-used)

---

## Business Task

Cyclistic’s goal is to convert more casual riders into annual members. This analysis helps answer:
- How do annual members and casual riders use bikes differently?
- What factors might motivate casual riders to become members?
- How can Cyclistic leverage data to guide marketing campaigns?

---

## Data Source and Preparation

- Sourced from [Divvy Bikes via Motivate International Inc.](https://divvybikes.com/system-data)
- Included monthly trip-level data for April 2020–2021
- Fields include ride ID, start/end timestamps, rideable type, station names, and user type

---

## Data Cleaning and Processing

- Removed duplicates and null values
- Filtered out records with negative ride times
- Standardized column names
- Added calculated fields:
  - Ride length
  - Day of the week
  - Ride type summary

---

## Analysis and Visualization

- Analyzed trip duration by rider type
- Charted ride frequency by weekday and hour
- Identified peak seasons and time-of-day usage
- Created dashboards in Tableau to visualize trends

---

## Key Findings

- Casual riders take longer rides, especially on weekends
- Members ride more frequently on weekdays, likely for commuting
- Casual usage is often recreational, member usage is utilitarian

---

## Recommendations

1. **Weekend Trials:** Offer weekend discounts to convert casual users  
2. **Targeted Ads:** Use ride behavior data to promote the value of memberships  
3. **Commuter Focus:** Emphasize weekday time savings and convenience for office workers  

---

## Tools and Skills Used

- **SQL (MySQL Workbench):** For data aggregation and validation  
- **Excel:** For cleaning and preprocessing  
- **Tableau:** For data storytelling through interactive dashboards
