PATH='C:\OfficeTasker\'
function filescreate()
    s=PATH+''+'Manager.mdp'
    creater= mopen(s,"w")
    mclose(creater)
   
    s=PATH+''+'Employee.mdp'
    creater= mopen(s,"w")
    mclose(creater)
	
	s=PATH+''+'Employeelist.txt'
    creater= mopen(s,"w")
    mclose(creater)
	
endfunction

// First time run only
function [fts_flag,fts_choice]=Ftsetup()
funcprot(0)
fts_flag=1;
disp("Welcome to first time setup page")

disp("Setup Manager details")    
    
    ID = input("Enter An ID for Manager : ",'string')
    Paswd = input("Enter A Password : ",'string')
    Re_Paswd = input("ReEnter Password : ",'string')
    
    if Paswd==Re_Paswd
    
    Manager_fts_file = mopen(PATH+'Manager.mdp',"w")
    mfprintf(Manager_fts_file,"%s\n%s",ID,Paswd);
    mclose(Manager_fts_file)
    
    else
    
    disp('Password and rentered password do not match , please retry')
    Paswd = input("Enter A Password : ",'string')
    Re_Paswd = input("ReEnter Password : ",'string')
    
    if Paswd==Re_Paswd
    
    Manager_fts_file = mopen(PATH+'Manager.mdp',"w")
    mfprintf(Manager_fts_file,"%s\n%s",ID,Paswd);
    mclose(Manager_fts_file)
    
    else
    
    disp('Password and rentered password do not match , Program exiting')
    mclose()
    abort
    fts_flag=0
    end
    end
    
    disp('Manager details set')
    
    disp("Setup Employee details")    
    
    E_count=input('Enter number of employees : ')
    if(E_count>=1)
    Employeelist = mopen(PATH+'Employeelist.txt',"w")
    Employee_fts_file = mopen(PATH+'Employee.mdp',"w")
    i=0;
    while(i<E_count)
    
    ID = input("Enter An ID for Employee : ",'string')
    Paswd = input("Enter A Password : ",'string')
    
    mfprintf(Employee_fts_file,"%s\n%s\n",ID,Paswd);
    mfprintf(Employeelist,"%s\n",ID);
    
    s=PATH+''+ID+'_task.tsk'
    creater= mopen(s,"w")
    mclose(creater)
    
    s=PATH+''+ID+'_taskstatus.tsk'
    creater= mopen(s,"w")
    mclose(creater)
    
    s=PATH+''+ID+'_messages.msg'
    creater= mopen(s,"w")
    mclose(creater)
    
    s=PATH+''+ID+'_managermessages.msg'
    creater= mopen(s,"w")
    mclose(creater)
    
    i=i+1;
    
    end
    mclose(Employee_fts_file)
    mclose(Employeelist)
    end
     disp('Employee details set')
    
endfunction
// end First time run only


// Employee function
function Employee(ID)
funcprot(0)
    while(1)
    disp("Welcome to the employee portal")
    disp("------MENU------")
    disp("1 : View Current Tasks")
    disp("2 : Update Task Status")
    disp("3 : Message Manager")
    disp("4 : Read Message From Manager")
    disp("5 : Logout")
    a=input('Choice : ')
    select a
    case 1
    
    EmployeeTask= mopen(PATH+''+ID+'_task.tsk',"r")
    s=''
    flag=1;
    while(flag>0)
    [flag,Employee_task]=mfscanf(EmployeeTask,"%s");
    s=s+' '+Employee_task
    end
    disp(s)
    mclose(EmployeeTask)
    
    case 2
    
    EmployeeTaskStatus= mopen(PATH+''+ID+'_taskstatus.tsk',"w")
    mfprintf(EmployeeTaskStatus,"\n%s",input("How is the task going ?  ",'string'))
    mclose(EmployeeTaskStatus)
    
    case 3
    
    EmployeeMsgManager= mopen(PATH+''+ID+'_messages.msg',"w")
    mfprintf(EmployeeMsgManager,"\n%s\n",input("Enter Subject : ",'string'))
    mfprintf(EmployeeMsgManager,"\n%s\n",input("Enter Message : ",'string'))
    mclose(EmployeeMsgManager)
    
    case 4
    
    EmployeeManagerMsg= mopen(PATH+''+ID+'_managermessages.msg',"r")
    flag=1;
    s=''
    while(flag>0)
    [flag,Manager_msg]=mfscanf(EmployeeManagerMsg,"%s");
    s=s+' '+Manager_msg
    end
    disp(s)
    mclose(EmployeeManagerMsg)
    
    case 5
    clc
    disp('Have a nice day')
    mclose()
    abort
    
    else
    
    disp('Wrong choice try again')
    
    end
    end

