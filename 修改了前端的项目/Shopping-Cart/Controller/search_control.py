from DAO.SKU import *

def findSKUbyFullMatch(id):
    id = str(id)
    if(id.isdigit()):
        id = int(id)
        NULL, data = findSKUbyid(id)
        return data
    else:
        return findSKUbyWord(id)

#print(findSKUbyFullMatch('2'))

