from DAO.link_database  import  *

#查询用户
def find_buyer_by_id(id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM BUYER WHERE `buyer_id` = %s', (id, ))
    data = cur.fetchone()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

def find_buyer_by_email(email):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM BUYER WHERE `e_mail` = %s', (email,))
    data = cur.fetchone()
    # print('SELECT * FROM BUYER WHERE `e_mail` = %s AND `password` = %s', (email, password))
    vaild = len(data) != 0
    cur.close()
    conn.close()
    return vaild, data

def update_buyer(id, name, password, address):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('UPDATE BUYER SET `nick_name`=%s, `password`=%s, `address` = %s\
     WHERE `buyer_id` = %s;', (name, password, address, id))
    conn.commit()
    cur.close()
    conn.close()
    print('UPDATE BUYER SET `nick_name`=%s, `password`=%s, `address` = %s\
     WHERE `buyer_id` = %s;', (name, password, address, id))

#print(find_buyer_by_id(3))
#update_buyer(5, 'bochenghan', 123456, 'canton')