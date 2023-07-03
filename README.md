# Black-Mirror-Analysis
## Description
The goal of this project was to use data to analyze the hit Netflix TV show *Black Mirror*, which recently released its long-awaited sixth season. The project combines **SQL**, specifically **PostgreSQL**, and **Python** to first create a database and then to analyze the data from the database using **DataFrames**. 

Using data from public sources such as Wikipedia and IMDb, **raw CSV** files were created. These raw CSV files were then imported to database tables where the data was normalized, eliminating vertical text replication. 

Finally, using a **JOIN**, a CSV file was created to be used for data analysis in Python. Within Python, a **Pandas DataFrame** was used to generate summary statistics and **Matplotlib** was used to visualize the findings. 

## Files
* `ER_Diagram.png` - entity-relationship model that showcases the various tables in the database and their connections to each other
* `Input` - contains the raw CSV files that were used to create the database
* `Output` - contains the CSV files exported from every table in the final database
* `Joined.csv` - table constructed from a JOIN on the database, used for the Python analysis
* `Create_Database.sql` - the SQL queries that normalize the data & create the database
* `Sample_Queries.sql` - example queries using the database
* `Black_Mirror_Analysis.ipynb` - Jupyter Notebook that goes through data cleaning, analysis, and visualization using Python

## Technologies
* PostgreSQL (using DBeaver)
* Python: NumPy, Pandas, Matplotlib, Datetime, SciPy

## Data Sources
Black Mirror. (2023, June 26). In *Wikipedia*. [https://en.wikipedia.org/wiki/Black_Mirror](https://en.wikipedia.org/wiki/Black_Mirror)
IMDb (2023, June 26). *Black Mirror*. [https://www.imdb.com/title/tt2085059/](https://www.imdb.com/title/tt2085059/)
List of Black Mirror episodes. (2023, June 24). In *Wikipedia*. [https://en.wikipedia.org/wiki/List_of_Black_Mirror_episodes](https://en.wikipedia.org/wiki/List_of_Black_Mirror_episodes)