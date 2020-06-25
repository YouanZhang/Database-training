import numpy as np
import pickle

with open('pickle/output.pickle', 'rb') as f:
    ret = pickle.load(f)

B = ret['B']
D = ret['D']

def ndcg(R, R_hat, k)
    n = np.size(R, 1)
