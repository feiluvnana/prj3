## API SPECIFICATION

1. Login
    - Endpoint: `student/login`
    - Method: `POST`
    - Authorization: `none`
    - Body: 
    ```
    {
        email: String,
        password: String
    }
    ```
    - Headers: 
    ```
    {
        Content-Type: application/json
    }
    ```
    - Response:
    ```
    {
        code: String,
        message: String,
        data: {
            token: String,
            expiredAt: Number
        }
    }
    ```
2. 

