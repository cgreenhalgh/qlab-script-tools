import * as mammoth from 'mammoth'
import * as sax from 'sax'
import * as fs from 'fs'

if (6 != process.argv.length) {
    console.log(`usage: node ${process.argv[1]} SCRIPT.docx OUT.json OUT.txt CUES.csv`)
    process.exit(-1)
}

let path = process.argv[2]
let jsonout = process.argv[3]
let textout = process.argv[4]
let csvout = process.argv[5]

console.log(`reading script file ${path}`)

const DEFAULT_PATCH = "1"

enum CueType {
    CAPTION,
    COMMENT
}

interface Cue {
    cueType:CueType
    captionNumber?:string
    text:string // Caption or comment
}

enum QlabCueAction {
    ADD = 'add'
}
enum OscMessageType {
    CUSTOM = 'custom'
}

interface QlabCue {
    action?:QlabCueAction
    cueType:string
    uniqueID?:string
    qNumber?:string
    qName?:string
    //cue target", "file target", "pre wait", ¬
    //"duration", "post wait", "continue mode", "broken", "notes", "mode", "opacity", ¬
    patch?:string
    oscMessageType?:OscMessageType
    customMessage?:string
}

function escapeCsv(s:string) : string {
    if (s===null || s===undefined)
        return "";
    return '"'+s.replace(/"/g, '""').replace(/\n/g,'\\n')+'"'
}
function cuesToCsv(cues: QlabCue[]) : string {
    let text = ''
    text  += 'action,type,uniqueID,q number,q name,patch,osc message type,custom message\n'
    for (let cue of cues) {
        text += `${cue.action},${cue.cueType},,${escapeCsv(cue.qNumber)},${escapeCsv(cue.qName)},${escapeCsv(cue.patch)},${escapeCsv(cue.oscMessageType)},${escapeCsv(cue.customMessage)}\n`
    }
    return text
}
function stripHtml(s:string): string {
    return s.replace(/<[^>]+>/g,'')
}
mammoth.convertToHtml({path: path}, {ignoreEmptyParagraphs:false})
    .then((result) => {
        let lines = []
        let html = result.value; // The generated HTML
        let messages = result.messages; // Any messages, such as warnings during conversion
        for (let message in messages) {
            console.log(`convertion message: ${message}`)
        }
        //console.log('result:', html)
        let parser = sax.parser(false, {})
        let stack = []
        let line = []
        parser.onerror = function (e) {
            // an error happened. 
            console.log(`ERROR: parsing: ${e}`)
        };
        parser.ontext = function (t) {
            // got some text.  t is the string of text. 
            line.push(t)
            //console.log(`text: ${t}`)
        };
        parser.onopentag = function (node) {
          // opened a tag.  node has "name" and "attributes" 
            stack.push(node.name)
            if (stack.length>2)
                line.push('<'+node.name+'>')
            //console.log(`open ${node.name}`)
        };
        parser.onclosetag = function (name) {
            if (stack.length>2) {
                // discard if empty
                if (line[line.length-1].trim().length==0) {
                    line.splice(line.length-2, 2)
                } else {
                    line.push('</'+name+'>')
                }
            }
            stack.splice(stack.length-1, 1)
            if (stack.length==1) {
                //console.log(`line: ${line}`)
                lines.push(line.join(''))
                line.splice(0,line.length)
            }
            //if ('p'==name && stack.length>1)
            //console.log(`stack after ${name}: ${stack}`)
        }
        parser.onattribute = function (attr) {
          // an attribute.  attr has "name" and "value" 
        };
        parser.onend = function () {
          // parser stream is done, and ready to have more stuff written to it. 
            console.log(`parse end`)
        };
         
        parser.write('<body>'+html+'</body>').close();
        return lines;
    })
    .then((lines) => {
        console.log(`read ${lines.length} lines`)
        let currentCue:Cue = null
        let cues:Cue[] = []
        let blankCount = 0
        let cueRegex = new RegExp('^[Cc][Aa][Pp]\\s+(\\S+)\\s(.*)$')
        let contRegex = new RegExp('^\\s')
        let strongRegex = new RegExp('^<[Ss][Tt][Rr][Oo][Nn][Gg]>')
        var res
        for (let line of lines) {
            if (line.trim().length==0)
                blankCount++
            else if ((res = cueRegex.exec(line))!==null) {
                blankCount = 0
                let text = (res[2] as string).trim()
                if ('blank slide' == text.toLowerCase())
                    text = ''
                let captionNumber = 'CAP '+(res[1] as string)
                currentCue = {cueType: CueType.CAPTION, captionNumber: captionNumber, text: text }
                cues.push(currentCue)
            } else if (contRegex.test(line) || !strongRegex.test(line)) {
                // sometime paragraph left offset is used rather than tab for continuation
                // so fall back to use of bold for comments/headings
                if (currentCue) {
                    for (let i=0; i<blankCount; i++)
                        currentCue.text += '\n'
                }
                currentCue.text += '\n' + line.trim()
            } else {
                // comment
                blankCount = 0
                currentCue = {cueType: CueType.COMMENT, text: line.trim() }
                cues.push(currentCue)
            }
        }
        return cues
    })
    .then((cues) => {
        let jsontext = JSON.stringify(cues, null, 4)
        try {
            fs.writeFileSync(jsonout ,jsontext, {encoding:'utf8'})
        } catch(err) {
            console.log(`Error writing ${jsonout}: ${err.message}`)
        }
        console.log(`wrote to ${jsonout}`)
        let text = ''
        for (let cue of cues) {
            if (cue.cueType == CueType.CAPTION) {
                text = text + '#'+cue.captionNumber+'\n'+cue.text+'\n\n'
            }
        }
        try {
            fs.writeFileSync(textout, text, {encoding:'utf8'})
        } catch(err) {
            console.log(`Error writing ${textout}: ${err.message}`)
        }        
        console.log(`wrote to ${textout}`)
        
        // OSC for Qlab
        let qlabCues:QlabCue[] = []
        for (let cue of cues) {
            var qcue:QlabCue
            switch (cue.cueType) {
            case CueType.CAPTION:
                let osc = '/'+cue.captionNumber.replace(/ /g, '/')
                qcue = {action: QlabCueAction.ADD, cueType: 'OSC', qName: cue.captionNumber, patch: DEFAULT_PATCH, oscMessageType: OscMessageType.CUSTOM, customMessage: osc }
                qlabCues.push(qcue)
                break;
            case CueType.COMMENT:
                qcue = {action: QlabCueAction.ADD, cueType: 'Memo', qName: stripHtml(cue.text) }
                qlabCues.push(qcue)
                break;
            }
        }
        let csv = cuesToCsv(qlabCues)
        try {
            fs.writeFileSync(csvout, csv, {encoding:'utf8'})
        } catch(err) {
            console.log(`Error writing ${csvout}: ${err.message}`)
        }        
        console.log(`wrote to ${csvout}`)
        
    })
    .done();
