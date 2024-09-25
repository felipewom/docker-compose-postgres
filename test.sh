
IP_ADDRESS=127.0.0.1
PORT=18080
echo "create"
curl --request POST \
--url http://$IP_ADDRESS:$PORT/v1/rdbms/db/employee \
--header 'Content-Type: application/json' \
--header 'User-Agent: insomnia/8.6.1' \
--data '{
"first_name" : "Salman",
"last_name" : "Khan",
"email" : "sk@skfilms.com",
"created_on" : "2015-04-14T11:07:36.639Z"
}'

echo "List"

curl --request GET \
--url http://$IP_ADDRESS:$PORT/v1/rdbms/db/employee \
--header 'User-Agent: insomnia/8.6.1'


