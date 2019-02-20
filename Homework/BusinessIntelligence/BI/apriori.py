def computeSupport(dataSet, itemSets, minSupport):
    supportDict = {} #store the support of all itemset
    for transaction in dataSet:
        for itemSet in itemSets:
            if set(itemSet).issubset(set(transaction)):
                if supportDict.__contains__(frozenset(itemSet)):
                    supportDict[frozenset(itemSet)] += 1
                else:
                    supportDict[frozenset(itemSet)] = 1

    newItemSets = []
    for key in supportDict.keys():
        if supportDict[key] > minSupport:
            newItemSets.append(set(key))
    return newItemSets, supportDict


def apriori(dataSet, minSupportP):
    minSupport = minSupportP * len(dataSet)
    itemSet = set() #store the items
    for transaction in dataSet:
        for item in transaction:
            itemSet.add(item)
    intItemSets = [{item} for item in itemSet]

    frequentItemSet = [intItemSets] #frequent item set
    supportDict = {}    #support dictionary with key = item set list
    k = 0
    while True:
        itemSets, newSupportDict = computeSupport(dataSet, frequentItemSet[k], minSupport)
        supportDict.update(newSupportDict)
        if len(itemSets) == 0:
            del(frequentItemSet[k])
            break
        frequentItemSet[k] = itemSets
        newItemSets = []
        for itemSet1 in frequentItemSet[k]:
            for itemSet2 in frequentItemSet[k]:
                itemSet1L = list(itemSet1)
                itemSet2L = list(itemSet2)
                if itemSet1L[:-1] == itemSet2L[:-1] and itemSet1L[-1] < itemSet2L[-1]:
                    newItemSets.append(itemSet1 | itemSet2)
        k += 1
        frequentItemSet.append(newItemSets)
    return frequentItemSet, supportDict


def generateRules(frequentItemSet, supportDict, minConfidence):
    rules = []
    effectiveFIS = frequentItemSet[1:]
    for kItemSets in effectiveFIS:
        for itemSet in kItemSets:
            subsets = [[]]
            for item in itemSet:
                subsets.extend([tempSet + [item] for tempSet in subsets])
            subsets = subsets[1:-1]
            for i in range(len(subsets)):
                subsets[i].sort()
            for subset in subsets:
                confidence = supportDict[frozenset(itemSet)] / supportDict[frozenset(subset)]
                if confidence >= minConfidence:
                    rules.append( (subset, itemSet, confidence) )
    return rules

