import pandas as pd
# query=input()
df=pd.read_csv('stocks.csv')
query='IEX'
results = df.query("symbol.str.contains(@query) or name.str.contains(@query)")
results = results.to_dict('records')
print(results)