from flask import Flask
from flask import Flask, render_template, request, url_for
import pymongo
from pymongo import MongoClient


app = Flask(__name__)



@app.route("/")
def form():
    return render_template('form.html')

@app.route('/hello/', methods=['POST'])
def hello():
    client=MongoClient()
    db=client.db
    users=db.users
    name=request.form['fname']
    lastname=request.form['lname']
    user=users.find_one({"name":name})
    if user==None:
    	return "you are offline"
    else:
    	return "you are online"

if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0')

