from typing import Dict # Import Dict to use in type hints (dictionary data type)
from pandas import DataFrame # Import DataFrame from pandas to work with tabular data 
from sqlalchemy.engine.base import Engine # Import Engine from SQLAlchemy, representing the SQLite database connection


# Define the load() function that will insert DataFrames into the database.
# It receives a dictionary where keys are table names and values are DataFrames to store.

def load(data_frames: Dict[str, DataFrame], database: Engine): # --> definimos funcion Load 
    # Loop through the dictionary: table_name is the name of the table,
    # df is the DataFrame to insert into the database
    for table_name, df in data_frames.items():
        # Use the pandas to_sql() method to insert the DataFrame into the database
        df.to_sql(
            name=table_name, # Table name in the database
            con=database, # Database connection
            index=False, # Don't store the DataFrame index as a column
            if_exists="replace" # Replace the table if it already exists
        )

    """Load the dataframes into the sqlite database.

    Args:
        data_frames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
    """
    # TODO: Implement this function. For each dataframe in the dictionary, you must
    # use pandas.Dataframe.to_sql() to load the dataframe into the database as a
    # table.
    # For the table name use the `data_frames` dict keys.