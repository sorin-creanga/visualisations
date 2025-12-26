import pandas as pd
from wbdata import get_dataframe

indicators = {
    "NY.GDP.PCAP.CD": "gdp_pc",
    "SP.DYN.LE00.IN": "life_exp",
    "SP.POP.TOTL": "population"
}

data = get_dataframe(indicators).reset_index()

data.rename(columns={"date": "year"}, inplace=True)

data["year"] = (
    data["year"]
    .astype(str)
    .str.extract(r"(\d{4})")
    .astype(int)
)




x = (
    data
    .groupby("country")["year"]
    .transform(lambda x: ", ".join(map(str, x)))
)


print(x.head())