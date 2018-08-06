#!/usr/bin/python


def getGrouping(availList, numNeeded) :
    if (numNeeded == 0) :
        return []

    if (numNeeded > len(availList)) :
        return []

    if (len(availList) == 0) :
        return []


    results = []
    if (numNeeded > 1) :
        newAdds = getGrouping(availList[1:], numNeeded - 1)
        for add in newAdds :
            results.append([availList[0], add])

    if (len(availList) > 1) :
        results.extend(getGrouping(availList[1:], numNeeded))
    return results
