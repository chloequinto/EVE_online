'''
Created on Sep 11, 2018

@author: Chloe Quinto
'''
import glob
import re 


list_of_files = []
mylist = []
count = x =  0 
found = []




def process_file(directory):
    '''
    Function processes through the text files within a directory
    and returns an array containing the path of each file 
    '''
    global list_of_files, found, x
    for i in glob.glob(directory + "\*.txt"): 
        list_of_files.append(i)

    date = re.findall('20(.+?).txt', str(list_of_files))
    if date:
        found.extend(date) 

    for b in list_of_files:
        segmentation(b, x)
        x += 1
    
        
def read_file(item):
    '''
    example that reads each file 
    '''
    file = open(item, "r")
    print(file.read())
    file.close()
    return 

def write_file(directory):
    '''
    example that writes a new file 
    '''
    global count
    f = open(directory + "\\example_overwrite.txt", "w")
    f.write("Example of overwriting")
    f.close()
    return

def segmentation(item,index):
    '''
    Segments based on capitalized lines
    '''
    global mylist, directory, count, found, x
    var = var_second = var_third =  0 
    inc = inc_0  = inc_1  = 0 
    var_fourth = [] 
    iterable_caps = []
    
    file = open(item, "r")
        
    with file as f:
        mylist = [line.rstrip("\n") for line in f] #removes \n
    
  
    for i in mylist:  #removes blank lines
        if i == '':
            mylist.remove('')
        break
    for i, j in enumerate(mylist): 
        if j.isupper(): 
            var = i
            count += 1 
    if count == 1: 
        print("There is only one instance where a caps line was seen")
        fi = open(directory  + "20" + found[x] +"_" + str(inc_0) + "_one_seen" + ".txt", "a")
        fi.write("\n".join(mylist[var:]))
        fi.close()
        inc_0 += 1 
    elif count == 2: 
        print("There are two instances where cap lines were seen")
        for h,g in enumerate(mylist):
            if g.isupper():
                var_second = h
                break
        for b,c in enumerate(mylist[var_second+1:]):
            if c.isupper(): 
                var_third = b
        file = open(directory + "20" + found[x] +"_" + str(inc_1) + "_two_seen_first.txt", "a")
        file.write("\n".join(mylist[var_second:var_third]))
        file.close()
        file = open(directory + "20" + found[x] +"_"+ str(inc_1) + "_two_seen_second.txt", "a")
        file.write("\n".join(mylist[var_third:]))
        file.close()
        inc_1 += 1 
    elif count > 2: 
        print("There are more than two lines where CAPS was seen")
        for a,b in enumerate(mylist):
            if b.isupper():
                iterable_caps.append(mylist[a])
                var_fourth.append(a)
        for i in reversed(var_fourth):
            file = open(directory + "20" + found[x] + "_" + str(inc) + "_more_seen.txt", "a")
            file.write("\n".join(mylist[i:]))
            file.close()
            del mylist[i:]
            inc += 1 
        
    else:
        print("No instance of all caps")
        fi = open(directory  + "20" + found[x] +"_" + str(inc_0) + "_none_seen" + ".txt", "a")
        fi.write("\n".join(mylist))
        fi.close()
        inc_0 += 1 
        
    
    
def less_length(one):
    '''
    Function that segments with the title that contains less than 5 words 
    '''
    return None
    
    
                 
if __name__ == '__main__':
    directory = "C:/res/"
    process_file("C:\one")
    pass