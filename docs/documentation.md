# Documentation
## Domain
The domain diagram can [be found here on LucidChart](https://lucid.app/lucidchart/d0f499f4-6105-4c5e-97a9-3d72a4099107/edit?viewport_loc=-619%2C-1228%2C2562%2C1205%2C0_0&invitationId=inv_2760fcb3-4293-4911-87d6-4fe0d27c294f). 

## Statistics Endpoints

### GET `/statistics/{user_id}`
- **Function**: Fetches statistics data for a given user.
- **Parameters**:
  - `user_id` (Path): User's ID.
  - `date` (Query, Optional): Date in ISO format (YYYY-MM-DD).
- **Response**: Details of user statistics.
- **Example**:
  ```json
  GET /statistics/123?date=2024-01-01
  ```

## Task Endpoints

### GET `/tasks/{user_id}/{task_id}`
- **Function**: Retrieves a specific task by ID for a user.
- **Parameters**:
  - `user_id` (Path): User's ID.
  - `task_id` (Path): Task's ID.
- **Response**: Details of the specified task.
- **Example**:
  ```json
  GET /tasks/123/456
  ```

### GET `/tasks/{user_id}`
- **Function**: Fetches tasks for a user.
- **Parameters**:
  - `user_id` (Path): User's ID.
  - `title` (Query, Optional): Title of the task.
  - `description` (Query, Optional): Description of the task.
  - `priority` (Query, Optional): Task's priority.
  - `is_done` (Query, Optional): Completion status.
- **Response**: List of tasks.
- **Example**:
  ```json
  GET /tasks/123?title=Meeting&is_done=true
  ```

## User Endpoints

### POST `/users/`
- **Function**: Creates a new user.
- **Parameters**:
  - `UserDTO` (Body): User information.
- **Response**: Details of the created user.
- **Status Code**: HTTP 201 (Created).
- **Example**:
  ```json
  POST /users/
  {
      "username": "johndoe",
      "email": "johndoe@example.com"
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
