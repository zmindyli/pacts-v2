import json
from flask import Flask, request
import dao
import os
from db import db, User, Group, Activity, Poll1, Poll2, Event

app = Flask(__name__)
db_filename = "slack.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()

def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code
######################################################################################################
#users
#get all users
@app.route('/users/', methods=['GET'])
def get_all_users():
    return success_response(dao.get_all_users())
#get user by id
@app.route('/users/<int:user_id>/', methods=['GET'])
def get_user_by_id(user_id):
    user = dao.get_user_by_id(user_id)
    if user is None:
        return failure_response("User not found!")
    return success_response(user)

#create user
@app.route('/users/', methods=['POST'])
def create_user():
    body = json.loads(request.data)
    user = dao.create_user(
        name=body.get('name'),
        email=body.get('email'),
        year = body.get('year'),
        password = body.get('password')
    )
    return success_response(user)
#update user by id
@app.route('/users/<int:user_id>/', methods=['POST'])
def update_user_by_id(user_id):
    body = json.loads(request.data)
    user = dao.update_user_by_id(user_id, body)
    if user is None:
         return failure_response("User not found!")
    return success_response(user)

#delete user
@app.route('/users/<int:user_id>/', methods=['DELETE'])
def delete_user_by_id(user_id):
    body = json.loads(request.data)
    user = dao.delete_user_by_id(user_id, body)
    if user is None:
         return failure_response("User not found!")
    return success_response(user)

######################################################################################################
#Group

#get all groups
@app.route('/groups/', methods=['GET'])
def get_all_groups():
    return success_response(dao.get_all_groups())
#get group by id
@app.route('/groups/<int:group_id>/', methods=['GET'])
def get_group_by_id(group_id):
    group = dao.get_group_by_id(group_id)
    if group is None:
        return failure_response('Group not found!')
    return success_response(group)
#create group
@app.route('/groups/', methods=['POST'])
def create_group():
    body = json.loads(request.data)
    group = dao.create_group(
        name=body.get('name'),
        organizer=body.get('organizer_id')
    )
    return success_response(group)

#add user to group
@app.route('/groups/<int:group_id>/add/', methods=['POST'])
def add_user_to_group(user_id, group_id):
    group = Group.query.filter_by(id=group_id).first()
    if group is None:
        return failure_response('Group not found!')
    if user is None:
        return failure_response('User not found!')
    user = User.query.filter_by(id=user_id).first()
    group.users.append(user)
    db.session.commit()
    return channel.serialize()

#remove user from groups
@app.route('/groups/<int:group_id>/user/<int:user_id>/', methods=['DELETE'])
def remove_user_from_group(user_id, group_id):
    group = dao.remove_user_from_group(user_id, group_id)
    if group is None:
        return failure_response('Group not found!')
    if user is None:
        return failure_response('User not found!')
    return success_response(group)

#update group
@app.route('/groups/<int:group_id>/', methods=['POST'])
def update_group(group_id):
    body = json.loads(request.data)
    group = dao.update_group(group_id)
    if group is None:
        return failure_response('Group not found!')
    return success_response(group)

#delete group
@app.route('/groups/<int:group_id>/', methods=['DELETE'])
def delete_group_by_id(group_id):
    group = dao.delete_group(group_id)
    if group is None:
        return failure_response('Group not found!')
    return success_response(group)

######################################################################################################
#Activity

#get all activities
@app.route('/activities/', methods=['GET'])
def get_all_activities():
    return success_response(dao.get_all_activities())

#get activities by id
@app.route('/activities/<int:activity_id>/', methods=['GET'])
def get_activity_by_id(activity_id):
    activity = dao.get_activity_by_id(activity_id)
    if activity is None:
        return failure_response('Activity not found!')
    return success_response(activity)

#create activity
@app.route('/activities/', methods=['POST'])
def create_activity():
    body = json.loads(request.data)
    activity = dao.create_activity(
        name=body.get('name'),
        category=body.get('category'),
        timeofday=body.get('timeofday'),
        weather=body.get('weather'),
        minnumppl=body.get('minnumppl'),
        maxnumppl=body.get('maxnumppl'),
        location=body.get('location'),
        description=body.get('description')
    )
    return success_response(activity)

