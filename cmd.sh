#!/bin/bash
## Registering users
## API endpoint
#ApiUrl="http://127.0.0.1:3110/register"
#
## Array of user data (email, username, password)
#Users=(
#  "vaibhav@example.com,vaibhav,vaibhav123"
#  "harshita@example.com,harshita,harshita123"
#  "test@example.com,test,test123"
#  "divyansh@example.com,divyansh,divyansh123"
#  "kartik@example.com,kartik,kartik123"
#  "harsh@example.com,harsh,harsh123"
#  "shivani@example.com,shivani,shivani123"
#  "ashutosh@example.com,ashutosh,ashutosh123"
#)
#
## Loop through each user and send POST request
#for User in "${Users[@]}"
#do
#  IFS=',' read -r Email UserName Password <<< "$User"
#
#  echo "Registering: $UserName"
#
#  curl -s -X POST "$ApiUrl" \
#    -H "Content-Type: application/json" \
#    -d '{
#      "email": "'"$Email"'",
#      "username": "'"$UserName"'",
#      "password": "'"$Password"'"
#    }'
#
#  echo -e "\n"
#done

## Login command
#curl -X POST http://127.0.0.1:3110/login -H "Content-Type: application/json" -d '{"email":"test@example.com", "password":"test123"}'

# uploading blogs on 3 different pages
#
## API endpoint
#API_URL="http://127.0.0.1:3110/user/me/blogs"
#
## Access tokens
#TOKENS=(
#  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc1MDQxMTUwMSwianRpIjoiNTMyMzUwNzQtYWIxZi00OTg2LTkyZGItODQ3YWQ2MTliNzc4IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjMiLCJuYmYiOjE3NTA0MTE1MDEsImNzcmYiOiI4MTkxMWZkMi1kMTFmLTQ2MGYtODU5My05OTYxZDQwNWRhOGMiLCJleHAiOjE3NTA0MjIzMDF9.EmKfYvRxGtTNxjarbrmnSqEpfh7GukJusaV21AxHe1o"
#  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc1MDQxMTUwNSwianRpIjoiNmExNWY2OTAtYThlZC00MDg1LWJkNmQtNjk3NTU0Y2EwMzMzIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjIiLCJuYmYiOjE3NTA0MTE1MDUsImNzcmYiOiJlOThmZTYxYi01M2E4LTQwNjYtOTFiYS0wZTlhNDE4M2E0YWMiLCJleHAiOjE3NTA0MjIzMDV9.dQ81wzTVo9G3PG0VkP1ANkbTYTUMKZfh-2AHGYdE3cw"
#  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc1MDQxMTUxMCwianRpIjoiNTNjY2EyMzgtMmQyYS00NjkzLTllYzAtOTZhY2RkZjQxZjA5IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjEiLCJuYmYiOjE3NTA0MTE1MTAsImNzcmYiOiJiZDM0N2JjYi1hMDYyLTQzZTEtYjlkMy0wODE4ZDUyZTEyNjYiLCJleHAiOjE3NTA0MjIzMTB9.HrN_Zfzw6TXMKu6Fx6ubsnO-3Sy8sIEws2T21KRX1-0"
#)
#
## Dummy titles and content templates
#TITLES=(
#  "Post Title #"
#  "Learning Flask: Part #"
#  "Understanding APIs - Episode #"
#  "Python for Web Dev #"
#  "How to Build a Blog - Step #"
#)
#
#CONTENTS=(
#  "This is dummy blog post number #."
#  "We explore important concepts in Flask development, entry #."
#  "API structures, status codes, and auth techniques in blog #."
#  "Python-based server-side scripting made easy in entry #."
#  "Blogging platform implementation tips - post #."
#)
#
## Loop through tokens
#for i in "${!TOKENS[@]}"; do
#  TOKEN="${TOKENS[$i]}"
#  echo "Using Token [$((i + 1))]..."
#
#  # Upload 5 posts for each token
#  for j in {1..5}; do
#    IDX=$((j + i * 5))
#
#    TITLE=$(echo "${TITLES[$((j - 1))]}" | sed "s/#/$IDX/")
#    CONTENT=$(echo "${CONTENTS[$((j - 1))]}" | sed "s/#/$IDX/")
#    IMAGE_URL="https://example.com/image${IDX}.png"
#
#    # POST request
#    curl -s -X POST "$API_URL" \
#      -H "Content-Type: application/json" \
#      -H "Authorization: $TOKEN" \
#      -d "{
#        \"title\": \"$TITLE\",
#        \"content\": \"$CONTENT\",
#        \"imageUrl\": \"$IMAGE_URL\"
#      }" | jq .
#
#    echo "Uploaded: $TITLE"
#  done
#
#  echo "---"
#done
#
#echo "Finished uploading 15 dummy blog posts."
#

## Checking all the post by userId:1
#curl -X GET http://127.0.0.1:3110/user/1/blogs -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc1MDQxMTUwNSwianRpIjoiNmExNWY2OTAtYThlZC00MDg1LWJkNmQtNjk3NTU0Y2EwMzMzIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjIiLCJuYmYiOjE3NTA0MTE1MDUsImNzcmYiOiJlOThmZTYxYi01M2E4LTQwNjYtOTFiYS0wZTlhNDE4M2E0YWMiLCJleHAiOjE3NTA0MjIzMDV9.dQ81wzTVo9G3PG0VkP1ANkbTYTUMKZfh-2AHGYdE3cw"

## Checking my all post
#curl -X GET http://127.0.0.1:3110/user/me/blogs -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc1MDQxMTUwNSwianRpIjoiNmExNWY2OTAtYThlZC00MDg1LWJkNmQtNjk3NTU0Y2EwMzMzIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjIiLCJuYmYiOjE3NTA0MTE1MDUsImNzcmYiOiJlOThmZTYxYi01M2E4LTQwNjYtOTFiYS0wZTlhNDE4M2E0YWMiLCJleHAiOjE3NTA0MjIzMDV9.dQ81wzTVo9G3PG0VkP1ANkbTYTUMKZfh-2AHGYdE3cw"

