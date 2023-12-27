# Documentation
## Domain
The domain diagram can [be found here on LucidChart](https://lucid.app/lucidchart/d0f499f4-6105-4c5e-97a9-3d72a4099107/edit?viewport_loc=-619%2C-1228%2C2562%2C1205%2C0_0&invitationId=inv_2760fcb3-4293-4911-87d6-4fe0d27c294f). 

## API

All request should have in URL `stationId` param encoded with Base64.

**Tasks:**

- `GET /tasks` - Get all tasks for the authenticated user.
    - Request

    ```json
    {
      "title": "Updated task2", // optional
      "description": "This is the Updated task", // optional
      "priority": "HIGH", // optional
      "isDone": true, // optional
      "date": "2022-12-23", // optional
      "notificationTime": "12:04:32" // optional
    }
    ```

    - Response
    
    ```json
    {
      "tasks": [
        {
          "id": "xxxxxxxxxxxxxxxxxxxx",
          "title": "Test task",
          "description": "This is the test task",
          "priority": "LOW",
          "isDone": true,
          "date": "2022-12-23",
          "notificationTime": "10:23:45"
        },
        {
          "id": "xxxxxxxxxxxxxxxxxxxx",
          "title": "Test task 2",
          "description": "This is the test task2",
          "priority": "MEDIUM",
          "isDone": true,
          "date": "2022-12-23",
          "notificationTime": null
        }
      ]
    }
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
    
   - Response

   ```json
    {
      "id": "xxxxxxxxxxxxxxxxxxxx",
      "title": "Task Two",
      "description": "This is the second task",
      "priority": "MEDIUM",
      "isDone": False,
      "date": "2023-11-15",
      "notificationTime": "10:00:00"
    }
    ``
    
- `PATCH /tasks/{taskId}` - Update a specific task.
    - Request

    ```json
    {
      "title": "new task",
      "description": "This is the new task",
      "priority": "HIGH",
      "isDone": true,
      "date": "2022-12-23",
      "notificationTime": "12:04:32" // optional
    }
    ```

    - Response
    
    ```json
    {
      "id": "xxxxxxxxxxxxxxxxxxxx",
      "title": "new task",
      "description": "This is the new task", 
      "priority": "HIGH",
      "isDone": true,
      "date": "2022-12-23",
      "notificationTime": "12:04:32"
    }
    ```
    
- `PATCH /tasks/{taskId}` - Update a specific task.
    - Request

    ```json
    {
      "title": "Updated task2", // optional
      "description": "This is the Updated task", // optional
      "priority": "HIGH", // optional
      "isDone": true, // optional
      "date": "2022-12-23", // optional
      "notificationTime": "12:04:32" // optional
    }
    ```

    - Response
    
    ```json
    {
      "id": "xxxxxxxxxxxxxxxxxxxx",
      "title": "Updated task2",
      "description": "This is the Updated task",
      "priority": "HIGH",
      "isDone": true,
      "date": "2022-12-23",
      "notificationTime": "12:04:32"
    }
    ```
    
- `DELETE /tasks/{taskId}` - Delete a specific task.
    - Response:

    ```json
    {
      "id": "xxxxxxxxxxxxxxxxxxxx",
      "title": "Updated task2",
      "description": "This is the Updated task",
      "priority": "HIGH",
      "isDone": true,
      "date": "2022-12-23",
      "notificationTime": "12:04:32"
    }
    ```
    
**Statistics:**

- `GET /statistics` - Get statistics for the authenticated user for a specific date.
    - Request

    ```json
    {
      "Date": "2022-12-23"
    }
    ```

    - Response
    
    ```json
    {
      "Date": "2022-12-23",
      "LifeBalanceValue": 100,
      "Progress": null,
      "FinishedTasks": 5,
      "ToDo": 0,
      "AllTasks": 5
    }
    ```
    
- `GET /statistics` - Get statistics for the authenticated user.

  ```json
  {
      "Date": null,
      "LifeBalanceValue": null,
      "Progress": 50,
      "FinishedTasks": 3,
      "ToDo": 2,
      "AllTasks": 5
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