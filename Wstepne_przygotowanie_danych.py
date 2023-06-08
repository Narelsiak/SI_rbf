f = open("C:/python_code/new_folder/data_Tex_64.txt")
allPlantInOne = {}
arr = []
for printLinByLine in f:
    a = (printLinByLine.strip().split(','))
    a[0] = a[0].replace(" ", "_")
    if not a[0] in allPlantInOne:
        allPlantInOne[a[0]] = []
    allPlantInOne[a[0]].append(a)
    if not a[0] in arr:
        arr.append(a[0])
arr = sorted(arr)
str = ""
for pName in arr:
    for pAll in allPlantInOne[pName]:
        str += ','.join(pAll)
        str += '\n'
#print(str)

with open('C:/python_code/new_folder/d_tex_ready.txt', 'w') as f:
        f.write(str)