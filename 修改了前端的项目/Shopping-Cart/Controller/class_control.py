from DAO.second_class import *
from DAO.SPU import *

def getLeftList():
    data = getNameIdFromSecondClass()
    for i in range(len(data)):
        spulist = findSPUbySecondClassId(data[i][0])
        data[i] = [data[i]] + [spulist]
        #print(i, ' ',len(data[i][1]) )
    return data
#print(getLeftList())
#print(len(getLeftList()[1][1]))