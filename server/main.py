import base64
import json
import os
import re
import time
import uuid
import requests as rq
from time import sleep
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

dynamo = boto3.Session(profile_name="assemblage",
                       region_name="ap-south-1").client("dynamodb")


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
    try:
        data = rq.get('http://localhost:3000/stocks')
    except:
        pass
    sleep(5)
    with open('stocks.json') as f:
        data = json.load(f)
    return data


@app.get('/info')
@cross_origin()
def info():
    stock = request.args.get('stock')
    ticker = yf.Ticker(stock+'.NS')
    df = ticker.history(period='7d', interval='1d')
    df = df.reset_index()
    df = df[['Date', 'Close']]
    df = df.to_dict('records')
    response = dynamo.scan(
        TableName='stocks',
        FilterExpression="contains(symbol, :search_value)",
        ExpressionAttributeValues={":search_value": {"S": stock}}
    )
    response = response['Items']+df
    return jsonify(response)


@app.get('/search')
@cross_origin()
def search():
    query = request.args.get('query')
    query = query.upper()
    df = pd.read_csv('stocks.csv')
    results = df.query(
        "symbol.str.contains(@query) or name.str.contains(@query)")
    results = results.to_dict('records')
    return jsonify(results)


if __name__ == '__main__':
    app.run(host='0.0.0.0')