#update activity
@app.route('/activities/<int:activity_id>/', methods=['POST'])
def update_activity_by_id(activity_id):
    body = json.loads(request.data)
    activity = dao.update_activity(activity_id, body)
    if activity is None:
        return failure_response('Activity not found!')
    return success_response(activity)

#delete activity
@app.route('/activities/<int:activity_id>/', methods=['DELETE'])
def delete_activity_by_id(activity_id):
    activity = dao.delete_activity(activity_id)
    if activity is None:
        return failure_response('Activity not found!')
    return success_response(activity)

######################################################################################################
#Poll
#get all polls
@app.route('/poll1/', methods = ['GET'])
def get_all_poll1s():
    return success_response(dao.get_all_poll1s())
@app.route('/poll2/', methods=['GET'])
def get_all_poll2s():
    return success_response(dao.get_all_poll2s())

#get poll by id
@app.route('/poll1s/<int:poll1_id>/', methods=['GET'])
def get_poll1_by_id(poll1_id):
    poll1 = dao.get_poll1_by_id(poll1_id)
    if poll1 is None:
        return failure_response('Poll not found!')
    return success_response(poll1)
@app.route('/poll2s/<int:poll2_id>/', methods=['GET'])
def get_poll2_by_id(poll2_id):
    poll2 = dao.get_poll2_by_id(poll2_id)
    if poll2 is None:
        return failure_response('Poll not found!')
    return success_response(poll2)


#get polls in group
@app.route('/group/<int:group_id>/poll1s/', methods=['GET'])
def get_poll1s_in_group(group_id):
    poll1s = dao.get_poll1s_in_group(group_id)
    if group is None:
        return failure_response('Group not found!')
    return success_response(poll1s)
def get_poll2s_in_group(group_id):
    poll2s = dao.get_poll2s_in_group(group_id)
    if group is None:
        return failure_response('Group not found!')
    return success_response(poll2s)

#create polls
@app.route('/group/<int:group_id>/poll1s/', methods=['POST'])
def create_poll1(group_id):
    body = json.loads(request.data)
    poll1 = dao.create_poll1(
        eventdate=body.get('eventdate'),
        group=group_id,
    )
    return success_response(poll1)
@app.route('/group/<int:group_id>/poll2s/', methods=['POST'])
def create_poll2(group_id):
    body = json.loads(request.data)
    poll2 = dao.create_poll1(
        eventdate=body.get('eventdate'),
        group=group_id,
    )
    return success_response(poll1)

#update polls (when people vote)
@app.route('/group/<int:group_id>/poll1s/<int:poll1_id>/', methods=['POST'])
def update_poll1(group_id, poll1_id):
    body = json.loads(request.data)
    poll1 = dao.update_poll1(poll1_id,body)
    if poll1 is None:
        return failure_response('Poll not found!')
@app.route('/group/<int:group_id>/poll1s/<int:poll2_id>/', methods=['POST'])
def update_poll2(group_id, poll2_id):
    body = json.loads(request.data)
    poll2 = dao.update_poll2(poll2_id,body)
    if poll2 is None:
        return failure_response('Poll not found!')

######################################################################################################
#Event
#get all events
@app.route('/events/', methods=['GET'])
def get_all_events():
    return success_response(dao.get_all_events())

#get event by id
@app.route('/events/<int:event_id>/', methods=['GET'])
def get_event_by_id(event_id):
    event = dao.get_event_by_id(event_id)
    if event is None:
        return failure_response('Event not found!')
    return success_response(event)

#get events in group
@app.route('/group/<int:group_id>/events/', methods=['GET'])
def get_events_in_group(group_id):
    events = dao.get_events_in_group(group_id)
    if group is None:
        return failure_response('Group not found!')
    return success_response(events)

#create event
@app.route('/group/<int:group_id>/events/', methods=['POST'])
def create_event(group_id):
    body = json.loads(request.data)
    event = dao.create_event(
        name=body.get('name'),
        group=group_id,
        organizer=body.get('organizer_id'), #organizer is a user
        location=body.get('location'),
        time=body.get('time')
    )
    return success_response(event)

#delete event
@app.route('/events/<int:event_id>/', methods=['DELETE'])
def delete_event_by_id(event_id):
    event = dao.delete_event(event_id)
    if event is None:
        return failure_response('Event not found!')
    return success_response(event)





######################################################################################################
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
