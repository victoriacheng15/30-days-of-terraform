import json

def lambda_handler(event, context):
    print("Lambda function invoked!")
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from AWS Lambda (Day A4)!',
            'platform': 'Serverless',
            'status': 'Success'
        })
    }
