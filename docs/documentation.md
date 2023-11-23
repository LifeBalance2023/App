# Documentation
## Domain
The domain diagram can [be found here on LucidChart](https://lucid.app/lucidchart/d0f499f4-6105-4c5e-97a9-3d72a4099107/edit?viewport_loc=-619%2C-1228%2C2562%2C1205%2C0_0&invitationId=inv_2760fcb3-4293-4911-87d6-4fe0d27c294f). 

## API

**Tasks:**

- `GET /tasks` - Get all tasks for the authenticated user.
    - Response
    
    ```json
    [
      {
        "id": "task1",
        "title": "Task One",
        "description": "This is the first task",
        "priority": "HIGH",
        "progress": "IN_PROGRESS",
        "startTime": "2023-11-15T09:00:00Z",
        "endTime": null,
    		"notificationId": "notification1"
      },
      {
        "id": "task2",
        "title": "Task Two",
        "description": "This is the second task",
        "priority": "MEDIUM",
        "progress": "NOT_STARTED",
        "startTime": null,
        "endTime": null,
    		"notificationId": "notification2"
      }
    ]
    ```
    
- `POST /tasks` - Create a new task for the authenticated user.
    - Request
    
    ```json
    {
      "title": "New Task",
      "description": "Details of the new task",
      "priority": "LOW",
      "startTime": "2023-11-16T10:00:00Z",
      "endTime": "2023-11-16T15:00:00Z",
    	"notification":
        {
          "title": "Task Reminder",
          "description": "Don't forget to start your task",
          "dateTime": "2023-11-20T07:45:00Z",
          "repeatNotificationRule": {
            "repeatType": "WEEKLY",
    				"repaitUntilDate": "2023-11-16T10:00:00Z",
    				"numberOfRepeats": 3
          }
        }
    }
    ```
    
- `PUT /tasks/{taskId}` - Update a specific task.
    - Request
    
    ```json
    {
      "id": "task123", // Task ID
      "title": "Updated Task",
      "description": "Updated details about the task",
      "priority": "MEDIUM",
      "startTime": "2023-11-20T09:00:00Z",
      "endTime": "2023-11-20T18:00:00Z",
      "notification":
        {
          "id": "notif123", // Existing notification ID
          "title": "Updated Reminder",
          "description": "Reminder to work on the task",
          "dateTime": "2023-11-20T08:45:00Z",
          "repeatNotificationRule": {
            "id": "rule123", // Existing rule ID
            "repeatType": "WEEKLY"
          }
        }
    }
    ```
    
- `DELETE /tasks/{taskId}` - Delete a specific task.
- `PATCH /tasks/{taskId}/progress` - Update the progress of a task.
    - Request
    
    ```json
    {
    		"progress": "IN_PROGRESS"
    }
    ```
    

**Notifications:**

- `GET /notifications` - Get all notifications.
    - Response
    
    ```json
    [
      {
        "id": "notif1",
        "title": "Reminder",
        "description": "Reminder to start the task",
        "dateTime": "2023-11-16T09:00:00Z",
        "repeatNotificationRule": null
      },
      {
        "id": "notif2",
        "title": "Deadline",
        "description": "Task deadline approaching",
        "dateTime": "2023-11-16T14:00:00Z",
        "repeatNotificationRule": {
          "repeatType": "DAILY",
          "repeatUntilDate": "2023-11-20T14:00:00Z",
          "numberOfRepeats": null
        }
      },
      // ... more notifications
    ]
    ```
    
- `DELETE /notifications/{notificationId}` - Delete a specific notification.

**Statistics:**

- `GET /statistics` - Get statistics for the authenticated user.
    - Response
    
    ```json
    {
      "amountOfFinishedTasks": 10,
      "amountOfStartedTasks": 5,
      "amountOfToDo": 15,
      "amountOfAllTasks": 30,
      "balancePercentage": 50
    }
    ```
    
- `GET /statistics/{date}` - Get statistics for the authenticated user for a specific date.

```json
{
  "dateTime": "2023-11-21T12:00:00Z",
  "amountOfFinishedTasks": 10,
  "amountOfStartedTasks": 5,
  "amountOfToDo": 15,
  "amountOfAllTasks": 30,
  "balancePercentage": 50
}
```