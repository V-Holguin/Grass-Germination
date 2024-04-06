import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy import text

# Load the CSV file into a pandas DataFrame
df_weather = pd.read_csv('C:\\Users\\vince\OneDrive\Desktop\\March Air Force Base Last 10 Years.csv')

# Create a connection to the MySQL database
engine = create_engine('mysql+pymysql://root:password@localhost:3306/mydb')

# Write the data from the DataFrame to a new MySQL table
df_weather.to_sql('weather', con=engine, index=False, if_exists='replace')

# Used to test connection to database
#with engine.connect() as connection:
   # result = connection.execute(text("SELECT 1"))
   # print(result.fetchone())
