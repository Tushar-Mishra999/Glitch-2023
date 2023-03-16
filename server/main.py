import base64
import json
import os
import re
import time
import uuid
import requests as rq
from datetime import datetime, timedelta

import boto3
import MySQLdb.cursors as cur
import pandas as pd
import yfinance as yf
from botocore import client
from flask import Flask, jsonify, make_response, request
from flask_cors import CORS, cross_origin
from flask_mysqldb import MySQL

from ip_check import ip_check

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'test'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)
cors = CORS(app)

s3 = boto3.Session(profile_name="assemblage",
                   region_name="ap-south-1").client("s3")

cognito = boto3.Session(profile_name="assemblage",
                        region_name="ap-south-1").client("cognito-idp")


@app.get('/')
@cross_origin()
def index():
    return "Hello World!"


@app.post('/signup')
@cross_origin()
def signup():
    cursor = mysql.connection.cursor()
    data = request.get_json()
    email = data['email']
    password = data['password']
    name = data['name']
    phone = data['phone']


@app.get('/topmovers')
@cross_origin()
def topmovers():
    data=rq.get("https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%20100",headers={'User-Agent': rq.get('http://localhost:5000/ua').text}).text
    data=json.loads(data)
    data=data['data']
    
    

@app.get('/graph')
@cross_origin()
def graph():
    stock=request.args.get('stock')
    ticker=yf.Ticker(stock+'.NS')
    df=ticker.history(period='1y',interval='1d')
    df=df.reset_index()
    df=df[['Date','Close']]
    df['Date']=df['Date'].dt.strftime('%Y-%m-%d')
    df=df.to_dict('records')
    return jsonify(df)