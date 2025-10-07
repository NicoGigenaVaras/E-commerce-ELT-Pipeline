from typing import Dict # Import the Dict type for function annotations
import requests # Import the requests library to make HTTP requests to APIs
from pandas import DataFrame, read_csv, read_json, to_datetime # Import pandas classes and functions to work with tabular data

# Set the base URL for the API that provides public holidays data
public_holidays_url = "https://date.nager.at/api/v3/PublicHolidays" 
# Set the year to query public holidays for (2017)
year = '2017'

# TODO: Implement this function. 
# You must use the requests library to get the public holidays for the given year.
# The url is public_holidays_url/{year}/BR.
# response = requests.get(f"{public_holidays_url}/{year}/BR")
# You must delete the columns "types" and "counties" from the dataframe.
# df = df.drop(columns=["types", "counties"])
# You must raise a SystemExit if the request fails. Research the raise_for_status
# method from the requests library.

def get_public_holidays(public_holidays_url: str, year: str) -> DataFrame:
    """Get the public holidays for the given year for Brazil.

    Args:
        public_holidays_url (str): url to the public holidays.
        year (str): The year to get the public holidays for.

    Raises:
        SystemExit: If the request fails.

    Returns:
        DataFrame: A dataframe with the public holidays.
    """

    # Build the URL for the API request, adding the year and country (BR)
    url = f"{public_holidays_url}/{year}/BR"
    # Try to send a GET request to the API
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raises an error if the response is not OK (200)
    # If the request fails, print the error and exit the program
    except requests.RequestException as e:
        print(f"Error fetching public holidays: {e}")
        raise SystemExit(e)
    # Convert the JSON response into a pandas DataFrame
    data = response.json()
    df = DataFrame(data)
    # Drop unnecessary columns
    for col in["types", "counties"]:
        df = df.drop(columns=[col]) 
    # If the "date" column exists, convert it to datetime
    if "date" in df.columns:
        df["date"] = to_datetime(df["date"]) 
    # Return the final DataFrame with the holidays
    return df

    # raise NotImplementedError


def extract(
    csv_folder: str, csv_table_mapping: Dict[str, str], public_holidays_url: str
) -> Dict[str, DataFrame]:
    """Extract the data from the csv files and load them into the dataframes.
        
    Args:
        csv_folder (str): The path to the csv's folder.
        csv_table_mapping (Dict[str, str]): The mapping of the csv file names to the
        table names.
        public_holidays_url (str): The url to the public holidays.
        
    Returns:
        Dict[str, DataFrame]: A dictionary with keys as the table names and values as
        the dataframes.
    """

    # Load each CSV file into a DataFrame, using the mapping to assign table names
    dataframes = {
        table_name: read_csv(f"{csv_folder}/{csv_file}")
        for csv_file, table_name in csv_table_mapping.items()
    }
    # Get the Brazilian public holidays for the year 2017
    holidays = get_public_holidays(public_holidays_url, "2017")
    # Add the holidays DataFrame to the dictionary
    dataframes["public_holidays"] = holidays
    # Return all extracted DataFrames
    return dataframes




  