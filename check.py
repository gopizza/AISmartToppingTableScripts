import os
import socket
import requests
import subprocess

from datetime import datetime

PASSWORD = "rhvlwk1234"

def message_print(message):
    nowDateTime = datetime.today().strftime('%Y-%m-%d %H:%M:%S')
    print(f'[{nowDateTime}] {message}')
    
def check_service_status(service_name):
    try:
        cmd1 = subprocess.Popen(["echo", PASSWORD], stdout=subprocess.PIPE)
        subprocess.run(["sudo", "-S", "systemctl", "is-active", "--quiet", service_name], stdin=cmd1.stdout, check=True)
        return True
    except subprocess.CalledProcessError:
        return False

def restart_service(service_name):
    cmd1 = subprocess.Popen(["echo", PASSWORD], stdout=subprocess.PIPE)
    subprocess.run(["sudo", "-S", "systemctl", "enable", service_name], stdin=cmd1.stdout, check=True)
    subprocess.run(["sudo", "-S", "systemctl", "restart", service_name], stdin=cmd1.stdout, check=True)
    
def check_app_status():
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect(('pwnbit.kr', 443))
        host = sock.getsockname()[0]
        
        response = requests.get(f"http://{host}:18000/app_status", timeout=3)
        response = response.json()
        return response['app_status']
    except:
        return False

# def restart_app():
#     subprocess.call(["sh", f"{os.environ['HOME']}/project/autostart_without_browser.sh"])


if __name__ == "__main__":
    service_name = "teamviewerd"

    if not check_service_status(service_name):
        message_print(f"Service '{service_name}' is not running. Restarting...")
        restart_service(service_name)
    else:
        message_print(f"Service '{service_name}' is running.")
        
    # if not check_app_status():
    #     message_print(f"Application is not running. Restarting...")
    #     restart_app()
    # else:
    #     message_print("Application is running.")