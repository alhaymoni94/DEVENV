# Phase 3: Data & AI Quiz

Q: What command opens a CSV file in visidata?
A: vd file.csv

Q: In visidata, how do you sort a column ascending?
A: Press g on the column

Q: In visidata, how do you filter rows?
A: Press |

Q: In visidata, how do you show frequency table?
A: Shift+F

Q: In visidata, how do you quit?
A: q

Q: What command pretty-prints JSON?
A: cat file.json | jq '.'

Q: How do you extract a specific field from JSON with jq?
A: cat file.json | jq '.fieldname'

Q: How do you iterate over a JSON array with jq?
A: cat file.json | jq '.[]'

Q: How do you filter JSON objects with jq?
A: cat file.json | jq '.[] | select(.field > value)'

Q: What command renders markdown in the terminal?
A: glow file.md

Q: How do you render a GitHub README with glow?
A: glow https://github.com/user/repo

Q: What AI command generates a script from a description?
A: ai "write a bash script that does X"

Q: How do you ask AI to convert JSON to CSV?
A: cat data.json | ai "convert this to CSV"

Q: What shebang starts a bash script?
A: #!/usr/bin/env bash

Q: What does set -euo pipefail do in a bash script?
A: Exit on error, undefined vars, and pipe failures

Q: How do you access the first argument in a bash script?
A: $1

Q: How do you get the number of arguments passed?
A: $#

Q: What command schedules a script to run automatically?
A: crontab -e

Q: What cron pattern runs a script daily at 2am?
A: 0 2 * * *

Q: How do you read a file line by line in bash?
A: while IFS= read -r line; do ... done < file
