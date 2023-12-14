from fastapi import FastAPI, HTTPException

import csv
import os

# Funkcje do obsługi plików CSV
def read_csv_file(file_path):
    try:
        with open(file_path, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            return list(reader)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error reading CSV file: {str(e)}")

def write_csv_file(file_path, data):
    try:
        fieldnames = data[0].keys() if data else []
        with open(file_path, mode='w', newline='', encoding='utf-8') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(data)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error writing CSV file: {str(e)}")

# Funkcja do dodawania nowego tasku
def add_task(request_data):
    data_folder = 'Data'
    tasks_file_path = os.path.join(data_folder, 'tasks.csv')
    notifications_file_path = os.path.join(data_folder, 'notification.csv')
    repeat_notification_rules_file_path = os.path.join(data_folder, 'repeatNotificationRules.csv')

    # Wczytaj istniejące dane
    tasks_data = read_csv_file(tasks_file_path)
    notifications_data = read_csv_file(notifications_file_path)
    repeat_notification_rules_data = read_csv_file(repeat_notification_rules_file_path)

    # Nowe dane z żądania
    new_task = request_data
    new_notification = new_task.pop("notification", {})
    new_repeat_notification_rule = new_notification.pop("repeatNotificationRule", {})

    # Sprawdź obecność kluczowych pól
    if not all(new_task.get(key) for key in ["id", "progress", "notificationId", "title", "description", "priority"]):
        raise HTTPException(status_code=400, detail="Niektóre kluczowe pola są puste w obiekcie zadania.")

    if not all(new_notification.get(key) for key in ["notificationPK", "taskFK", "title", "description", "dateTime"]):
        raise HTTPException(status_code=400, detail="Niektóre kluczowe pola są puste w obiekcie powiadomienia.")

    if not new_repeat_notification_rule.get("id"):
        raise HTTPException(status_code=400, detail="Pole 'id' jest puste w obiekcie reguły powtórzenia powiadomienia.")

    # Dodaj nowe dane do istniejących
    tasks_data.append({
        "id": new_task["id"],
        "progress": new_task["progress"],
        "notificationId": new_task["notificationId"],
        "title": new_task["title"],
        "description": new_task["description"],
        "priority": new_task["priority"],
        "startTime": new_task.get("startTime"),
        "endTime": new_task.get("endTime"),
        "notificationTitle": new_notification.get("title"),
        "notificationDescription": new_notification.get("description"),
        "notificationDateTime": new_notification.get("dateTime"),
        "notificationNotificationPK": new_notification.get("notificationPK"),
        "notificationTaskFK": new_notification.get("taskFK"),
        "notificationRepeatNotificationRuleId": new_repeat_notification_rule.get("id"),
        "notificationRepeatType": new_repeat_notification_rule.get("repeatType"),
        "notificationRepaitUntilDate": new_repeat_notification_rule.get("repaitUntilDate"),
        "notificationNumberOfRepeats": new_repeat_notification_rule.get("numberOfRepeats"),
    })

    notifications_data.append({
        "notificationPK": new_notification["notificationPK"],
        "taskFK": new_notification["taskFK"],
        "title": new_notification["title"],
        "description": new_notification["description"],
        "dateTime": new_notification["dateTime"],
        "repeatNotificationRuleId": new_repeat_notification_rule["id"],
        "repeatType": new_repeat_notification_rule.get("repeatType"),
        "repaitUntilDate": new_repeat_notification_rule.get("repaitUntilDate"),
        "numberOfRepeats": new_repeat_notification_rule.get("numberOfRepeats"),
    })

    repeat_notification_rules_data.append({
        "id": new_repeat_notification_rule["id"],
        "notificationFK": new_notification["notificationPK"],
        "repeatType": new_repeat_notification_rule.get("repeatType"),
        "repaitUntilDate": new_repeat_notification_rule.get("repaitUntilDate"),
        "numberOfRepeats": new_repeat_notification_rule.get("numberOfRepeats"),
    })

    # Zapisz zmienione dane z powrotem do plików CSV
    write_csv_file(tasks_file_path, tasks_data)
    write_csv_file(notifications_file_path, notifications_data)
    write_csv_file(repeat_notification_rules_file_path, repeat_notification_rules_data)
