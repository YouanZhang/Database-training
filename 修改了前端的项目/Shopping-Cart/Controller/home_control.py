from DAO.SKU import *
def getRecommPage(buyer_id):
    list = []
    for i in range(4):
        valid, data = findSKUbyid(i)
        if valid:
            list += data
    return list

def getFirstPageForNotLogin():
    list = []
    for i in range(4):
        valid, data = findSKUbyid(i)
        if valid:
            list += data
    return list

#print(getRecommPage(list))