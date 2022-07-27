# Other Libraries
from max7219 import Matrix8x8

# Pin and chip related
from machine import Pin, SPI
import time

# Network related
import network, socket

# Initializing Matrix
spi = SPI(1, baudrate=10000000, polarity=1, phase=0, sck=Pin(21), mosi=Pin(16))
ss = Pin(17, Pin.OUT)
display = Matrix8x8(spi, ss, 1)
display.brightness(15)

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
    text_to_display = text_to_display + " "

    # Closing connection to save network resources
    conn.close()

    for i in range(len(text_to_display)):
        display = Matrix8x8(spi, ss, i+1)
        display.text(text_to_display ,0,0,1)
        time.sleep(1)
        display.show()
