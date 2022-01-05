#!/usr/bin/env python
# coding: utf-8

# In[ ]:


#!/usr/bin/env python3

import sys

def reducer():
    currentcost = 0
    oldKey = None

    for line in sys.stdin:
        data = line.strip().split(",")

        thisKey, thisCost = data
        if oldKey is not None and oldKey != thisKey:
            print(oldKey + "," + str(currentcost))
            currentcost = 0

        oldKey = thisKey
        if float(thisCost) > float(currentcost):
            currentcost = thisCost
        else:
            continue
       
    if oldKey is not None: #for the final key
        print(oldKey + "," + str(currentcost))
if __name__ == "__main__":
    # what function should run when python reducer.py is called?
    reducer()

