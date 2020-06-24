from DAO.second_class import *
from DAO.SPU import *

def getLeftList():
    data = getNameIdFromSecondClass()
    for i in range(len(data)):
        spulist = findSPUbySecondClassId(data[i][0])
        data[i] = [data[i]] + spulist
    return data

#print(getLeftList())