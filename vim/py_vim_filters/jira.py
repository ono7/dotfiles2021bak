#!/usr/bin/env python3

# base_url = https://jira.xyz.com/rest

from dcnm.jira.jira_calls import *
from dcnm.jira.jira_session import JiraManager
import yaml
import sys

# load using this_file.py yaml_file.yml
# vim:  !jira %
with open(sys.argv[1]) as f:
    from_yaml = yaml.safe_load(f)


# side-load jira info
with open("~/.xzy") as f:
    jira_info = yaml.safe_load(f)


def jira_update_ticket(connection_obj, ticket_name, desired_state, assignee, comment):
    """update_ticket ('story') in jira in an automated fashion.  This should be used
       in the future to help streamline builds or automations.

       Args:
        connection_obj (object) used for session managment to use API

       Returns:
        successful or failed
    """
    transition_dict = {"open": "11", "in progress": "21", "close": "31"}
    transition_url = f"/api/2/issue/{ticket_name}/transitions?expand=transitions.fields"
    update_url = f"/api/2/issue/{ticket_name}"
    trans_data = {"transition": {"id": transition_dict[f"{desired_state}"]}}
    transition = connection_obj.post(transition_url, data=json.dumps(trans_data))
    if transition.ok:
        data = {
            "update": {"comment": [{"add": {"body": f"{comment}"}}]},
            "fields": {"assignee": {"name": f"{assignee}"}},
        }
        resp = connection_obj.put(update_url, data=json.dumps(data))
        if resp.ok:
            return "Successfully Updated Ticket"
        else:
            return "Updating ticket failed"
    else:
        return "Transitioning ticket state failed"


def jira_create_ticket(
    connection_obj, summary, priority, description, label, component
):
    """create_ticket ('story') in jira in an automated fashion.  This should be used
       in the future to help streamline builds or automations.

       Args:
        connection_obj (object) used for session managment to use API

       Returns:
        successful or failed
    """
    priority_dict = {
        "Highest": "1",
        "High": "2",
        "Medium": "3",
        "Low": "4",
        "Lowest": "5",
    }
    ct_url = "/api/2/issue/"
    data = {
        "fields": {
            "project": {"key": "ENS"},
            "summary": f"{summary}",
            "priority": {"id": priority_dict[f"{priority}"]},
            "description": f"{description}",
            "issuetype": {"id": "10001"},
            "labels": [f"{label}"],
            "assignee": {"name": f"{assignee}"},
            "components": [{"name": f"{component}"}],
        }
    }
    resp = connection_obj.post(ct_url, data=json.dumps(data))
    if resp.ok:
        return f"{resp.json()['key']}"
    else:
        return f"Failed to Create Ticket {resp.status_code}"


user = jira_info["user"]
password = jira_info["password"]
base_url = jira_info["base_url"]
session = JiraManager(base_url, user, password)

summary = from_yaml["summary"]
priority = from_yaml["priority"]
description = from_yaml["description"]
label = from_yaml["label"]
assignee = from_yaml["assignee"]
# Network Automation, Network Consultation
component = from_yaml["component"]
state = from_yaml["state"]

if from_yaml["jira_number"]:
    comment = from_yaml["comment"]
    ticket_state = from_yaml["state"]
    jira_number = from_yaml["jira_number"]
    update = jira_update_ticket(session, jira_number, ticket_state, assignee, comment)
    print(update)
else:
    ticket = jira_create_ticket(
        session, summary, priority, description, label, component
    )
    print(ticket)
