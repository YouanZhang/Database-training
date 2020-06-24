from DAO.second_class import *
from DAO.SPU import *
from DAO.shop import *
from DAO.SKU import *

def getLeftList():
    data = getNameIdFromSecondClass()
    for i in range(len(data)):
        spulist = findSPUbySecondClassId(data[i][0])
        data[i] = [data[i]] + [spulist]
        #print(i, ' ',len(data[i][1]) )
    return data

def getRightList(email, spu_id):
    NULL, data = find_shop_by_email(email)
    shop_id = data[0][0]
    #print(shop_id)
    ret = findSKUbyShopandSPU(shop_id, spu_id)
    return ret

#print(getLeftList())
#print(len(getLeftList()[1][1]))
print(getRightList('2879156336@qq.com', 3))
#print(findSKUbyShopandSPU(1, 3))