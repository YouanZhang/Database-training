from DAO.SKU import *
import random

def getRecommPage(buyer_id):
    list = []
    usedlist = []
    count = 0
    while True:
        i = random.randint(0, 40)
        if i in usedlist:
            continue
        usedlist += [i]
        valid, data = findSKUbyid(i)
        if valid:
            list += data
            count+=1
        if count >= 6:
            break
    return list

def getFirstPageForNotLogin():
    list = []
    usedlist = []
    count = 0
    while True:
        i = random.randint(0, 40)
        if i in usedlist:
            continue
        usedlist += [i]
        valid, data = findSKUbyid(i)
        if valid:
            list += data
            count += 1
        if count >= 6:
            break
    return list

#print(getFirstPageForNotLogin())