from flask import Flask
from flask import render_template

app = Flask(__name__)

@app.route("/")
def home():
    return "Home Page"

@app.route("/<name>")
def name(name):
    for i in name:
        if i.isdigit():
            nonnumber = ''.join([j for j in name if not j.isdigit()])
            return "Welcome, " + nonnumber + ", to my CSCB20 Website!"
    if name.isupper():
        return "Welcome, " + name.swapcase() + ", to my CSCB20 Website!"
    elif name.islower():
        return "Welcome, " + name.swapcase() + ", to my CSCB20 Website!"
    else:
        return "Welcome, " + name + ", to my CSCB20 Website!"
    
    



if __name__ == "__main__":
    app.run(debug=True)