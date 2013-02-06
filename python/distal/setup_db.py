# easy_install -U distribute
# sudo easy_install mysql-python
# pip install mysql-python

import MySQLdb

connection = MySQLdb.connect(user="root", passwd="")

cursor = connection.cursor()
cursor.execute("DROP DATABASE IF EXISTS distal")
cursor.execute("CREATE DATABASE distal")
cursor.execute("USE distal")
cursor.execute("""
CREATE TABLE countries (
id INTEGER AUTO_INCREMENT PRIMARY KEY,
name CHAR(255) CHARACTER SET utf8 NOT NULL,
outline POLYGON NOT NULL,
SPATIAL INDEX (outline))
ENGINE = MYISAM
""")

cursor.execute("""
CREATE TABLE shorelines (
id INTEGER AUTO_INCREMENT PRIMARY KEY,
level INTEGER NOT NULL,
outline POLYGON NOT NULL,
SPATIAL INDEX (outline))
ENGINE = MYISAM
""")

cursor.execute("""
CREATE TABLE places (
id INTEGER AUTO_INCREMENT PRIMARY KEY,
name CHAR(255) CHARACTER SET utf8 NOT NULL,
position POINT NOT NULL,
SPATIAL INDEX (position))
ENGINE = MYISAM
""")

connection.commit()