import mysql.connector
def link_mysql():
    conn = mysql.connector.connect(user='root', password='root', database='online_shop3', use_unicode=True)
    return conn