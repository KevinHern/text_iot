# Pin and chip related
from machine import Pin, PWM

# Network related
import network, socket

# Others
import neopixel, time

# Connect to local Wi Fi
ssid = '---'
password = '---'

station = network.WLAN(network.STA_IF)
station.active(True)
station.connect(ssid, password)

# Attempting connection
print("Attempting to connect to the Wi Fi...")
while not station.isconnected():
    pass
print('Connection successful')
print(station.ifconfig())

# Create Server
print("Initializing Server...")
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # Creating Socket
s.bind(('', 43321))  # Setting up port to listen to
s.listen(1)  # Only accept at a maximum of N connections

print("Awaiting Connections...")
while True:
    conn, address = s.accept()
    # print('Got a connection from %s' % str(address))

    # Reading request
    request = conn.recv(1024)

    # Parsing Request
    text_to_display = request.decode("utf-8")

    # Closing connection to save network resources
    conn.close()

    # Executing
    mode = request & 0xFF000000


