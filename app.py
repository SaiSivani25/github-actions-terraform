from flask import Flask, request
import os

app = Flask(__name__)

environment = os.environ.get("ENVIRONMENT", "local")

@app.route("/")
def calculator():
    return f"""
        <h1>Simple Calculator - {environment.upper()} Environment</h1>
        <form method="POST" action="/calculate">
            <input type="number" name="a" placeholder="Number 1">
            <select name="op">
                <option>+</option>
                <option>-</option>
                <option>*</option>
                <option>/</option>
            </select>
            <input type="number" name="b" placeholder="Number 2">
            <button type="submit">Calculate</button>
        </form>
    """

@app.route("/calculate", methods=["POST"])
def calculate():
    a = float(request.form["a"])
    b = float(request.form["b"])
    op = request.form["op"]
    if op == "+":
        result = a + b
    elif op == "-":
        result = a - b
    elif op == "*":
        result = a * b
    elif op == "/":
        result = a / b if b != 0 else "Error!"
    return f'<h1>Result: {result}</h1><a href="/">Back</a>'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)