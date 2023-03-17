import nltk
import boto3
from nltk.sentiment.vader import SentimentIntensityAnalyzer

nltk.download('vader-lexicon')
s3 = boto3.client('s3')
dynamo = boto3.resource('dynamodb')
sia = SentimentIntensityAnalyzer()


def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    file_obj = s3.get_object(Bucket=bucket, Key=key)
    file_content = file_obj['Body'].read().decode('utf-8')
    text = text
    symbol = key.split('_')[0]
    targetCompany = key.split('.')[0]

    sentences = nltk.sent_tokenize(text)
    score = 0

    # print(sentences)

    for sentence in sentences:
        # print(sentence)
        if targetCompany in sentence:
            score += sia.polarity_scores(sentence)['compound']

    table = dynamo.Table('stocks')
    table.update_item(
        Key={
            'symbol': symbol
        },
        UpdateExpression='SET sentiment = :val1',
        ExpressionAttributeValues={
            ':val1': score
        }
    )