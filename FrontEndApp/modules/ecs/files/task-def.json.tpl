[
    {
      "name": "ui",
      "image": "${image_name}",
      "cpu": 0,
      "memory": ${memory},
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000
        }
      ],
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-region": "us-east-1",
            "awslogs-group": "/ecs/",
            "awslogs-stream-prefix": "ecs"
          }
        }
      }
    ]
