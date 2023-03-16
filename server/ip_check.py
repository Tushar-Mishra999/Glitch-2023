import requests

api = '0ac9d965541ef507a2d5b8ea1054dcf49a86ec2961158156280ef7a2da11e862b497ee5edfb9afbd'


def check_isp(ip):
    known_isps = ['Bharti Airtel Ltd.', 'Bharti Airtel', 'Bharti Airtel Limited',
                  'Excitel', 'Excitel Broadband Private Limited', 'Jio']
    url = f'http://ip-api.com/json/{ip}'
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        if data['isp'] in known_isps or data['org'] in known_isps or data['city'] == 'Delhi':
            return True
    return False


def ip_check(ip):
    url = f'https://api.abuseipdb.com/api/v2/check?ipAddress={ip}&maxAgeInDays=90'
    headers = {
        'Key': api,
        'Accept': 'application/json'
    }
    if ',' in ip:
        for i in ip.split(','):
            if check_isp(i):
                return False
            response = requests.get(url, headers=headers)
            if response.status_code == 200:
                data = response.json()
                if data['data']['abuseConfidenceScore'] >= 50:
                    return True
            return False
    if check_isp(ip):
        return False
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        data = response.json()
        if data['data']['abuseConfidenceScore'] >= 50:
            return True
    return False
