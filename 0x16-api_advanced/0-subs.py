#!/usr/bin/python3
""" Exporting csv files"""
import requests

def number_of_subscribers(subreddit):
    # Set up the URL and headers (with a custom User-Agent)
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {'User-Agent': 'python:subreddit.subscriber.counter:v1.0 (by /u/your_username)'}
    
    try:
        # Make a GET request to the Reddit API
        response = requests.get(url, headers=headers, allow_redirects=False)
        
        # Check if the request was successful (status code 200)
        if response.status_code == 200:
            data = response.json()
            return data['data']['subscribers']
        else:
            # If the status code is not 200, return 0
            return 0
    except requests.RequestException:
        # Handle any request exceptions by returning 0
        return 0
