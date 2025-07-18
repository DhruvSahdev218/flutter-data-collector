from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Sample in-memory storage
data_store = []

@app.route('/submit', methods=['POST'])
def submit_data():
    data = request.get_json()
    data_store.append(data)
    return jsonify({"message": "Data received successfully", "data": data}), 200

@app.route('/data', methods=['GET'])
def get_data():
    return jsonify(data_store), 200

if __name__ == '__main__':
    app.run(debug=True)
