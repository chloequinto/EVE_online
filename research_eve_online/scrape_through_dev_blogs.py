'''
Created on Sep 11, 2018

@author: Chloe Quinto
'''
import glob
import string


list_of_files = []
mylist = []
count = 0 


def process_file(directory):
    '''
    Function processes through the text files within a directory
    and returns an array containing the path of each file 
    '''
    global list_of_files 
    for i in glob.glob(directory + "\*.txt"): 
        list_of_files.append(i)
    for b in list_of_files: 
        segmentation(b)
    
    #The strings in the array list of files will have two backslashes
    #this is because you are seeing the representation of the paths
    #printing the element within the array shows one backslash
    
    #print(list_of_files)
    #print(list_of_files[0])
        
def read_file(item):
    '''
    Reads each file 
    '''
    file = open(item, "r")
    print(file.read())
    file.close()
    return 

def write_file(directory):
    '''
    writes a new file 
    '''
    global count
    f = open(directory + "\\example_overwrite.txt", "w")
    f.write("Example of overwriting")
    f.close()
    return

def segmentation(item):
    '''
    Segments based on capitalized lines
    '''
    global mylist, directory, low_case, up_case, count
    var = 0 
    var_second = 0 
    var_third = 0 
    inc = 0 
    var_fourth = [] 
    iterable_caps = []
    file = open(item, "r")
    
    
    with file as f:
        mylist = [line.rstrip("\n") for line in f] #removes \n
    
  
    for i in mylist:  #removes blank lines
        if i == '':
            mylist.remove('')
        break
    #Check for caps line
    for i, j in enumerate(mylist): 
        if j.isupper(): 
            var = i
            count += 1 
    if count == 1: 
        print("There is only one instance where a caps line was seen")
        print(mylist[var::])
        fi = open("C:/res/instant.txt", "a")
        fi.write("\n".join(mylist[var:]))
        fi.close()
    elif count == 2: 
        print("There are two instances where cap lines were seen")
        for h,g in enumerate(mylist):
            if g.isupper():
                var_second = h
                break
        for b,c in enumerate(mylist[var_second+1:]):
            if c.isupper(): 
                var_third = b
        print(mylist[var_second:var_third])
        print(mylist[var_third:])
        file = open("C:/res/instant_two.txt", "a")
        file.write("\n".join(mylist[var_second:var_third]))
        file.close()
        file = open("C:/res/instant_three.txt", "a")
        file.write("\n".join(mylist[var_third:]))
        file.close()
    elif count > 2: 
        print("There are more than two lines where CAPS was seen")
        for a,b in enumerate(mylist):
            if b.isupper():
                iterable_caps.append(mylist[a])
                var_fourth.append(a)
        print(var_fourth)
        for i in reversed(var_fourth):
#             print(mylist[i:])
            file = open("C:/res/" + str(inc) + "multiple.txt", "a")
            file.write("\n".join(mylist[i:]))
            file.close()
            print(mylist[i:])
            del mylist[i:]
            inc += 1 
            

    else:
        print("No instance of all caps")
        
def less_length(one):
    '''
    Function that segments with the title that contains less than 5 words 
    '''
    if len(one) <= 5: 
        return None
    
    
                 
if __name__ == '__main__':
    directory = "C:\res"
    process_file("C:\one")
    pass