endfunction
// end Employee function

// deleteall function
function deleteall()
funcprot(0)    
delfile= mopen(PATH+'frstsetup.fts',"w")
mclose(delfile) 
delfile= mopen(PATH+'Employee.mdp',"w")
mclose(delfile)
delfile= mopen(PATH+'Manager.mdp',"w")
mclose(delfile)
delfile= mopen(PATH+'Manager.mdp',"w")
mclose(delfile)
delfile= mopen(PATH+'Employeelist.txt',"r")
flag=1;
while(flag>0)
[flag,Employee_ID]=mfscanf(delfile,"%s");
deletefile(PATH+''+Employee_ID+'_task.tsk')
deletefile(PATH+''+Employee_ID+'_taskstatus.tsk')
deletefile(PATH+''+Employee_ID+'_messages.msg')
deletefile(PATH+''+Employee_ID+'_managermessages.msg')
end
mclose(delfile)
delfile= mopen(PATH+'Employeelist.txt',"w")
mclose(delfile)
endfunction
// end deleteall function


// Manager function
function Manager()
    funcprot(0)
    disp("Welcome Mr. Manager")
    while(1)
    disp("------MENU------")
    disp("1 : View Employee list")
    disp("2 : Assign task to employee")
    disp("3 : See current task status of an employee")
    disp("4 : Read messages from employee")
    disp("5 : Message an employee")
    disp("6 : Logout")
    a=input('Choice : ')
    
    select a
    
    case 1
    
    EmployeeList= mopen(PATH+'Employeelist.txt',"r")
    flag=1;
    while(flag>0)
    [flag,Employee_ID]=mfscanf(EmployeeList,"%s");
    disp(Employee_ID)
    end
    mclose(EmployeeList)
    
    case 2
    
    Assign_File_ID=input('Enter Employee ID : ','string')
    while(1)
    if(verify(Assign_File_ID)==1)
    break;
    end
    disp('Enter correct ID')
    Assign_File_ID=input('Enter Employee ID : ','string')
    end
    File=mopen(PATH+''+Assign_File_ID+'_task.tsk','a')
    mfprintf(File,"\n")
    mfprintf(File,"%s%s\n"," Task Details : ",input("Enter task details : ",'string'))
    mfprintf(File,"%s%s\n"," Task Duration : ",input("Enter task duration : ",'string'))
    mclose(File)
    
    case 3
    
    Assign_File_ID=input('Enter Employee ID : ','string')
    while(1)
     
    if(verify(Assign_File_ID)==1)
    break;
    end
    disp('Enter correct ID')
    Assign_File_ID=input('Enter Employee ID : ','string')
    end
    
    EmployeeStatus= mopen(PATH+''+Assign_File_ID+'_taskstatus.tsk',"r")
    flag=1;
    s=''
    while(flag>0)
    [flag,Employee_status]=mfscanf(EmployeeStatus,"%s");
    s=s+' '+Employee_status
    end
    disp(s)
    mclose(EmployeeStatus)
    
    case 4

    Assign_File_ID=input('Enter Employee ID : ','string')
    while(1)
    if(verify(Assign_File_ID)==1)
    break;
    end
    disp('Enter correct ID')
    Assign_File_ID=input('Enter Employee ID : ','string')
    end
    flag=1
    s=''
    EmployeeMsg= mopen(PATH+''+Assign_File_ID+'_messages.msg',"r")
    while(flag>0)
    [flag,Employee_message]=mfscanf(EmployeeMsg,"%s");
    s=s+' '+Employee_message
    end
    disp(s)
    mclose(EmployeeMsg)

    case 5
    
    Assign_File_ID=input('Enter Employee ID : ','string')
    while(1)
    if(verify(Assign_File_ID)==1)
    break;
    end
    disp('Enter correct ID')
    Assign_File_ID=input('Enter Employee ID : ','string')
    end
    ManagerMsg= mopen(PATH+''+Assign_File_ID+'_managermessages.msg',"w")
    mfprintf(ManagerMsg,"\n")
    mfprintf(ManagerMsg,"%s\n", input("Enter your message : ",'string'))
    mclose(ManagerMsg)
    
    case 6
    
    clc
    disp('Have a nice day') 
    mclose()   
    abort  
    else
    disp('Wrong choice try again')
    end  
    
    end
