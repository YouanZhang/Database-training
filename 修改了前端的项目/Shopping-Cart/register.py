from flask import *
import sqlite3, hashlib, os
import mysql.connector
from werkzeug.utils import secure_filename
def link_mysql():
    conn = mysql.connector.connect(user='root', password='vRt5leRdr8*t', database='online_shop2', use_unicode=True)
    return conn

def close_db_link(conn):
    conn.close()


#注册买家
def register_buyer(name, password, email, address):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO BUYER VALUES (NULL,%s,%s,%s,%s);',(name,password,email,address))
    conn.commit()
    cur.close()
    conn.close()
    print("Successfully INSERT INTO BUYER VALUES (NULL,%s,%s,%s,%s);", (name,password,email,address))

#注册卖家
def register_shop(name, description, password,email):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO SHOP VALUES (NULL,%s,%s,%s,%s);', (name, description, password, email))
    conn.commit()
    cur.close()
    conn.close()
    print('Successfully INSERT INTO SHOP VALUES (NULL,%s,%s,%s,%s);', (name, description, password, email))

#添加SPU
def addSPU(name, desc, qty):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO SHOP VALUES (NULL, %s, %s, %s);',(name, desc, qty))
    conn.commit()
    cur.close()
    conn.close()
    print('Successfully INSERT INTO SHOP VALUES (NULL, %s, %s, %s);',(name, desc, qty))


