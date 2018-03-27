# node app for script processing

try processing a script word file and outputting useful stuff.

Currently generates a json file for Tosh's demo, a txt file for Joe's renderer and a CSV file for creating qlab cues from (for use with Joe's renderer).

## script format

just from an initial sample...
```
Little Red Riding Hood – The First Murder Attempt

CAP 1	Music

CAP 2	Snow White: Clean the house.

CAP 3	Urgent knocking at window
 
CAP 4	Little Red Riding Hood: Help, help. Let me in!

 	Snow White: No. Go away!
```

- lines beggining 'CAP' are start of a caption
- blank lines are continuation or break
- lines beggining with tab/whitespace are continuations
- 'CAP' is followed by caption number/name

## output formats

### JSON

array of `cue`

`cue` is object with 
- `cueType`: (number) `0` for caption, `1` for comment
- `captionNumber`: (string!) for each caption
- `text`: (string) caption or comment text, including some HTML-style markup (`<STRONG>` for bold, `<EM>` for italic)

### Text

For Joe Marshall's unity renderer...

- line starting with `#` is new cue, followed by cue name/number (e.g. "CUE 1"), optionally followed by "," and display area name (defaults to first)
- line with '[' filename ']' is background image
- line with '{' filename '}' is background video
- other lines are text of cue

Joe's OSC server:
- "/" caption name with "/" instead of ' ', e.g. "/CAP/1"

### Qlab

Qlab OSC messages:
- `q type` "OSC"
- `osc message type` "custom"
- `custom message` "/message parameters" (double quote strings)

## Build

```
sudo docker build -t qlabnodeapp .
```
```
sudo docker run -it --rm --name=qlabnodeapp -v `pwd`/data:/root/work/data qlabnodeapp
```
run in container
```
node dist/index.js data/RED\ EARTH\ \ MM\ SCRIPT\ EXTRACT\ FOR\ III\ HACK\ FEST\ DAY.docx data/captions.json data/captions.txt
```
update
```
sudo docker cp src/. qlabnodeapp:/root/work/src
tsc
```

