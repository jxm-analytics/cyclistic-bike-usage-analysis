# Cyclistic Rider Segmentation Strategy

This project analyzes behavioral data from a Chicago-based bike-sharing service, Cyclistic, to identify opportunities for converting casual riders into long-term subscribers. Using a full year of ride history, the project segments users by behavior patterns and provides actionable marketing recommendations based on usage trends.

---

## Table of Contents

- [Project Objective](#project-objective)
- [Business Questions](#business-questions)
- [Tools and Techniques](#tools-and-techniques)
- [Data Preparation](#data-preparation)
- [Analysis Highlights](#analysis-highlights)
- [Marketing Strategy Recommendations](#marketing-strategy-recommendations)
- [Key Takeaways](#key-takeaways)
- [Contact](#contact)
- [License](#license)

---

## Project Objective

To help Cyclistic increase its number of annual memberships by identifying:
- How casual riders differ from members in ride behavior
- Which usage patterns indicate conversion potential
- What data-driven strategies could support targeted marketing campaigns

---

## Business Questions

- Do members and casual riders differ by ride duration, time of day, or day of week?
- Are there specific neighborhoods or start stations where casual riders concentrate?
- Can behavioral patterns suggest when and where to promote membership upgrades?

---

## Tools and Techniques

- Python and pandas for data cleaning and transformation
- Tableau for data visualization
- Excel for preliminary exploration and sanity checks

---

## Data Preparation

- Combined and cleaned 12 monthly `.csv` ride files
- Removed duplicates, test accounts, and incomplete records
- Engineered new features: ride duration, ride day, day part (commute/weekend), and user type
- Aggregated ride metrics by member type, weekday, station, and rideable type

---

## Analysis Highlights

- Casual riders mostly ride on weekends, during midday hours, and take shorter trips
- Members tend to ride on weekdays, often during rush hours, and take longer trips overall
- High-volume casual usage clusters around tourist-heavy start stations (e.g., parks, waterfronts)

---

## Marketing Strategy Recommendations

Based on behavior segmentation, Cyclistic could consider:

- **Targeted Trial Campaigns:** Promote weekday-based trial memberships to casual users who ride frequently
- **Tourism Partnerships:** Collaborate with hotels, museums, and tourist hubs to offer casual riders discounts that lead to conversion
- **Commute Incentives:** Highlight benefits of annual membership for weekday commuting (longer ride time, predictable pricing)
- **Geo-targeted Ads:** Use high-casual-traffic stations as zones for physical or digital ads promoting upgrade offers

---

## Key Takeaways

- Behavioral segmentation can reveal conversion opportunities beyond surface metrics
- Casual riders are not a monolith — some resemble members in habits and are good upgrade candidates
- Strategic marketing, backed by trip data, could convert a subset of high-value casual riders
- This project demonstrates how data analytics can support customer lifecycle strategy

---

## Contact

Created by [Jake Ma](https://www.linkedin.com/in/jakexm-analytics/)  
Let’s connect if you’re hiring or want to discuss growth strategy through behavioral analytics.
