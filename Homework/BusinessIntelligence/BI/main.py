import data
import apriori
import matplotlib.pyplot as plt
import numpy

dataSet = data.loadDataSet()
print ('size of dataSet: ', len(dataSet))

# 1)
plt.figure()
minSupports = [0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4]
cntOfRules = []
for minSupport in minSupports:
    frequentItemSet, supportData = apriori.apriori(dataSet, minSupport)
    rules = apriori.generateRules(frequentItemSet, supportData, 0.1 )
    cntOfRules.append(len(rules))
x = numpy.array(minSupports)
y = numpy.array(cntOfRules)
plt.plot(x, y)
plt.xlabel('minimal support with 0.3 confidence')
plt.ylabel('cntOfRules')

# 2)
plt.figure()
minConfidences = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8]
cntOfRules = []
frequentItemSet, supportData = apriori.apriori(dataSet, 0.1)
for minConfidence in minConfidences:
    rules = apriori.generateRules(frequentItemSet, supportData, minConfidence)
    cntOfRules.append(len(rules))
x = numpy.array(minConfidences)
y = numpy.array(cntOfRules)
plt.plot(x, y)
plt.xlabel('minimal confidence with 0.1 support')
plt.ylabel('cntOfRules')

plt.show()