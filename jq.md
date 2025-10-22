### References:-
- https://www.digitalocean.com/community/tutorials/how-to-transform-json-data-with-jq
- https://www.baeldung.com/linux/jq-command-json
- https://freedium-mirror.cfd/https://medium.com/@learntheshell/guide-to-jq-command-d75176fc4303
- https://medium.com/@buczynski.rafal/exploring-jq-a-guide-to-essential-techniques-and-tools-for-professionals-b9df9db490de

* Handling big JSON files manually is slow and error-prone, and while tools like sed, awk, and grep can help, they aren’t ideal for structured JSON data.
* jq is a command-line tool designed specifically for parsing, filtering, and transforming JSON data. It’s valuable for shell scripts, AI workflows, and DevOps pipelines.
* Extracting information from API responses (e.g., using curl with jq)
* Processing Kubernetes kubectl JSON output
* Integrating into data engineering and DevOps workflows
* Written in C, jq is optimized for speed and can handle very large JSON files (multi-gigabyte) efficiently with streaming and memory optimization.
```bash
jq --version
sudo apt update && sudo apt install jq
brew install jq

```
* `vim seaCreatures.json`
```json
[
    { "name": "Sammy", "type": "shark", "clams": 5 },
    { "name": "Bubbles", "type": "orca", "clams": 3 },
    { "name": "Splish", "type": "dolphin", "clams": 2 },
    { "name": "Splash", "type": "dolphin", "clams": 2 }
]

{
"url": "https://example.com",
"name": "example"
}
jq '.url' file.json
"https://example.com"


{
"committer": {
"login": "user123",
"id": 1
}
}
jq '.committer.login' file.json
"user123"

jq '.committer.login, .committer.type, .committer.url' file.json
"user123"
"User"
"https://api.example.com/user123"

jq '{login: .committer.login, type: .committer.type, url: .committer.url}' file.json
{
"login": "user123",
"type": "User",
"url": "https://api.example.com/user123"
}

[
{"name": "Alice", "age": 30},
{"name": "Bob", "age": 25}
]
jq '.[]' file.json
{"name": "Alice", "age": 30}
{"name": "Bob", "age": 25}

jq '.[0]' file.json
{"name": "Alice", "age": 30}

jq '.[].name' file.json
"Alice"
"Bob"

echo '[1,2,3,4,5,6,7,8,9,10]' | jq '.[-3]'

[1, 2, 3, 4, 5]
jq 'length' file.json
5

{
"name": "Alice",
"age": 30
}
jq 'keys' file.json
["age", "name"]

[
{"item": "A", "price": 30},
{"item": "B", "price": 20}
]
jq '[.[].price] | min' file.json
20

jq '[.[].price] | max' file.json
30

[
{"name": "Alice", "Verified": true},
{"name": "Bob", "Verified": false}
]
jq 'select(.Verified == true)' file.json
{"name": "Alice", "Verified": true}

[
{"status_code": 200, "content_type": "application/json"},
{"status_code": 404, "content_type": "text/html"}
]
jq 'select((.status_code == 200) and (.content_type == "application/json"))' file.json
{"status_code": 200, "content_type": "application/json"}

[
{"commit": {"message": "Initial commit", "committer": {"name": "Alice"}}},
{"commit": {"message": "Added new feature", "committer": {"name": "Bob"}}}
]
jq '.[] | {message: .commit.message, name: .commit.committer.name}' file.json
{"message": "Initial commit", "name": "Alice"}
{"message": "Added new feature", "name": "Bob"}

[
{"message": "Initial commit", "name": "Alice"},
{"message": "Added new feature", "name": "Bob"}
]
jq '[.[] | {message: .commit.message, name: .commit.committer.name}]' file.json

{"name": "Alice"}
{"name": "Bob"}
jq -s '.' input.jsonl > output.json
[
{"name": "Alice"},
{"name": "Bob"}
]

[
{"name": "Alice"},
{"name": "Bob"}
]
jq -c '.[]' input.json > output.jsonl
{"name": "Alice"}
{"name": "Bob"}
```
```bash
ubuntu:~$ jq '.' seaCreatures.json #Pretty print the JSON file (identity operator)
[
  {
    "name": "Sammy",
    "type": "shark",
    "clams": 5
  },
  {
    "name": "Bubbles",
    "type": "orca",
    "clams": 3
  },
  {
    "name": "Splish",
    "type": "dolphin",
    "clams": 2
  },
  {
    "name": "Splash",
    "type": "dolphin",
    "clams": 2
  }
]

controlplane:~$ echo '{"fruit":{"name":"apple","color":"green","price":1.20}}' | jq '.'
{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.20
  }
}

controlplane:~$ curl http://api.open-notify.org/iss-now.json | jq '.'
{
  "iss_position": {
    "latitude": "-1.7094",
    "longitude": "-114.2069"
  },
  "message": "success",
  "timestamp": 1761119722
}

controlplane:~$ curl http://api.open-notify.org/iss-now.json | jq '.message'
"success"

controlplane:~$ curl http://api.open-notify.org/iss-now.json | jq '.iss_position.latitude'
"2.9863"

controlplane:~$ curl http://api.open-notify.org/iss-now.json | jq '.iss_position.latitude,.iss_position.longitude'
"6.0523"
"-108.6834"

docker inspect nginx | jq
docker inspect nginx | jq '.'

controlplane:~$ echo '["x","y","z"]' | jq '.[]'
"x"
"y"
"z"

controlplane:~$ echo '["x","y","z"]' | jq '.'  
[
  "x",
  "y",
  "z"
]

controlplane:~$ echo '[
  { "name": "apple", "color": "green", "price": 1.2 },
  { "name": "banana", "color": "yellow", "price": 0.5 },
  { "name": "kiwi", "color": "green", "price": 1.25 }
]' | jq '.[] | .name'

"apple"
"banana"
"kiwi"

controlplane:~$ echo '[
  { "name": "apple", "color": "green", "price": 1.2 },
  { "name": "banana", "color": "yellow", "price": 0.5 },
  { "name": "kiwi", "color": "green", "price": 1.25 }
]' | jq '.[1] | .name'
"banana"

controlplane:~$ echo '[
  { "name": "apple", "color": "green", "price": 1.2 },
  { "name": "banana", "color": "yellow", "price": 0.5 },
  { "name": "kiwi", "color": "green", "price": 1.25 }
]' | jq '.[1] | .price'
0.5

controlplane:~$ echo '[1,2,3,4,5,6,7,8,9,10]' | jq '.[6:9]'
[
  7,
  8,
  9
]
controlplane:~$ echo '[1,2,3,4,5,6,7,8,9,10]' | jq '.[:6]' | jq '.[-2:]'
[
  5,
  6
]

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.fruit | keys'
[
  "color",
  "name",
  "price"
]
controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.fruit '      
{
  "name": "apple",
  "color": "green",
  "price": 1.2
}

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.fruit | length'
3

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.fruit.name'
"apple"
controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.fruit.name | length'
5

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq 'map(has("name"))'    
[
  true
] #we’re applying the has function to each item in the array and looking to see if there is a name property. In our simple fruits JSON, we get true in each result item.

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq 'map(.price+2)'   
[
  3.2
]

#If we need to find the minimum or maximum element of an input array, we can utilize the min and max functions:
controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '[.[].price] | min'
[
  1.2
]

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '[.[].price] | max'
1.2

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.[] | select(.price>0.5)'
{
  "name": "apple",
  "color": "green",
  "price": 1.2
}
#This selects all the fruit with a price greater than 0.5.

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.[] | select(.color=="yellow")'

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.[] | select(.color=="yellow" and .price>=0.5)'

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.[] | to_entries[] | select(.key | startswith("name")) | .value'
"apple"

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq '.[] | select(.name|test("^a.")) | .price'                       
1.2 #regular expression

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq 'map(.color) | unique'                    
[
  "green"
]

controlplane:~$ echo '{
  "fruit": {
    "name": "apple",
    "color": "green",
    "price": 1.2
  }
}' | jq 'del(.fruit.name)'    
{
  "fruit": {
    "color": "green",
    "price": 1.2
  }
}

echo '{
  "query": {
    "pages": [
      {
        "21721040": {
          "pageid": 21721040,
          "ns": 0,
          "title": "Stack Overflow",
          "extract": "Some interesting text about Stack Overflow"
        }
      },
      {
        "21721041": {
          "pageid": 21721041,
          "ns": 0,
          "title": "Baeldung",
          "extract": "A great place to learn about Java"
        }
      }
    ]
  }
}' | jq '.'


controlplane:~$ echo '{
  "query": {
    "pages": [
      {"21721040": {"pageid": 21721040,"ns":0,"title":"Stack Overflow","extract":"Some interesting text about Stack Overflow"}},
      {"21721041": {"pageid": 21721041,"ns":0,"title":"Baeldung","extract":"A great place to learn about Java"}}
    ]
  }
}' | jq '.query.pages[] | .[] | .title'
"Stack Overflow"
"Baeldung"

echo '{
  "query": {
    "pages": [
      {"21721040": {"pageid": 21721040,"ns":0,"title":"Stack Overflow","extract":"Some interesting text about Stack Overflow"}},
      {"21721041": {"pageid": 21721041,"ns":0,"title":"Baeldung","extract":"A great place to learn about Java"}}
    ]
  }
}' | jq '.query.pages[] | .[] | .extract'

echo '{
  "query": {
    "pages": [
      {"21721040": {"pageid": 21721040,"ns":0,"title":"Stack Overflow","extract":"Some interesting text about Stack Overflow"}},
      {"21721041": {"pageid": 21721041,"ns":0,"title":"Baeldung","extract":"A great place to learn about Java"}}
    ]
  }
}' | jq '.query.pages[] | .[] | {title: .title, extract: .extract}'

controlplane:~$ echo '{
  "query": {
    "pages": [
      {
        "21721040": {
          "pageid": 21721040,
          "ns": 0,
          "title": "Stack Overflow",
          "extract": "Some interesting text about Stack Overflow"
        }
      },
      {
        "21721041": {
          "pageid": 21721041,
          "ns": 0,
          "title": "Baeldung",
          "extract": "A great place to learn about Java"
        }
      }
    ]
  }
}' | jq '.query.pages | [.[] | map(.) | .[] | {page_title: .title, page_description: .extract}]' 
[
  {
    "page_title": "Stack Overflow",
    "page_description": "Some interesting text about Stack Overflow"
  },
  {
    "page_title": "Baeldung",
    "page_description": "A great place to learn about Java"
  }
]
```
```bash
#".[]" get into the array items other wise it see array as item
ubuntu:~$ jq '.[].name' seaCreatures.json #filtering
"Sammy"
"Bubbles"
"Splish"
"Splash"

ubuntu:~$ jq '.[] | .name' seaCreatures.json #filtering
"Sammy"
"Bubbles"
"Splish"
"Splash"

ubuntu:~$ jq -r '.[] | .name' seaCreatures.json #Remove quotes from output
Sammy
Bubbles
Splish
Splash
```
* Extract Claim Value
```bash
ubuntu:~$ jq '.[] | .clams' seaCreatures.json
5
3
2
2
```
* Wrap it in array/map
```bash
ubuntu:~$ jq '[.[] | .clams]' seaCreatures.json
[
  5,
  3,
  2,
  2
]

ubuntu:~$ jq 'map(.clams)' seaCreatures.json
[
  5,
  3,
  2,
  2
]

```
* Sum app item in array
```bash
ubuntu:~$ jq 'map(.clams) | add' seaCreatures.json
12

ubuntu:~$ jq '[.[] | .clams] | add' seaCreatures.json
12
```
* Select only dolphins:
```bash
ubuntu:~$ jq 'map(select(.type == "dolphin"))' seaCreatures.json
[
  {
    "name": "Splish",
    "type": "dolphin",
    "clams": 2
  },
  {
    "name": "Splash",
    "type": "dolphin",
    "clams": 2
  }
]

jq '.[] | select(.age > 30)' data.json

jq '.[] | {name: .name, email: .email}' data.json

jq 'map({user_id: .id, userDetails: {name: .name, email: .email}})' data.json

jq '.[] | if .age > 30 then .name else empty end' data.json

jq '.users[] | select(.age>30 and .posts[].likes>50)' data.json

jq '(.users | map(.age) | add) / length' data.json

jq -s '.' file1.json file2.json file3.json > combined.json #Combine multiple JSON files

curl -s 'api_url' | jq '.items[] | {id: .id, name: .name}' #Integrate in shell scripts or pipelines

jq --stream 'select(.[0] | length==2) | .[1]' large-file.json #Use --stream for very large JSON files

#Error Handling
jq 'if type=="object" then . else error("Invalid JSON") end' file.json
#Validate JSON

jq '.creatures[]? | {name: .name, clams: (.clams // 0)}' seaCreatures.json #Handle missing fields gracefully-Debug complex queries: Use --debug and test filters incrementally.

curl -s "https://api.github.com/repos/stedolan/jq/issues" | jq '.items[] | {title: .title, state: .state}' #API Responce

jq -r '.[] | [.name, .type, .clams] | @csv' seaCreatures.json > creatures.csv #JSON to CSV
```
* Select only their clams:
```bash
ubuntu:~$ jq 'map(select(.type == "dolphin").clams)' seaCreatures.json
[
  2,
  2
]
```
* Sum dolphin clams:
```bash
jq 'map(select(.type == "dolphin").clams) | add' seaCreatures.json
```
* Combine filters into a single JSON object
```bash
jq '{ 
  creatures: map(.name), 
  totalClams: map(.clams) | add, 
  totalDolphinClams: map(select(.type == "dolphin").clams) | add 
}' seaCreatures.json
{
  "creatures": ["Sammy","Bubbles","Splish","Splash"],
  "totalClams": 12,
  "totalDolphinClams": 4
}
```
```bash
controlplane:~$ kubectl get pods -o json | jq '.items[0] | select(.status.phase == "Running")' #First item in items array

controlplane:~$ kubectl get pods -o json | jq '.items[] | select(.status.phase == "Running")' #All items in items array

controlplane:~$ kubectl get pods -o json | jq '.items[] | select(.status.phase == "Running") | {name: .metadata.name, node: .spec.nodeName}'
{
  "name": "nginx",
  "node": "node01"
}
{
  "name": "nginx1",
  "node": "node01"
}
{
  "name": "nginx2",
  "node": "node01"
}
```
```bash
Controlplane:~$ jq -r '.version' package.json
1.0.0

VERSION=$(jq -r '.version' package.json)
echo "VERSION=$VERSION" >> $GITHUB_ENV
```

* Error handling / Validation
    * Validate JSON:
    ```bash
    jq '. as $data | if $data | type == "object" then $data else error("Invalid JSON structure") end' input.json
    ```
    * Handle missing fields:
    ```bash
    jq '.creatures[]? | {name: .name, clams: (.clams // 0)}' seaCreatures.json
    ```