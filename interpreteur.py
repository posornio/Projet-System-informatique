def getPhrase(path):
    TabInstructions = []
    
    f= open(path+".txt","r")
    for line in f:
        Instruction=[]
        for lin in line.split():
            Instruction.append(lin)
        TabInstructions.append(Instruction)
    return TabInstructions

def TabtoInst(Tab):
    ret = []
    for inst in Tab:
        print(inst)
        line = []
        line.append(instToOpBin(inst[0]))
        Ra =inst[1] if len(inst)>1 else ""
        Rb =inst[2] if len(inst)>2 else ""
        Rc =inst[3] if len(inst)>3 else ""
        Ra=0 if Ra=="" else Ra
        Rb=0 if Rb=="" else Rb
        Rc=0 if Rc=="" else Rc
        line.append(int(Ra))
        line.append(int(Rb))
        line.append(int(Rc))
        ret.append(line)
    return ret

def instToOpBin(str):
    match str:
        case "ADD":
            return "01"
        case "MUL":
            return "02"
        case "SOU":
            return "03"
        case "DIV":
            return "04"
        case "COP": 
            return "05"
        case "AFC":
            return "06"
        case "LOAD":
            return "07"
        case "STORE":
            return "08"
        #case "EQU":
         #   return "00001001"
        case "INF":
            return "0A"
        case "INFEQ":
            return "0B"
        case "SUP":
            return "0C"
        case "SUPEQ":
            return "0D"
        case "JMP":
            return "0E"
        case "JMPF":
            return "0F"
        case "JMPEQ":
            return "10"
        case "JMPNE":
            return "11"
        case "JMPEQ":
            return "12"
        case "EQ":
            return "13"
        case "NE":
            return "14"
        case _:
            return "00"
        


def inttohex(int):
    if int<16:
        hexVal = hex(int)
        return "0"+str(hexVal)[2:]
    else:
        return str(hex(int))[2:]

def binToOp(str):
    bin = int(str,base=2)
    return hex(bin)
#print(TabtoInst(getPhrase("asm")))
def tabtolist(tab):
    ret = []
    for line in tab:
        str = ""
        str += inttohex(line[1])
        str += line[0]
        str += inttohex(line[2])
        str += inttohex(line[3])
        ret.append(str)
    return ret


def listtostr(list):
    ret = "("
    for line in list:
        str='x"'
        str += line
        str += '",'
        ret += str
    ret += 'others=>(x"00000000"))'
    return ret
tab= (tabtolist(TabtoInst(getPhrase("asm"))))
print(listtostr(tab))