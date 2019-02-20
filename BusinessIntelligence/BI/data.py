def loadDataSet():
    dataSet = []
    data = open('data.txt', 'r')
    lines = data.readlines()
    for line in lines:
        tid = line.split(',')
        tid = list(map(int, tid))
        dataSet.append(tid)
    return dataSet