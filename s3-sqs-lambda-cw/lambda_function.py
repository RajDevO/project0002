import json
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info("Received event: " + json.dumps(event, indent=2))
    
    for record in event['Records']:
        # Extract the SNS message
        sns_message = record['Sns']['Message']
        logger.info(f"Message received from SNS: {sns_message}")
    
    return {
        'statusCode': 200,
        'body': json.dumps('Message processed successfully!')
    }