endfunction
// end Manager function


// Manager tasks below
//
function [flag]=verify(verification)
    funcprot(0)
    flag =0
    f=1
    Employee_file= mopen(PATH+'Employee.mdp',"r")
    while(f>0)
    [f,Employee_ID]=mfscanf(Employee_file,"%s");
    if(Employee_ID==verification)
    flag=1
    break;
    end
    end
    mclose(Employee_file)

endfunction
//
// Manager tasks above


// M_login function
function [Mlogin_flag]=M_login()
    funcprot(0)
    Mlogin_flag=0;
    
    ID = input("Enter Your ID : ",'string')
    Paswd = input("Enter Your Password : ",'string')
    
    Manager_file= mopen(PATH+'Manager.mdp',"r")
    Manager_ID=mfscanf(Manager_file,"%s");
    Manager_Paswd=mfscanf(Manager_file,"%s");
    mclose(Manager_file)
    if ID==Manager_ID & Paswd==Manager_Paswd
    
    Mlogin_flag=1;
    
    end
endfunction
// end M_login function


// E_login function
function [Elogin_flag,ID]=E_login()
    funcprot(0)
    flag=1;
    Elogin_flag=0;
    
    ID = input("Enter Your ID : ",'string')
    Paswd = input("Enter Your Password : ",'string')
    
    Employee_file= mopen(PATH+'Employee.mdp',"r")
    while(flag>0)
    
    [flag,Employee_ID]=mfscanf(Employee_file,"%s");
    Employee_Paswd=mfscanf(Employee_file,"%s");
    if ID==Employee_ID & Paswd==Employee_Paswd
    
    Elogin_flag=1;
    break
    
    end
    end

    mclose(Employee_file)

endfunction
// end E_login function


// Main function
function main()
    funcprot(0)
    
    fts_file= mopen(PATH+'frstsetup.fts',"r")
    [fts_flag]=mfscanf(fts_file,"%d");
    mclose(fts_file) 

    if fts_flag==1
    
    login_flag=input("For MANAGER login enter 1 for EMPLOYEE login enter 2 : ")
    
    if login_flag==1
    
    Mlogin_flag=M_login()
    
    if Mlogin_flag==1
    Manager()
    else
    
    disp('Wrong Details Entered Program Exiting' )
    mclose()
    abort

    end    
    elseif login_flag==2
    
    [Elogin_flag,ID]=E_login()
    
    if Elogin_flag==1
        
    Employee(ID)
    
    else
    
    disp('Wrong Password Entered Program Exiting' )
    mclose()
    abort
    
    end
    elseif login_flag=="GoWiPe"
    
    deleteall()
    
    else
    
    disp('Please Restart The Program and enter the correct choice next time')
    mclose()
    abort
    
    end
    else 
    filescreate()
    [fts_flag]=Ftsetup()
    
    if fts_flag==1
    
    fts_file1 = mopen(PATH+'frstsetup.fts',"w")
    mfprintf(fts_file1,"%d",1);
    mclose(fts_file1)
    
    end  
    
    end
endfunction
// Main function

main()
