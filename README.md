# Text Over IoT

This is a project that solely focuses on IoT. The main objective is to send some text using a Flutter app and dynamically display said text on a 8x8 Matrix by using an ESP32 module.

# Technical Details

## Infraestructure

The project is composed by 3 units to simulate how a real IoT system would work in a real enviroment. The components are:
- **Mobile/Web Application**: This is what the user uses and interacts with to send stimulus to their IoT devices. For this specific project, the application accepts 3 inputs:
  - Python IP Server Address
  - ESP Node IP Adress
  - Text to Display
- **Python Server**: This component acts as a middleware. This the unit that interacts both with the user App and with the ESP32 Node
- **ESP32 Node**: This is the electronic component that communicates through WiFi to receive instructions regarding what it should display on the 8x8 LED Matrix

## Programming Language
For the user application, it was made using [Flutter](https://flutter.dev). It is a strong and a popular tool for developing cross platform, beautiful and natively-comparable applications.

For the Python server, as the name implies, Python along with Flask were used to develop the middleware. This decision was taken due to how easy is to develop a server using Python, and the previous experience by working with both tools in other projects.

And for the IoT end, I decided to work with [MicroPython](https://github.com/FunPythonEC/Python_para_MicroControladores) once again due to my experience with the tool on previous IoT-related projects. The tool is very easy to use and makes programming the ESP32 node a breeze.

## Hardware
Since we needed a microchip with WiFi module to decentralize the hardware, it was decided to use an ESP that is ESP32 for the production model. This is because of the availability of an ESP node component and because ESP32 is slightly more powerful compared to an ESP8266.

## Communication Protocol
All the 3 components interact with each other by using WiFi. However, between the user application and the Python Middleware Server, a POST request is being used to exchange information.
The User App sends a POST request to the python server with an encoded JSON inside its body. The JSON follows the next format:

```yaml
{
    "espIP": "192.168.1.xxx",            # String
    "text": "Text to Display",           # String
}
```

Now between the Python server and the ESP32 node, the communication is done through low level socket programming due to ESP32 not supporting an Application Layer API. On the Python server, the text is encoded in bytes and said bytes are sent to the ESP32 and decoded back into a string to later display it on the 8x8 Matrix
