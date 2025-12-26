import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import pandas as pd

from sklearn.datasets import load_breast_cancer

raw_data = load_breast_cancer()

data = pd.DataFrame(
    raw_data.data,
    columns=raw_data.feature_names,
    
)
data.reset_index(drop=True)

print(data.columns)




