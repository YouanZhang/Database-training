from DAO.link_database import *
#还没写
def getNameIdFromSecondClass():
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT `SECOND_CLASS_ID`, `CLASS_NAME` FROM SECOND_CLASS')
    data = cur.fetchall()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    cur.close()
    conn.close()
    return data

#print(getNameIdFromSecondClass())