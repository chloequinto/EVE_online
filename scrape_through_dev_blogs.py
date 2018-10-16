'''
Created on Sep 11, 2018

@author: Chloe Quinto

Program that separates a given text file by it's caps and the length of its sentences 
'''
import glob
import re 
import os


list_of_files = []
mylist = []
count = x  = y= z = section_id= id_text = 0 
found = []
found_less_than_five = []
found_blank_spaces = []
list_of_blank_texts = []
list_caps =  []
list_less = []
found_caps = []
found_less = []
dev_blogs = []
res = []

#caps -> less than 5 -> spaces -> remove spaces -> put everything together 
def process_file(directory):
    '''
    Function processes through the text files within a directory
    and returns an array containing the path of each file 
    '''
    global list_of_files, found, found_less_than_five, x, found_blank_spaces, test_directory,finished_directory,y, z
    global dev_blogs, test_directory_result,list_caps, found_less,list_less, section_id, h, res, c, id_text
    my_dict = []
    
#     for i in glob.glob(directory + "\*.txt"): #initial directory, append the text files 
#         list_of_files.append(i)
#          
#     date = re.findall('20(.+?).txt', str(list_of_files)) #place initial files in found 
#     if date:
#         found.extend(date)    
#     for b in list_of_files: #function to write and segment files in a directory 
#         segmentation(b, x)
#         x += 1 
#          
#     for i in glob.glob(caps_directory + "\*.txt"): #pull caps files 
#         list_caps.append(i)
#  
#     date_1 = re.findall('20(.+?).txt', str(list_caps))
#     if date_1:
#         found_caps.extend(date_1)
#      
#     for b in list_caps: 
#         less_length(b,y) #do less_length segmentation 
#         y += 1 
#  
#     for i in glob.glob(less_than_five_directory+ "\*.txt"): #pull less_than_five files
#         list_less.append(i)
#     date_2 = re.findall('20(.+?).txt', str(list_less))
#     if date_2: 
#         found_less.extend(date_2)
#     for b in list_less:
#         separate_by_spaces(b, z) #do separate spaces 
#         z+=1
#     for i in glob.glob(spaces_directory + "\*.txt"): #function to remove blank files in a spaces  
#         list_of_blank_texts.append(i)
#     for b in list_of_blank_texts: 
#         remove_blank_lines(b, x)
    for j,i in enumerate(glob.glob(spaces_directory + "\*.txt")): 
        dev_blogs.append(i)
        check_dir = re.search(r'C:/research_18_spaces\\20.*?(_)', dev_blogs[j]).group()
        res.append(check_dir)
        
#     print(dev_blogs)
# #     print(res)
#     def segmenting(dev_blogs,x, section_id):
#         global h, c
#         for h,b in enumerate(dev_blogs): 
#             segment_for_dev(b,x, section_id)
# #             c += 1
#               
#     #call the functon         
#     segmenting(dev_blogs, x, section_id)
#   
    b = 0 
    for i in range(len(res)-1): 
        if res[i] != res[i+1]:
            segment_for_dev(dev_blogs[b], section_id) #go to the function  
            section_id += 1 
        
            
        else: 
            segment_for_dev(dev_blogs[b], section_id) #go to the function  
        b +=1     

     
    
        
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
    print(item)
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
    global less_than_five_directory,found_less_than_five, y,found_caps
    location= [] #index of sentences
    var_loc = [] #index of sentences less than 5 
    nums = [] #values of blanks  
    count =  inc_0  = inc_1 = inc_2= 0
    nums_of_fives = 0 #number of sentences that contain less than 5 words 
#     print(item)
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
                fi = open(less_than_five_directory + "20" + found_caps[index]  +"_" + str(inc_1) + "_one_seen_less_5" + ".txt", "a")
                fi.write("\n".join(mylist[key:]))
                fi.close()
                inc_1 += 1 
    elif nums_of_fives >= 1: #there are more than one instance of sentences longer than 5 words 
        for key, value in fin.items(): 
            if value <= 4: 
                var_loc.append(key)
        for i in reversed(var_loc):
            file = open(less_than_five_directory + "20" + found_caps[index]  +"_" + str(inc_2) +"_more_seen_less_5" + ".txt", "a")
            file.write("\n".join(mylist[i:]))
            file.close()
            del mylist[i:]
            inc_2 += 1 
    else: #no instances of less than 5 (text is full of sentences longer than 5 words) 
        inc_0 += 1 
    print("Success! You have segmented the text files via less than five")
    
def separate_by_spaces(item,index):
    '''
    Function that segments texts by the amount of spaces it sees 
    '''
    global found_blank_spaces, spaces_directory, z
    count  =  inc_0 = inc_2 = inc_1 =  0
    location = []
    nums = []
    var_loc = []
    file = open(item, "r")
    with file as f:
        mylist = [line.rstrip("\n") for line in f] #removes \n  
    for i in range(len(mylist) - 1):  
        if mylist[i] == mylist[i+1]: 
            count +=1 
            location.append(i)#append the location in the list 
    nums.append(count) #number of spaces as a list 
    count = 0; #number of spaces s
    loc  = list(set(location)) #indexes where there is a space instance   
    fin = dict(zip(loc, nums)) #indexes and the number of spaces in the list 
    for i in loc: 
        if len(loc) == 1: #There are sentences that contain less than 5 words, we're going to separate
            fi = open(spaces_directory + "20" + found_less[z]  +"_" + str(inc_1) + "_one_space_found" + ".txt", "a")
            fi.write("\n".join(mylist[i + 2:]))
            fi.close()
            inc_1 += 1 
        elif len(loc) > 1: 
            file = open(spaces_directory + "20" + found_less[z]  +"_" + str(inc_2) +"_more_space_found" + ".txt", "a")
            file.write("\n".join(mylist[i+2:]))
            file.close()
            del mylist[i+2:]
            del loc[-1]
            inc_2 += 1     
    if loc == []: 
        fi = open(spaces_directory  + "20" + found_less[z] +"_" + str(inc_0) + "_no_space_seen" + ".txt", "a")
        fi.write("\n".join(mylist))
        fi.close()
        inc_0 += 1 
    print("Success! You have segmented the text files into its corresponding files")    
                
def remove_blank_lines(item, index):
    '''
    Function that goes through a directory and removes blank lines
    ''' 
    file = open(item, "r")
    with file as f: 
        first = f.read(1)
        if not first: 
            file.close()
            os.remove(item)
            print('Text is empty')
        else:
            print('Text is not empty')

def segment_for_dev(item, section_id): 
    '''
    Function that takes the above texts and put in it the format 
    <section id>    english    text
    for example
    0    english     this is a fun program 
    '''
    global test_directory_result, res, id_text 
    this = []
    file = open(item, "r")
    with file as f:
        mylist = [line.rstrip("\n") for line in f] #removes \n  
    for i in mylist: 
        this.append(i)

    fi = open(test_directory_result + "devblog_sections_" + str(section_id) + "_" + str(id_text) +".txt", "a")
    fi.write(str(section_id) + "\tenglish\t " + "\t " +"\t".join(this) + "\n")
    fi.close()
    id_text += 1 


    
    
if __name__ == '__main__':
    caps_directory = "C:/research_18_caps_folder/"
    less_than_five_directory = "C:/research_18_less_than_5/"
    spaces_directory = "C:/research_18_spaces/"
    finished_directory = "C:/research_18_init_files/"
    test_directory="C:/test/"
    test_directory_result= "C:/test_res/"
    process_file("C:\one")
    pass