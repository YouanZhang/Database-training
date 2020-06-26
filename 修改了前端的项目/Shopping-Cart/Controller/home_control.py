from DAO.SKU import *
def getRecommPage(buyer_id):
    list = []
    count = 0
    for i in range(100):
        valid, data = findSKUbyid(i)
        if valid:
            list += data
            count+=1
        if count >= 4:
            break
    return list

def getFirstPageForNotLogin():
    list = []
    count = 0
    for i in range(100):
        valid, data = findSKUbyid(i)
        if valid:
            list += data
            count += 1
        if count >= 4:
            break
    return list

#print(getFirstPageForNotLogin())