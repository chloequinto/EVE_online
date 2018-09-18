'''
Created on Sep 11, 2018

@author: Chloe Quinto

Program that separates a given text file by it's caps and the length of its sentences 
'''
import glob
import re 


list_of_files = []
mylist = []
count = x =  0 
found = []
found_less_than_five = []




def process_file(directory):
    '''
    Function processes through the text files within a directory
    and returns an array containing the path of each file 
    '''
    global list_of_files, found, found_less_than_five, x
    for i in glob.glob(directory + "\*.txt"): 
        list_of_files.append(i)

    date = re.findall('20(.+?).txt', str(list_of_files))
    if date:
        found.extend(date) 
        found_less_than_five.extend(date)

    for b in list_of_files:
        print("this")
        segmentation(b, x)
#         less_length(b,x)
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
    global mylist, caps_directory, count, found, x
    var = var_second = var_third =  0 
    inc = inc_0  = inc_1  = 0 
    var_fourth = [] 
    iterable_caps = []
    
    file = open(item, "r")
        
    with file as f:
        mylist = [line.rstrip("\n") for line in f] #removes \n
    
    mylist = [x for x in mylist if x != '']
   
    for i, j in enumerate(mylist): 
        if j.isupper(): 
            var = i
            count += 1 
    if count == 1: #only on instance where you see caps line
        fi = open(caps_directory  + "20" + found[x] +"_" + str(inc_0) + "_one_seen" + ".txt", "a")
        fi.write("\n".join(mylist[var:]))
        fi.close()
        inc_0 += 1 
    elif count == 2: #two instances of caps seen 
        #technically, you don't need this condition but it shows how the process works 
        print("There are two instances where cap lines were seen")
        for h,g in enumerate(mylist):
            if g.isupper():
                var_second = h
                break
        for b,c in enumerate(mylist[var_second+1:]):
            if c.isupper(): 
                var_third = b
        file = open(caps_directory + "20" + found[x] +"_" + str(inc_1) + "_two_seen_first.txt", "a")
        file.write("\n".join(mylist[var_second:var_third]))
        file.close()
        file = open(caps_directory + "20" + found[x] +"_"+ str(inc_1) + "_two_seen_second.txt", "a")
        file.write("\n".join(mylist[var_third:]))
        file.close()
        inc_1 += 1 
    elif count > 2: #more than two lines where CAPS was seen 
        for a,b in enumerate(mylist):
            if b.isupper():
                iterable_caps.append(mylist[a])
                var_fourth.append(a)
        for i in reversed(var_fourth):
            file = open(caps_directory + "20" + found[x] + "_" + str(inc) + "_more_seen.txt", "a")
            file.write("\n".join(mylist[i:]))
            file.close()
            del mylist[i:]
            inc += 1 
        
    else:#no instance of CAPS was seen 
        fi = open(caps_directory  + "20" + found[x] +"_" + str(inc_0) + "_none_seen" + ".txt", "a")
        fi.write("\n".join(mylist))
        fi.close()
        inc_0 += 1 
        
    print("Success! We have segmented the text files via caps sentences.")
    
def less_length(item,index):
    '''
    Function that segments with the title that contains less than 5 words 
    '''
    global less_than_five_directory,found_less_than_five, x
    location= [] #index of sentences
    var_loc = [] #index of sentences less than 5 
    nums = [] #values of blanks  
    count =  inc_0  = inc_1 = inc_2= 0
    nums_of_fives = 0 #number of sentences that contain less than 5 words 
    file = open(item, "r")
    
    with file as f:
        mylist = [line.rstrip("\n") for line in f] #removes \n

    mylist = [x for x in mylist if x != '']
        
#     print(mylist)
    for i, j in enumerate(mylist): 
        for b in j: 
            if (' ' in b): 
                count += 1
                location.append(i)
        nums.append(count) #number of spaces as a list 
        count = 0; #number of spaces 
    loc  = list(set(location)) #indexes where there is a space instance        
    fin = dict(zip(loc, nums)) #indexes and the number of spaces in the list 
    for key,value in fin.items(): 
#         print(value)
        if value <= 4: #There are sentences that contain less than 5 words, we're going to separate
            nums_of_fives += 1
    if nums_of_fives == 1: #There is only once instance where is one sentence that contains less than 5 words 
        for key, value in fin.items(): 
            if value <= 4: 
                fi = open(less_than_five_directory + "20" + found_less_than_five[x]  +"_" + str(inc_1) + "_one_seen_less_5" + ".txt", "a")
                fi.write("\n".join(mylist[key:]))
                fi.close()
                inc_1 += 1 
    elif nums_of_fives >= 1: #there are more than one instance of setences longer than 5 words 
        for key, value in fin.items(): 
            if value <= 4: 
                var_loc.append(key)
        for i in reversed(var_loc):
            file = open(less_than_five_directory + "20" + found_less_than_five[x]  +"_" + str(inc_2) +"_more_seen_less_5" + ".txt", "a")
            file.write("\n".join(mylist[i:]))
            file.close()
            del mylist[i:]
            inc_2 += 1 
    else: #no instances of less than 5 (text is full of sentences longer than 5 words) 
        inc_0 += 1 
    print("Success! You have segmented the text files into its corresponding files")
                 
if __name__ == '__main__':
    caps_directory = "C:/research_18_caps_folder/"
    less_than_five_directory = "C:/research_18_less_than_5/"
    process_file("C:\one")
    pass