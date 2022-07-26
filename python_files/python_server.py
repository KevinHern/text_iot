# Backend
from flask import Flask, request, jsonify, make_response
import socket
import json
import traceback

# dummy = {'hola': 5, 'asdf': "hola"}
# str("hola")
# print(json.dumps(dummy))

# '''
# Create the flask object
app = Flask(__name__)

# Initializing network stuff
PORT = 44321


@app.route('/')
def index():
    return "You should not be here"


@app.route('/text', methods=['POST', 'OPTIONS'])
def text():
    if request.method == "OPTIONS":  # Dispatching CORS preflight
        # Creating a very basic CORS preflight request. Allows every domain to upload a file while using ONLY
        # the POST method without caring what other headers the request may have.
        response = make_response()
        response.access_control_allow_origin = "*"
        response.access_control_allow_methods = "POST"
        response.access_control_allow_headers = "*"
        return response
    elif request.method == "POST":  # The actual request following the preflight
        # Initializing status variables
        response_dict = {}
        status_code = 0

        try:
            # Extracting JSON
            rjson = request.get_json()

            # Extracting parameters
            host = str(rjson['espIP'])
            text_to_send = str(rjson['text'])

            # Sending to the ESP
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.connect((host, PORT))
                s.sendall(bytes(text_to_send, 'utf-8'))
                s.close()

            # Setting up status
            response_dict["message"] = "Texto enviado correctamente"
            status_code = 200

        except KeyError:
            # Setting up status
            response_dict["message"] = "El formato JSON no llego como se esperaba. El servidor recibio esto: " + str(rjson)
            status_code = 406

        except Exception as e:
            # Setting up status
            response_dict = format("Ocurrio un error en el servidor: No se pudo conectar con el modulo ESP")
            status_code = 500

        # Building Actual Response
        response = make_response(jsonify(response_dict))
        response.status_code = status_code
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
    else:
        # Dispatching a no valid method
        response = make_response()
        response.status_code = 405  # Method not allowed server error code
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response


if __name__ == "__main__":
    app.run(host='127.0.0.1', port=PORT, debug=True)
# '''
