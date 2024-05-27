# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the datasets
file_path_2019 <- "/kaggle/input/q1-bike-trips-2019-2020-years/Divvy_Trips_2019_Q1.csv"
file_path_2020 <- "/kaggle/input/q1-bike-trips-2019-2020-years/Divvy_Trips_2020_Q1.csv"
df_2019 <- read.csv(file_path_2019, stringsAsFactors = FALSE)
df_2020 <- read.csv(file_path_2020, stringsAsFactors = FALSE)

# Inspect column names
cat("Column names of df_2019:\n")
print(colnames(df_2019))
cat("Column names of df_2020:\n")
print(colnames(df_2020))

# Rename and convert data types to match before combining
df_2019 <- df_2019 %>%
  rename(
    ride_id = trip_id,
    started_at = start_time,
    ended_at = end_time,
    member_casual = usertype
  ) %>%
  mutate(
    ride_id = as.character(ride_id),
    member_casual = ifelse(member_casual == "Subscriber", "member", "casual")
  )

df_2020 <- df_2020 %>%
  rename(
    ride_id = ride_id,
    started_at = started_at,
    ended_at = ended_at,
    member_casual = member_casual
  ) %>%
  mutate(ride_id = as.character(ride_id))

# Combine the dataframes
df_combined <- bind_rows(df_2019, df_2020)

# Check the content and data type of the 'started_at' and 'ended_at' columns
cat("First few values of started_at:\n")
print(head(df_combined$started_at))
cat("First few values of ended_at:\n")
print(head(df_combined$ended_at))

# Ensure the date columns are read as characters if they are not
df_combined$started_at <- as.character(df_combined$started_at)
df_combined$ended_at <- as.character(df_combined$ended_at)

# Convert started_at and ended_at to POSIXct using the correct format
df_combined$started_at <- as.POSIXct(df_combined$started_at, format="%Y-%m-%d %H:%M:%S")
df_combined$ended_at <- as.POSIXct(df_combined$ended_at, format="%Y-%m-%d %H:%M:%S")

# Create new columns for date, hour, day of the week, and ride duration
df_combined$date <- as.Date(df_combined$started_at)
df_combined$hour <- format(df_combined$started_at, "%H")
df_combined$day_of_week <- format(df_combined$started_at, "%A")
df_combined$ride_duration <- as.numeric(difftime(df_combined$ended_at, df_combined$started_at, units="mins"))

# Filter out invalid ride durations and NA values in member_casual
df_combined <- df_combined %>% filter(!is.na(ride_duration) & ride_duration > 0 & !is.na(member_casual))

# Ensure data types are correct
df_combined$hour <- factor(df_combined$hour, levels = sprintf("%02d", 0:23))  # Ensure hours are factors
df_combined$day_of_week <- factor(df_combined$day_of_week, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Verify the changes
cat("\nStructure of the dataframe after transformations:\n")
print(str(df_combined))
cat("\nNumber of rows after filtering:\n")
print(nrow(df_combined))
cat("\nUnique values in member_casual:\n")
print(unique(df_combined$member_casual))
cat("\nSummary of ride_duration:\n")
print(summary(df_combined$ride_duration))

# Summary statistics for ride duration by user type
summary_stats <- df_combined %>%
  group_by(member_casual) %>%
  summarise(
    count = n(),
    mean_duration = mean(ride_duration, na.rm = TRUE),
    median_duration = median(ride_duration, na.rm = TRUE),
    max_duration = max(ride_duration, na.rm = TRUE),
    min_duration = min(ride_duration, na.rm = TRUE)
  )

cat("\nSummary statistics:\n")
print(summary_stats)

# Generate Plots

# Ensure ride_duration is numeric
df_combined$ride_duration <- as.numeric(df_combined$ride_duration)

# Remove any rows with NA values in ride_duration
df_combined <- df_combined %>% filter(!is.na(ride_duration))

# Generate histogram of ride duration by user type
cat("\nGenerating histogram...\n")
ggplot(df_combined, aes(x = ride_duration, fill = member_casual)) +
  geom_histogram(binwidth = 5, position = "dodge") +
  scale_x_log10() +  # Log scale for better visualization
  labs(title = "Distribution of Ride Duration by User Type", x = "Ride Duration (minutes)", y = "Count") +
  theme_minimal()

# Generate bar chart of rides by hour of the day
cat("\nGenerating bar chart of rides by hour...\n")
ggplot(df_combined, aes(x = hour, fill = member_casual)) +
  geom_bar(position = "dodge") +
  labs(title = "Rides by Hour of the Day", x = "Hour of the Day", y = "Count") +
  theme_minimal()

# Generate bar chart of rides by day of the week
cat("\nGenerating bar chart of rides by day of the week...\n")
ggplot(df_combined, aes(x = day_of_week, fill = member_casual)) +
  geom_bar(position = "dodge") +
  labs(title = "Rides by Day of the Week", x = "Day of the Week", y = "Count") +
  theme_minimal()