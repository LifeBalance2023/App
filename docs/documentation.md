# Documentation
## Domain
The domain diagram can [be found here on LucidChart](https://lucid.app/lucidchart/d0f499f4-6105-4c5e-97a9-3d72a4099107/edit?viewport_loc=-619%2C-1228%2C2562%2C1205%2C0_0&invitationId=inv_2760fcb3-4293-4911-87d6-4fe0d27c294f). 

## Statistics Endpoints

- `GET /statistics/{user_id}` - Get statistics for the authenticated user for a specific date.
    - Request

    ```json
    {
      "date": "2022-12-23"
    }
    ```

    - Response
    
    ```json
    {
      "date": "2022-12-23",
      "lifeBalanceValue": 100,
      "finishedTasks": 5,
      "toDo": 0,
      "allTasks": 5
    }
    ```
    
- `GET /statistics/{user_id}` - Get statistics for the authenticated user.

  ```json
  {
      "progress": 50,
      "finishedTasks": 3,
      "toDo": 2,
      "allTasks": 5
    }
  ```

## Task Endpoints

- `GET /tasks/{userId}` - Get all tasks for the authenticated user.
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
          "userId": "u1",
          "title": "Test task",
          "description": "This is the test task",
          "priority": "LOW",
          "isDone": true,
          "date": "2022-12-23",
          "notificationTime": "10:23:45"
        },
        {
          "id": "xxxxxxxxxxxxxxxxxxxx",
          "userId": "u1",
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
    
- `POST /tasks/{userId}` - Create a new task for the authenticated user.
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
      "userId": "u1",
      "title": "Task Two",
      "description": "This is the second task",
      "priority": "MEDIUM",
      "isDone": false,
      "date": "2023-11-15",
      "notificationTime": "10:00:00"
    }
    ``
    
- `PATCH /tasks/{userId}/{taskId}` - Update a specific task.
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
      "userId": "u1",
      "title": "new task",
      "description": "This is the new task", 
      "priority": "HIGH",
      "isDone": true,
      "date": "2022-12-23",
      "notificationTime": "12:04:32"
    }
    ```
    
    
- `DELETE /tasks/{userId}/{taskId}` - Delete a specific task.
    - Response:

    ```json
    {
      "id": "xxxxxxxxxxxxxxxxxxxx",
      "userId": "u1",
      "title": "Updated task2",
      "description": "This is the Updated task",
      "priority": "HIGH",
      "isDone": true,
      "date": "2022-12-23",
      "notificationTime": "12:04:32"
    }
    ```

## User Endpoints

- `POST /users` - Add new user
  - Request
  ```json
  {
    "email": "dupa@google.com",
    "userId": "u1",
  }
  ```

## Models

### Statistics Models
- **StatisticsBase**:
  - `finishedTasks` (int): Number of finished tasks.
  - `toDo` (int): Number of tasks to do.
  - `allTasks` (int): Total number of tasks.

- **StatisticsDaily** (inherits StatisticsBase):
  - `date` (date): Date of the statistics.
  - `lifeBalanceValue` (int): Life balance value for the day.

- **StatisticsTotal** (inherits StatisticsBase):
  - `progress` (int): Overall progress value.

- **StatisticRequest**:
  - `date` (Optional[date]): Date for requesting specific day's statistics.

### Task Models
- **Task**:
  - `id` (str): Task's unique identifier.
  - `userId` (str): User's ID associated with the task.
  - `title` (str): Task title.
  - `description` (str): Task description.
  - `priority` (str): Task priority.
  - `isDone` (bool): Task completion status.
  - `date` (date): Task date.
  - `notificationTime` (Optional[datetime]): Notification time.

- **TaskDTO**:
  - `title` (str): Task title.
  - `description` (str): Task description.
  - `priority` (str): Task priority.
  - `isDone` (bool): Task completion status.
  - `date` (date): Task date.
  - `notificationTime` (Optional[datetime]): Notification time.

### User Models
- **User**:
  - `id` (str): User's unique identifier.
  - `email` (str): User's email address.

- **UserDTO**:
  - `id` (str): User's unique identifier.
  - `email` (str): User's email address.
