import os
import csv

def read_data():
    data_folder = 'Data'
    tasks_file_path = os.path.join(data_folder, 'tasks.csv')
    notifications_file_path = os.path.join(data_folder, 'notification.csv')
    repeat_notification_rules_file_path = os.path.join(data_folder, 'repeatNotificationRules.csv')


    try:
        tasks_data = read_csv_file(tasks_file_path)
        notifications_data = read_csv_file(notifications_file_path)
        repeat_notification_rules_data = read_csv_file(repeat_notification_rules_file_path)

        combined_data = combine_data(tasks_data, notifications_data, repeat_notification_rules_data)
        return combined_data

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Pozostałe funkcje
def read_csv_file(file_path):
    with open(file_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        return list(reader)

def combine_data(tasks, notifications, repeat_notification_rules):
    combined_data = []

    for task in tasks:
        task_id = task['id']
        notification_id = task['notificationId']

        notification = next((n for n in notifications if n['notificationPK'] == notification_id), None)
        repeat_notification_rule = next((r for r in repeat_notification_rules if r['id'] == notification['repeatNotificationRuleId']), None)

        combined_object = {
            "id": task_id,
            "progress": task['progress'],
            "notificationId": notification_id,
            "title": task['title'],
            "description": task['description'],
            "priority": task['priority'],
            "startTime": task['startTime'],
            "endTime": task['endTime'],
            "notification": {
                "notificationPK": notification['notificationPK'],
                "taskFK": notification['taskFK'],
                "title": notification['title'],
                "description": notification['description'],
                "dateTime": notification['dateTime'],
                "repeatNotificationRule": {
                    "id": repeat_notification_rule['id'],
                    "notificationFK": repeat_notification_rule['notificationFK'],
                    "repeatType": repeat_notification_rule['repeatType'],
                    "repaitUntilDate": repeat_notification_rule['repaitUntilDate'],
                    "numberOfRepeats": repeat_notification_rule['numberOfRepeats']
                }
            }
        }

        combined_data.append(combined_object)

    return combined_data