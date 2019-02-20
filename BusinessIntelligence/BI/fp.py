import data

class TreeNode:
    def __init__(self, val = -1, cnt = 1, parentNode = None):
        self.val = val
        self.cnt = cnt
        self.nextNode = None
        self.parent = parentNode
        self.children = {}

    def add(self, addCnt):
        self.cnt += addCnt


def updateTree(data, root, headNodeTable):
    for item in data:
        if item in root.children.keys():
            root.children[item].add(1)
        else:
            curNode = TreeNode(val=item, parentNode=root)
            root.children[item] = curNode
            if headNodeTable.__contains__(item):
                curHeadNode = headNodeTable[item]
                while curHeadNode.nextNode is not None:
                    curHeadNode = curHeadNode.nextNode
                curHeadNode.nextNode = curNode
            else:
                headNodeTable[item] = curNode
        root = root.children[item]


def createTree(dataSet, path, minSupport):
    frequentItemSet = []
    supportDict = {}
    headNodeTable = {}
    frequencyDict = {}

    for transaction in dataSet:
        for item in transaction:
            if frequencyDict.__contains__(item):
                frequencyDict[item] += 1
            else:
                frequencyDict[item] = 1

    filteredDataSet = []
    for transaction in dataSet:
        filteredTransaction = []
        for item in transaction:
            if frequencyDict[item] > minSupport:
                filteredTransaction.append(item)
        filteredDataSet.append(filteredTransaction)
    dataSet = filteredDataSet

    for transaction in dataSet:
        transaction.sort(key = lambda  item : -frequencyDict[item])
        updateTree(transaction, TreeNode(), headNodeTable)

    headNodeKeys = [key for key in headNodeTable]
    headNodeKeys.sort(key = lambda  item : frequencyDict[item])
    for headNodeKey in headNodeKeys:
        curHeadNode = headNodeTable[headNodeKey]
        cnt = 0
        while curHeadNode.nextNode is not None:
            cnt += curHeadNode.cnt
            curHeadNode = curHeadNode.nextNode
        itemSet = [curHeadNode.val] + path
        frequentItemSet.append(itemSet)
        itemSet.sort()
        supportDict[frozenset(itemSet)] = cnt

    for headNodeKey in headNodeKeys:
        curHeadNode = headNodeTable[headNodeKey]
        conditionalDataSet = []
        while curHeadNode is not None:
            transaction = []
            parent = curHeadNode.parent
            while parent.parent is not None:
                transaction.append(parent.val)
                parent = parent.parent
            transaction.reverse()
            if len(transaction) > 0:
                conditionalDataSet.extend([transaction] * curHeadNode.cnt)
            curHeadNode = curHeadNode.nextNode
        newFrequentItemSet, newSupportData = createTree(conditionalDataSet, [headNodeKey] + path, minSupport)
        frequentItemSet.extend(newFrequentItemSet)
        supportDict.update(newSupportData)
    return frequentItemSet, supportDict


def fpGrowth(dataSet, minSupportP):
    minSupport = minSupportP * len(dataSet)
    frequentItemSet, supportDict = createTree(dataSet, minSupport, [])
    return frequentItemSet, supportDict

