# Documentation
## Domain
The domain diagram can [be found here on LucidChart](https://lucid.app/lucidchart/d0f499f4-6105-4c5e-97a9-3d72a4099107/edit?viewport_loc=-619%2C-1228%2C2562%2C1205%2C0_0&invitationId=inv_2760fcb3-4293-4911-87d6-4fe0d27c294f). 

## API

All request should have in URL `stationId` param encoded with Base64.

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
        "isDone": true,
        "date": "2023-11-15",
    		"notificationTime": "10:00:00"
      },
      {
        "id": "task2",
        "title": "Task Two",
        "description": "This is the second task",
        "isDone": false,
        "priority": "MEDIUM",
        "date": "2023-11-15",
      }
    ]
    ```
    
- `POST /tasks` - Create a new task for the authenticated user.
    - Request
    
    ```json
    {
      "title": "Task Two",
      "description": "This is the second task",
      "priority": "MEDIUM",
      "date": "2023-11-15",
      "notificationTime": "10:00:00" // optional
    }
    ```
    
- `PATCH /tasks/{taskId}` - Update a specific task.
    - Request
    
    ```json
    {
      "title": "Updated Task",
      "description": "Updated details about the task",
      "isDone": false,
      "priority": "MEDIUM",
      "date": "2023-11-15",
      "notificationTime": "10:00:00"
    }
    ```
    
- `DELETE /tasks/{taskId}` - Delete a specific task.
    
**Statistics:**

- `GET /statistics` - Get statistics for the authenticated user.
    - Response
    
    ```json
    {
      "amountOfToDo": 15,
      "amountOfDone": 15,
      "amountOfAllTasks": 30,
      "progress": 50 // amountOfDone / amountOfAllTasks
    }
    ```
    
- `GET /statistics/{date}` - Get statistics for the authenticated user for a specific date.

```json
{
  "dateTime": "2023-11-21",
  "amountOfToDo": 15,
  "amountOfDone": 15,
  "amountOfAllTasks": 30,
  "lifeBalanceValue": 45 // weighted average of all tasks (%)
}
```

**Authentication:**

- `POST /users` - Add new user
  - Request
  ```json
  {
    "email": "dupa@google.com",
    "userId": "unique user id",
  }
  ```