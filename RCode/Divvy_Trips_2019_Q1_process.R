# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the dataset
file_path <- "/kaggle/input/bike-2019-datasets/Divvy_Trips_2019_Q1.csv"
df <- read.csv(file_path, stringsAsFactors = FALSE)

# Inspect the first few rows and structure of the dataframe
cat("First few rows of the dataframe:\n")
print(head(df))
cat("Structure of the dataframe:\n")
print(str(df))

# Rename the date-time columns to a consistent format
df <- df %>% rename(
  started_at = start_time,
  ended_at = end_time
)

# Check the content and data type of the 'started_at' and 'ended_at' columns
cat("First few values of started_at:\n")
print(head(df$started_at))
cat("First few values of ended_at:\n")
print(head(df$ended_at))

# Ensure the date columns are read as characters if they are not
df$started_at <- as.character(df$started_at)
df$ended_at <- as.character(df$ended_at)

# Inspect unique date formats to determine the correct format
cat("Unique values of started_at:\n")
print(unique(head(df$started_at, 10)))
cat("Unique values of ended_at:\n")
print(unique(head(df$ended_at, 10)))

# Convert started_at and ended_at to POSIXct using the correct format
df$started_at <- as.POSIXct(df$started_at, format="%Y-%m-%d %H:%M:%S")
df$ended_at <- as.POSIXct(df$ended_at, format="%Y-%m-%d %H:%M:%S")

# Create new columns for date, hour, day of the week, and ride duration
df$date <- as.Date(df$started_at)
df$hour <- format(df$started_at, "%H")
df$day_of_week <- format(df$started_at, "%A")
df$ride_duration <- as.numeric(difftime(df$ended_at, df$started_at, units="mins"))

# Filter out invalid ride durations
df <- df %>% filter(!is.na(ride_duration) & ride_duration > 0)

# Ensure data types are correct
df$hour <- factor(df$hour, levels = sprintf("%02d", 0:23))  # Ensure hours are factors
df$day_of_week <- factor(df$day_of_week, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Verify the changes
cat("\nStructure of the dataframe after transformations:\n")
print(str(df))
cat("\nNumber of rows after filtering:\n")
print(nrow(df))
cat("\nUnique values in usertype:\n")
print(unique(df$usertype))
cat("\nSummary of ride_duration:\n")
print(summary(df$ride_duration))

# Summary statistics for ride duration by user type
summary_stats <- df %>%
  group_by(usertype) %>%
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
df$ride_duration <- as.numeric(df$ride_duration)

# Remove any rows with NA values in ride_duration
df <- df %>% filter(!is.na(ride_duration))

# Generate histogram of ride duration by user type
cat("\nGenerating histogram...\n")
ggplot(df, aes(x = ride_duration, fill = usertype)) +
  geom_histogram(binwidth = 5, position = "dodge") +
  scale_x_log10() +  # Log scale for better visualization
  labs(title = "Distribution of Ride Duration by User Type", x = "Ride Duration (minutes)", y = "Count") +
  theme_minimal()

# Generate bar chart of rides by hour of the day
cat("\nGenerating bar chart of rides by hour...\n")
ggplot(df, aes(x = hour, fill = usertype)) +
  geom_bar(position = "dodge") +
  labs(title = "Rides by Hour of the Day", x = "Hour of the Day", y = "Count") +
  theme_minimal()

# Generate bar chart of rides by day of the week
cat("\nGenerating bar chart of rides by day of the week...\n")
ggplot(df, aes(x = day_of_week, fill = usertype)) +
  geom_bar(position = "dodge") +
  labs(title = "Rides by Day of the Week", x = "Day of the Week", y = "Count") +
  theme_minimal()
